module("projbooter.hotupdate.VersionValidator", package.seeall)

slot0 = class("VersionValidator")

function slot0.ctor(slot0)
	slot0._isInReview = false
	slot0._eventMgr = SLFramework.GameUpdate.HotUpdateEvent
	slot0._eventMgrInst = SLFramework.GameUpdate.HotUpdateEvent.Instance
end

function slot0.isInReviewing(slot0, slot1)
	if slot1 then
		return slot0._isInReview
	else
		return BootNativeUtil.isIOS() and slot0._isInReview
	end
end

function slot0.start(slot0, slot1, slot2)
	if GameResMgr.IsFromEditorDir then
		if slot1 then
			if slot2 then
				slot1(slot2)
			else
				slot1()
			end
		end

		return
	end

	if slot1 then
		slot0._finishCb = slot1
		slot0._finishObj = slot2

		slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.GetRemoteVersionFail, slot0._onGetRemoteVersionFail, slot0)
		slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.GetRemoteVersionSuccess, slot0._onGetRemoteVersionSuccess, slot0)
	end

	slot3, slot4 = GameUrlConfig.getHotUpdateUrl()
	slot5 = HotUpdateMgr.instance:getUseBackup() and slot4 or slot3
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
	BootMsgBox.instance:show({
		title = booterLang("version_validate"),
		content = booterLang("version_validate_fail") .. slot1,
		leftMsg = booterLang("exit"),
		leftCb = slot0._quitGame,
		leftCbObj = slot0,
		rightMsg = booterLang("retry"),
		rightCb = slot0._retry,
		rightCbObj = slot0
	})
end

function slot0._quitGame(slot0)
	logNormal("重试超过了 " .. HotUpdateMgr.FailAlertCount .. " 次，点击了退出按钮！")
	ProjBooter.instance:quitGame()
end

function slot0._retry(slot0)
	logNormal("重试超过了 " .. HotUpdateMgr.FailAlertCount .. " 次，点击了重试按钮！")
	slot0:start()
	HotUpdateMgr.instance:showConnectTips()
end

function slot0._onGetRemoteVersionSuccess(slot0, slot1, slot2, slot3, slot4, slot5)
	SDKDataTrackMgr.instance:trackDomainFailCount("scene_hotupdate_versioncheck", HotUpdateMgr.instance:getDomainUrl(), HotUpdateMgr.instance:getFailCount())
	HotUpdateMgr.instance:resetFailCount()
	logNormal("版本检查 _onGetRemoteVersionSuccess version = " .. slot1 .. " inReview = " .. tostring(slot2) .. " loginUrl = " .. slot3 .. " envType = " .. slot4)
	SDKDataTrackMgr.instance:trackGetRemoteVersionEvent(SDKDataTrackMgr.RequestResult.success, slot5)

	slot0._isInReview = slot2

	if slot0._finishCb then
		slot0._eventMgrInst:ClearLuaListener()
		slot0._finishCb(slot0._finishObj, slot1, slot2, slot3, slot4)

		slot0._finishCb = nil
		slot0._finishObj = nil
	end
end

function slot0._onGetRemoteVersionFail(slot0, slot1, slot2, slot3)
	logNormal("版本检查 _onGetRemoteVersionFail errorInfo = " .. slot1)
	SDKDataTrackMgr.instance:trackGetRemoteVersionEvent(SDKDataTrackMgr.RequestResult.fail, slot3, slot2, slot1)
	HotUpdateMgr.instance:inverseUseBackup()
	HotUpdateMgr.instance:incFailCount()

	if HotUpdateMgr.instance:isFailNeedAlert() then
		HotUpdateMgr.instance:resetFailAlertCount()
		slot0:_onRetryCountOver(slot1)
		BootLoadingView.instance:setProgressMsg("")

		return
	end

	slot0:start()
	HotUpdateMgr.instance:showConnectTips()
end

slot0.instance = slot0.New()

return slot0
