module("projbooter.hotupdate.VersionValidator", package.seeall)

local var_0_0 = class("VersionValidator")

function var_0_0.ctor(arg_1_0)
	arg_1_0._isInReview = false
	arg_1_0._eventMgr = SLFramework.GameUpdate.HotUpdateEvent
	arg_1_0._eventMgrInst = SLFramework.GameUpdate.HotUpdateEvent.Instance
end

function var_0_0.isInReviewing(arg_2_0, arg_2_1)
	if arg_2_1 then
		return arg_2_0._isInReview
	else
		return BootNativeUtil.isIOS() and arg_2_0._isInReview
	end
end

function var_0_0.start(arg_3_0, arg_3_1, arg_3_2)
	if GameResMgr.IsFromEditorDir then
		if arg_3_1 then
			if arg_3_2 then
				arg_3_1(arg_3_2)
			else
				arg_3_1()
			end
		end

		return
	end

	if arg_3_1 then
		arg_3_0._finishCb = arg_3_1
		arg_3_0._finishObj = arg_3_2

		arg_3_0._eventMgrInst:AddLuaLisenter(arg_3_0._eventMgr.GetRemoteVersionFail, arg_3_0._onGetRemoteVersionFail, arg_3_0)
		arg_3_0._eventMgrInst:AddLuaLisenter(arg_3_0._eventMgr.GetRemoteVersionSuccess, arg_3_0._onGetRemoteVersionSuccess, arg_3_0)
	end

	local var_3_0, var_3_1 = GameUrlConfig.getHotUpdateUrl()
	local var_3_2 = HotUpdateMgr.instance:getUseBackup() and var_3_1 or var_3_0
	local var_3_3 = SDKMgr.instance:getGameId()
	local var_3_4 = SLFramework.FrameworkSettings.CurPlatform

	if SLFramework.FrameworkSettings.IsEditor then
		var_3_4 = 0
	end

	local var_3_5 = SDKMgr.instance:getChannelId()
	local var_3_6 = SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr
	local var_3_7 = tonumber(BootNativeUtil.getAppVersion())
	local var_3_8 = BootNativeUtil.getPackageName()
	local var_3_9 = SDKMgr.instance:getSubChannelId()

	logNormal("subChannelId = " .. var_3_9)
	logNormal("domain = " .. var_3_2 .. " gameId = " .. var_3_3 .. " osType = " .. var_3_4 .. " channelId = " .. var_3_5 .. " resVersion = " .. var_3_6 .. " appVersion = " .. var_3_7 .. " packageName = " .. var_3_8 .. " subChannelId = " .. var_3_9)

	local var_3_10 = GameChannelConfig.getServerType()

	arg_3_0._eventMgrInst:CheckVersion(var_3_2, var_3_3, var_3_4, var_3_5, var_3_10, var_3_6, var_3_7, var_3_8, var_3_9)
end

function var_0_0._onRetryCountOver(arg_4_0, arg_4_1)
	local var_4_0 = {
		title = booterLang("version_validate"),
		content = booterLang("version_validate_fail") .. arg_4_1,
		leftMsg = booterLang("exit"),
		leftCb = arg_4_0._quitGame,
		leftCbObj = arg_4_0,
		rightMsg = booterLang("retry"),
		rightCb = arg_4_0._retry,
		rightCbObj = arg_4_0
	}

	BootMsgBox.instance:show(var_4_0)
end

function var_0_0._quitGame(arg_5_0)
	logNormal("重试超过了 " .. HotUpdateMgr.FailAlertCount .. " 次，点击了退出按钮！")
	ProjBooter.instance:quitGame()
end

function var_0_0._retry(arg_6_0)
	logNormal("重试超过了 " .. HotUpdateMgr.FailAlertCount .. " 次，点击了重试按钮！")
	arg_6_0:start()
	HotUpdateMgr.instance:showConnectTips()
end

function var_0_0._onGetRemoteVersionSuccess(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	local var_7_0 = HotUpdateMgr.instance:getDomainUrl()

	SDKDataTrackMgr.instance:trackDomainFailCount("scene_hotupdate_versioncheck", var_7_0, HotUpdateMgr.instance:getFailCount())
	HotUpdateMgr.instance:resetFailCount()
	logNormal("版本检查 _onGetRemoteVersionSuccess version = " .. arg_7_1 .. " inReview = " .. tostring(arg_7_2) .. " loginUrl = " .. arg_7_3 .. " envType = " .. arg_7_4)
	SDKDataTrackMgr.instance:trackGetRemoteVersionEvent(SDKDataTrackMgr.RequestResult.success, arg_7_5)

	arg_7_0._isInReview = arg_7_2

	if arg_7_0._finishCb then
		arg_7_0._eventMgrInst:ClearLuaListener()
		arg_7_0._finishCb(arg_7_0._finishObj, arg_7_1, arg_7_2, arg_7_3, arg_7_4)

		arg_7_0._finishCb = nil
		arg_7_0._finishObj = nil
	end
end

function var_0_0._onGetRemoteVersionFail(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	logNormal("版本检查 _onGetRemoteVersionFail errorInfo = " .. arg_8_1)
	SDKDataTrackMgr.instance:trackGetRemoteVersionEvent(SDKDataTrackMgr.RequestResult.fail, arg_8_3, arg_8_2, arg_8_1)
	HotUpdateMgr.instance:inverseUseBackup()
	HotUpdateMgr.instance:incFailCount()

	if HotUpdateMgr.instance:isFailNeedAlert() then
		HotUpdateMgr.instance:resetFailAlertCount()
		arg_8_0:_onRetryCountOver(arg_8_1)
		BootLoadingView.instance:setProgressMsg("")

		return
	end

	arg_8_0:start()
	HotUpdateMgr.instance:showConnectTips()
end

var_0_0.instance = var_0_0.New()

return var_0_0
