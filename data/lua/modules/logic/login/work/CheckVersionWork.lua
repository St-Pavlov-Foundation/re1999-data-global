module("modules.logic.login.work.CheckVersionWork", package.seeall)

local var_0_0 = class("CheckVersionWork", BaseWork)
local var_0_1 = 5
local var_0_2

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tryCallBack = arg_1_1
	arg_1_0._tryCallBackObj = arg_1_2
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	if GameResMgr.IsFromEditorDir or not GameConfig.CanHotUpdate then
		arg_2_0:onDone(true)
	elseif var_0_2 and Time.time - var_0_2 < var_0_1 then
		arg_2_0:onDone(true)
	else
		var_0_2 = Time.time
		arg_2_0._maxRetryCount = 2
		arg_2_0._curRetryCount = 0
		arg_2_0._failCount = 0

		arg_2_0:_start(arg_2_0._onCheckVersion, arg_2_0)
	end
end

function var_0_0._onCheckVersion(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	UIBlockMgr.instance:endBlock("LoginCheckVersion")

	if BootNativeUtil.isIOS() and arg_3_2 or SLFramework.GameUpdate.HotUpdateInfoMgr.IsLatestVersion then
		arg_3_0:onDone(true)
	else
		arg_3_0:onDone(false)
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.NewGameVersion, MsgBoxEnum.BoxType.Yes, function()
			if BootNativeUtil.isAndroid() then
				if SDKMgr.restartGame ~= nil then
					SDKMgr.instance:restartGame()
				else
					ProjBooter.instance:quitGame()
				end
			else
				ProjBooter.instance:quitGame()
			end
		end)
	end
end

function var_0_0._start(arg_5_0, arg_5_1, arg_5_2)
	UIBlockMgr.instance:startBlock("LoginCheckVersion")

	arg_5_0._eventMgr = SLFramework.GameUpdate.HotUpdateEvent
	arg_5_0._eventMgrInst = SLFramework.GameUpdate.HotUpdateEvent.Instance

	if arg_5_1 then
		arg_5_0._finishCb = arg_5_1
		arg_5_0._finishObj = arg_5_2

		arg_5_0._eventMgrInst:AddLuaLisenter(arg_5_0._eventMgr.GetRemoteVersionFail, arg_5_0._onGetRemoteVersionFail, arg_5_0)
		arg_5_0._eventMgrInst:AddLuaLisenter(arg_5_0._eventMgr.GetRemoteVersionSuccess, arg_5_0._onGetRemoteVersionSuccess, arg_5_0)
	end

	local var_5_0, var_5_1 = GameUrlConfig.getHotUpdateUrl()
	local var_5_2 = LoginModel.instance:getUseBackup() and var_5_1 or var_5_0
	local var_5_3 = SDKMgr.instance:getGameId()
	local var_5_4 = SLFramework.FrameworkSettings.CurPlatform

	if SLFramework.FrameworkSettings.IsEditor then
		var_5_4 = 0
	end

	local var_5_5 = SDKMgr.instance:getChannelId()
	local var_5_6 = SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr
	local var_5_7 = tonumber(BootNativeUtil.getAppVersion())
	local var_5_8 = BootNativeUtil.getPackageName()
	local var_5_9 = SDKMgr.instance:getSubChannelId()

	logNormal("subChannelId = " .. var_5_9)
	logNormal("domain = " .. var_5_2 .. " gameId = " .. var_5_3 .. " osType = " .. var_5_4 .. " channelId = " .. var_5_5 .. " resVersion = " .. var_5_6 .. " appVersion = " .. var_5_7 .. " packageName = " .. var_5_8 .. " subChannelId = " .. var_5_9)

	local var_5_10 = GameChannelConfig.getServerType()

	arg_5_0._eventMgrInst:CheckVersion(var_5_2, var_5_3, var_5_4, var_5_5, var_5_10, var_5_6, var_5_7, var_5_8, var_5_9)
end

function var_0_0._onRetryCountOver(arg_6_0, arg_6_1)
	UIBlockMgr.instance:endBlock("LoginCheckVersion")
	MessageBoxController.instance:showSystemMsgBoxAndSetBtn(MessageBoxIdDefine.CheckVersionFail, MsgBoxEnum.BoxType.Yes_No, booterLang("retry"), "retry", booterLang("exit"), "exit", arg_6_0._retry, arg_6_0._quitGame, nil, arg_6_0, arg_6_0, nil, arg_6_1)
end

function var_0_0._quitGame(arg_7_0)
	logNormal("重试超过了 " .. arg_7_0._maxRetryCount .. " 次，点击了退出按钮！")
	ProjBooter.instance:quitGame()
end

function var_0_0._retry(arg_8_0)
	logNormal("重试超过了 " .. arg_8_0._maxRetryCount .. " 次，点击了重试按钮！")

	if arg_8_0._tryCallBack then
		arg_8_0._tryCallBack(arg_8_0._tryCallBackObj)
	else
		arg_8_0:_start()
	end
end

function var_0_0._onGetRemoteVersionSuccess(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	if arg_9_0._failCount > 0 then
		local var_9_0, var_9_1 = GameUrlConfig.getHotUpdateUrl()
		local var_9_2 = LoginModel.instance:getUseBackup() and var_9_1 or var_9_0

		StatController.instance:track(StatEnum.EventName.EventHostSwitch, {
			[StatEnum.EventProperties.GameScene] = "scene_hotupdate_versioncheck",
			[StatEnum.EventProperties.CurrentHost] = var_9_2,
			[StatEnum.EventProperties.SwitchCount] = arg_9_0._failCount
		})

		arg_9_0._failCount = 0
	end

	logNormal("版本检查 _onGetRemoteVersionSuccess version = " .. arg_9_1 .. " inReview = " .. tostring(arg_9_2) .. " loginUrl = " .. arg_9_3 .. " envType = " .. arg_9_4)
	SDKDataTrackMgr.instance:trackGetRemoteVersionEvent(SDKDataTrackMgr.RequestResult.success, arg_9_5)

	arg_9_0._isInReview = arg_9_2

	if arg_9_0._finishCb then
		arg_9_0._eventMgrInst:ClearLuaListener()
		arg_9_0._finishCb(arg_9_0._finishObj, arg_9_1, arg_9_2, arg_9_3, arg_9_4)

		arg_9_0._finishCb = nil
		arg_9_0._finishObj = nil
	end
end

function var_0_0._onGetRemoteVersionFail(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	logNormal("版本检查 _onGetRemoteVersionFail errorInfo = " .. arg_10_1)
	SDKDataTrackMgr.instance:trackGetRemoteVersionEvent(SDKDataTrackMgr.RequestResult.fail, arg_10_3, arg_10_2, arg_10_1)
	LoginModel.instance:inverseUseBackup()

	arg_10_0._failCount = arg_10_0._failCount and arg_10_0._failCount + 1 or 1

	if arg_10_0._curRetryCount >= arg_10_0._maxRetryCount then
		arg_10_0._curRetryCount = 0

		arg_10_0:_onRetryCountOver(arg_10_1)
		UIBlockMgrExtend.instance:setTips()
	else
		arg_10_0._curRetryCount = arg_10_0._curRetryCount + 1

		arg_10_0:_start()
		UIBlockMgrExtend.instance:setTips(LoginModel.instance:getFailCountBlockStr(arg_10_0._curRetryCount))
	end
end

function var_0_0.clearWork(arg_11_0)
	if arg_11_0._eventMgrInst then
		arg_11_0._eventMgrInst:ClearLuaListener()
	end

	UIBlockMgr.instance:endBlock("LoginCheckVersion")
end

return var_0_0
