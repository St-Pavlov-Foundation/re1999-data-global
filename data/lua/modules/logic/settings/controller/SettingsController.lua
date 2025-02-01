module("modules.logic.settings.controller.SettingsController", package.seeall)

slot0 = class("SettingsController", BaseController)

function slot0.openView(slot0)
	ViewMgr.instance:openView(ViewName.SettingsView, {
		cateList = SettingsModel.instance:getSettingsCategoryList()
	})
end

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	AudioMgr.instance:registerCallback(AudioMgr.Evt_ChangeFinish, slot0._onChangeFinish, slot0)
	LoginController.instance:registerCallback(LoginEvent.OnLoginEnterMainScene, slot0._onLoginFinish, slot0)
end

function slot0.reInit(slot0)
	slot0:checkRecordLogout()
end

function slot0.changeLangTxt(slot0)
	UIBlockMgr.instance:startBlock("SettingsController:changeLangTxt")

	slot0._fontAssetDone = false
	slot0._changeLangDelaytDone = false

	GameGlobalMgr.instance:getLangFont():changeFontAsset(slot0._changeLangFontAssetCallBack, slot0)
	GameGlobalMgr.instance:getLangFont():ControlDoubleEn()
	ViewMgr.instance:closeAllViews({
		ViewName.SettingsView,
		ViewName.PlayerIdView,
		ViewName.WaterMarkView
	})
	ViewDestroyMgr.instance:destroyImmediately()
	TaskDispatcher.runDelay(uv0._changeLangTxtDelay, slot0, 0.01)
end

function slot0._changeLangFontAssetCallBack(slot0)
	slot0._fontAssetDone = true

	slot0:_changeLang2()
end

function slot0._changeLangTxtDelay(slot0)
	slot0._changeLangDelaytDone = true

	slot0:_changeLang2()
end

function slot0._changeLang2(slot0)
	if slot0._fontAssetDone and slot0._changeLangDelaytDone then
		GameGCMgr.instance:dispatchEvent(GameGCEvent.ResGC, slot0)
		ViewMgr.instance:openView(ViewName.MainView)
		uv0.instance:dispatchEvent(SettingsEvent.OnChangeLangTxt)

		if LangSettings.aihelpKey[GameConfig:GetCurLangType()] then
			SDKMgr.instance:setLanguage(slot2)
		else
			logError("aihelpKey miss :" .. slot1)
		end

		UIBlockMgr.instance:endBlock("SettingsController:changeLangTxt")
	end
end

function slot0.getStoryVoiceType(slot0)
	if PlayerPrefsHelper.getString(PlayerPrefsKey.VoiceTypeKey_Story) == nil then
		PlayerPrefsHelper.setString(PlayerPrefsKey.VoiceTypeKey_Story, GameConfig:GetCurVoiceShortcut())
	end

	return slot1
end

function slot0.checkRecordLogout(slot0)
	logNormal("SettingsController:checkRecordLogout()")

	if not SDKMgr.isSupportRecord or not SDKMgr.instance:isSupportRecord() then
		return
	end

	if SDKMgr.instance:isRecording() then
		SDKMgr.instance:stopRecord()
	end

	SDKMgr.instance:hideRecordBubble()
end

function slot0._onLoginFinish(slot0)
	logNormal("SettingsController:_onLoginFinish()")

	if SettingsShowHelper.canShowRecordVideo() and SettingsModel.instance:getRecordVideo() then
		SDKMgr.instance:showRecordBubble()
	end

	if SDKMgr.instance:isEmulator() and PlayerPrefsHelper.getNumber(PlayerPrefsKey.EmulatorVideoCompatible, 0) ~= 2 then
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.EmulatorVideoCompatible, slot3)
		SettingsModel.instance:setVideoCompatible(slot3 == 1)
	end
end

function slot0.checkSwitchRecordVideo(slot0)
	if SettingsShowHelper.canShowRecordVideo() then
		if not SettingsModel.instance:getRecordVideo() then
			if BootNativeUtil.isAndroid() then
				SDKMgr.instance:requestReadAndWritePermission()
			end

			SDKMgr.instance:showRecordBubble()
		else
			if SDKMgr.instance:isRecording() then
				GameFacade.showToast(ToastEnum.RecordingVideoSwitchOff)

				return false
			end

			SDKMgr.instance:hideRecordBubble()
		end

		SettingsModel.instance:setRecordVideo(slot1)

		return true
	end

	return false
end

function slot0._onChangeFinish(slot0)
	slot0._inSwitch = false
end

slot0.instance = slot0.New()

return slot0
