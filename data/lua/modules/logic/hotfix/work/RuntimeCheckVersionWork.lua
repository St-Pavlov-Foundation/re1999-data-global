module("modules.logic.hotfix.work.RuntimeCheckVersionWork", package.seeall)

slot0 = class("RuntimeCheckVersionWork", BaseWork)

function slot0.ctor(slot0, slot1, slot2)
	slot0._tryCallBack = slot1
	slot0._tryCallBackObj = slot2
end

function slot0.onStart(slot0, slot1)
	if GameResMgr.IsFromEditorDir or not GameConfig.CanHotUpdate then
		slot0:onDone(true)
	else
		slot0:_start(slot0._onCheckVersion, slot0)
	end
end

slot0.UIBLOCK_KEY = "RuntimeCheckVersionWork"

function slot0._onCheckVersion(slot0, slot1, slot2, slot3, slot4, slot5)
	UIBlockMgr.instance:endBlock(uv0.UIBLOCK_KEY)

	if BootNativeUtil.isIOS() and slot2 or SLFramework.GameUpdate.HotUpdateInfoMgr.IsLatestVersion or not slot5 then
		slot0:onDone(true)
	else
		slot0:onDone(false)
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.RuntimeCheckVersionHotfix, MsgBoxEnum.BoxType.Yes, slot0.restartGame, nil, , slot0)
	end
end

function slot0.restartGame(slot0)
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

function slot0._start(slot0, slot1, slot2)
	UIBlockMgr.instance:startBlock(uv0.UIBLOCK_KEY)

	slot0._eventMgr = SLFramework.GameUpdate.HotUpdateEvent
	slot0._eventMgrInst = SLFramework.GameUpdate.HotUpdateEvent.Instance

	if slot1 then
		slot0._finishCb = slot1
		slot0._finishObj = slot2

		slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.GetRemoteVersionFail, slot0._onGetRemoteVersionFail, slot0)
		slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.GetRemoteVersionSuccess, slot0._onGetRemoteVersionSuccess, slot0)
	end

	slot3, slot4 = GameUrlConfig.getHotUpdateUrl()
	slot5 = LoginModel.instance:getUseBackup() and slot4 or slot3
	slot6 = SDKMgr.instance:getGameId()
	slot7 = SLFramework.FrameworkSettings.CurPlatform

	if SLFramework.FrameworkSettings.IsEditor then
		slot7 = 0
	end

	slot8 = SDKMgr.instance:getChannelId()
	slot9 = SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr
	slot10 = tonumber(BootNativeUtil.getAppVersion())
	slot11 = BootNativeUtil.getPackageName()
	slot12 = SDKMgr.instance:getSubChannelId()

	logNormal("subChannelId = " .. slot12)
	logNormal("domain = " .. slot5 .. " gameId = " .. slot6 .. " osType = " .. slot7 .. " channelId = " .. slot8 .. " resVersion = " .. slot9 .. " appVersion = " .. slot10 .. " packageName = " .. slot11 .. " subChannelId = " .. slot12)
	slot0._eventMgrInst:CheckVersion(slot5, slot6, slot7, slot8, GameChannelConfig.getServerType(), slot9, slot10, slot11, slot12)
end

function slot0._onRetryCountOver(slot0, slot1)
	UIBlockMgr.instance:endBlock(uv0.UIBLOCK_KEY)
	slot0:onDone(false)
end

function slot0._onGetRemoteVersionSuccess(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	LoginModel.instance:resetFailCount()
	logNormal("版本检查 _onGetRemoteVersionSuccess version = " .. slot1 .. " inReview = " .. tostring(slot2) .. " loginUrl = " .. slot3 .. " envType = " .. slot4 .. ", forceUpdate = " .. tostring(slot6))

	slot0._isInReview = slot2

	if slot0._finishCb then
		slot0._eventMgrInst:ClearLuaListener()
		slot0._finishCb(slot0._finishObj, slot1, slot2, slot3, slot4, slot6)

		slot0._finishCb = nil
		slot0._finishObj = nil
	end
end

function slot0._onGetRemoteVersionFail(slot0, slot1, slot2, slot3)
	logNormal("版本检查 _onGetRemoteVersionFail errorInfo = " .. slot1)
	LoginModel.instance:inverseUseBackup()
	LoginModel.instance:incFailCount()

	if LoginModel.instance:isFailNeedAlert() then
		LoginModel.instance:resetFailAlertCount()
		slot0:_onRetryCountOver(slot1)
	else
		slot0:_start()
	end
end

function slot0.clearWork(slot0)
	if slot0._eventMgrInst then
		slot0._eventMgrInst:ClearLuaListener()
	end

	UIBlockMgr.instance:endBlock(uv0.UIBLOCK_KEY)
end

return slot0
