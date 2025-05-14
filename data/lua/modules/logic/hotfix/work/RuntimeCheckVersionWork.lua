module("modules.logic.hotfix.work.RuntimeCheckVersionWork", package.seeall)

local var_0_0 = class("RuntimeCheckVersionWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tryCallBack = arg_1_1
	arg_1_0._tryCallBackObj = arg_1_2
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	if GameResMgr.IsFromEditorDir or not GameConfig.CanHotUpdate then
		arg_2_0:onDone(true)
	else
		arg_2_0:_start(arg_2_0._onCheckVersion, arg_2_0)
	end
end

var_0_0.UIBLOCK_KEY = "RuntimeCheckVersionWork"

function var_0_0._onCheckVersion(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	UIBlockMgr.instance:endBlock(var_0_0.UIBLOCK_KEY)

	if BootNativeUtil.isIOS() and arg_3_2 or SLFramework.GameUpdate.HotUpdateInfoMgr.IsLatestVersion or not arg_3_5 then
		arg_3_0:onDone(true)
	else
		arg_3_0:onDone(false)
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.RuntimeCheckVersionHotfix, MsgBoxEnum.BoxType.Yes, arg_3_0.restartGame, nil, nil, arg_3_0)
	end
end

function var_0_0.restartGame(arg_4_0)
	if BootNativeUtil.isAndroid() then
		if SDKMgr.restartGame ~= nil then
			SDKMgr.instance:restartGame()
		else
			ProjBooter.instance:quitGame()
		end
	else
		ProjBooter.instance:quitGame()
	end
end

function var_0_0._start(arg_5_0, arg_5_1, arg_5_2)
	UIBlockMgr.instance:startBlock(var_0_0.UIBLOCK_KEY)

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
	UIBlockMgr.instance:endBlock(var_0_0.UIBLOCK_KEY)
	arg_6_0:onDone(false)
end

function var_0_0._onGetRemoteVersionSuccess(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6)
	LoginModel.instance:resetFailCount()
	logNormal("版本检查 _onGetRemoteVersionSuccess version = " .. arg_7_1 .. " inReview = " .. tostring(arg_7_2) .. " loginUrl = " .. arg_7_3 .. " envType = " .. arg_7_4 .. ", forceUpdate = " .. tostring(arg_7_6))

	arg_7_0._isInReview = arg_7_2

	if arg_7_0._finishCb then
		arg_7_0._eventMgrInst:ClearLuaListener()
		arg_7_0._finishCb(arg_7_0._finishObj, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_6)

		arg_7_0._finishCb = nil
		arg_7_0._finishObj = nil
	end
end

function var_0_0._onGetRemoteVersionFail(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	logNormal("版本检查 _onGetRemoteVersionFail errorInfo = " .. arg_8_1)
	LoginModel.instance:inverseUseBackup()
	LoginModel.instance:incFailCount()

	if LoginModel.instance:isFailNeedAlert() then
		LoginModel.instance:resetFailAlertCount()
		arg_8_0:_onRetryCountOver(arg_8_1)
	else
		arg_8_0:_start()
	end
end

function var_0_0.clearWork(arg_9_0)
	if arg_9_0._eventMgrInst then
		arg_9_0._eventMgrInst:ClearLuaListener()
	end

	UIBlockMgr.instance:endBlock(var_0_0.UIBLOCK_KEY)
end

return var_0_0
