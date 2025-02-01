module("modules.logic.login.work.CheckVersionWork", package.seeall)

slot0 = class("CheckVersionWork", BaseWork)
slot1 = 5
slot2 = nil

function slot0.ctor(slot0, slot1, slot2)
	slot0._tryCallBack = slot1
	slot0._tryCallBackObj = slot2
end

function slot0.onStart(slot0, slot1)
	if GameResMgr.IsFromEditorDir or not GameConfig.CanHotUpdate then
		slot0:onDone(true)
	elseif uv0 and Time.time - uv0 < uv1 then
		slot0:onDone(true)
	else
		uv0 = Time.time
		slot0._maxRetryCount = 2
		slot0._curRetryCount = 0
		slot0._failCount = 0

		slot0:_start(slot0._onCheckVersion, slot0)
	end
end

function slot0._onCheckVersion(slot0, slot1, slot2, slot3, slot4)
	UIBlockMgr.instance:endBlock("LoginCheckVersion")

	if BootNativeUtil.isIOS() and slot2 or SLFramework.GameUpdate.HotUpdateInfoMgr.IsLatestVersion then
		slot0:onDone(true)
	else
		slot0:onDone(false)
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.NewGameVersion, MsgBoxEnum.BoxType.Yes, function ()
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

function slot0._start(slot0, slot1, slot2)
	UIBlockMgr.instance:startBlock("LoginCheckVersion")

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
	UIBlockMgr.instance:endBlock("LoginCheckVersion")
	MessageBoxController.instance:showSystemMsgBoxAndSetBtn(MessageBoxIdDefine.CheckVersionFail, MsgBoxEnum.BoxType.Yes_No, booterLang("retry"), "retry", booterLang("exit"), "exit", slot0._retry, slot0._quitGame, nil, slot0, slot0, nil, slot1)
end

function slot0._quitGame(slot0)
	logNormal("重试超过了 " .. slot0._maxRetryCount .. " 次，点击了退出按钮！")
	ProjBooter.instance:quitGame()
end

function slot0._retry(slot0)
	logNormal("重试超过了 " .. slot0._maxRetryCount .. " 次，点击了重试按钮！")

	if slot0._tryCallBack then
		slot0._tryCallBack(slot0._tryCallBackObj)
	else
		slot0:_start()
	end
end

function slot0._onGetRemoteVersionSuccess(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0._failCount > 0 then
		slot6, slot7 = GameUrlConfig.getHotUpdateUrl()

		StatController.instance:track(StatEnum.EventName.EventHostSwitch, {
			[StatEnum.EventProperties.GameScene] = "scene_hotupdate_versioncheck",
			[StatEnum.EventProperties.CurrentHost] = LoginModel.instance:getUseBackup() and slot7 or slot6,
			[StatEnum.EventProperties.SwitchCount] = slot0._failCount
		})

		slot0._failCount = 0
	end

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
	LoginModel.instance:inverseUseBackup()

	slot0._failCount = slot0._failCount and slot0._failCount + 1 or 1

	if slot0._maxRetryCount <= slot0._curRetryCount then
		slot0._curRetryCount = 0

		slot0:_onRetryCountOver(slot1)
		UIBlockMgrExtend.instance:setTips()
	else
		slot0._curRetryCount = slot0._curRetryCount + 1

		slot0:_start()
		UIBlockMgrExtend.instance:setTips(LoginModel.instance:getFailCountBlockStr(slot0._curRetryCount))
	end
end

function slot0.clearWork(slot0)
	if slot0._eventMgrInst then
		slot0._eventMgrInst:ClearLuaListener()
	end

	UIBlockMgr.instance:endBlock("LoginCheckVersion")
end

return slot0
