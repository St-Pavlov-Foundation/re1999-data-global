module("modules.logic.settings.controller.SettingsController", package.seeall)

local var_0_0 = class("SettingsController", BaseController)

function var_0_0.openView(arg_1_0)
	local var_1_0 = {
		cateList = SettingsModel.instance:getSettingsCategoryList()
	}

	ViewMgr.instance:openView(ViewName.SettingsView, var_1_0)
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	AudioMgr.instance:registerCallback(AudioMgr.Evt_ChangeFinish, arg_4_0._onChangeFinish, arg_4_0)
	LoginController.instance:registerCallback(LoginEvent.OnLoginEnterMainScene, arg_4_0._onLoginFinish, arg_4_0)
end

function var_0_0.reInit(arg_5_0)
	arg_5_0:checkRecordLogout()
end

function var_0_0.changeLangTxt(arg_6_0)
	UIBlockMgr.instance:startBlock("SettingsController:changeLangTxt")

	arg_6_0._fontAssetDone = false
	arg_6_0._changeLangDelaytDone = false

	GameGlobalMgr.instance:getLangFont():changeFontAsset(arg_6_0._changeLangFontAssetCallBack, arg_6_0)
	GameGlobalMgr.instance:getLangFont():ControlDoubleEn()
	ViewMgr.instance:closeAllViews({
		ViewName.SettingsView,
		ViewName.PlayerIdView,
		ViewName.WaterMarkView
	})
	ViewDestroyMgr.instance:destroyImmediately()
	TaskDispatcher.runDelay(var_0_0._changeLangTxtDelay, arg_6_0, 0.01)
end

function var_0_0._changeLangFontAssetCallBack(arg_7_0)
	arg_7_0._fontAssetDone = true

	arg_7_0:_changeLang2()
end

function var_0_0._changeLangTxtDelay(arg_8_0)
	arg_8_0._changeLangDelaytDone = true

	arg_8_0:_changeLang2()
end

function var_0_0._changeLang2(arg_9_0)
	if arg_9_0._fontAssetDone and arg_9_0._changeLangDelaytDone then
		GameGCMgr.instance:dispatchEvent(GameGCEvent.ResGC, arg_9_0)
		ViewMgr.instance:openView(ViewName.MainView)
		var_0_0.instance:dispatchEvent(SettingsEvent.OnChangeLangTxt)

		local var_9_0 = GameConfig:GetCurLangType()
		local var_9_1 = LangSettings.aihelpKey[var_9_0]

		if var_9_1 then
			if SDKMgr.instance.setLanguage then
				SDKMgr.instance:setLanguage(var_9_1)
			end
		else
			logError("aihelpKey miss :" .. var_9_0)
		end

		UIBlockMgr.instance:endBlock("SettingsController:changeLangTxt")
	end
end

function var_0_0.getStoryVoiceType(arg_10_0)
	local var_10_0 = PlayerPrefsHelper.getString(PlayerPrefsKey.VoiceTypeKey_Story)

	if var_10_0 == nil then
		var_10_0 = GameConfig:GetCurVoiceShortcut()

		PlayerPrefsHelper.setString(PlayerPrefsKey.VoiceTypeKey_Story, var_10_0)
	end

	return var_10_0
end

function var_0_0.checkRecordLogout(arg_11_0)
	logNormal("SettingsController:checkRecordLogout()")

	if not SDKMgr.isSupportRecord or not SDKMgr.instance:isSupportRecord() then
		return
	end

	if SDKMgr.instance:isRecording() then
		SDKMgr.instance:stopRecord()
	end

	SDKMgr.instance:hideRecordBubble()
end

function var_0_0._onLoginFinish(arg_12_0)
	logNormal("SettingsController:_onLoginFinish()")

	local var_12_0 = SettingsModel.instance:getRecordVideo()

	if SettingsShowHelper.canShowRecordVideo() and var_12_0 then
		SDKMgr.instance:showRecordBubble()
	end

	if SDKMgr.instance:isEmulator() then
		local var_12_1 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.EmulatorVideoCompatible, 0)
		local var_12_2 = 2

		if var_12_1 ~= var_12_2 then
			PlayerPrefsHelper.setNumber(PlayerPrefsKey.EmulatorVideoCompatible, var_12_2)
			SettingsModel.instance:setVideoCompatible(var_12_2 == 1)
		end
	end

	SettingsVoicePackageModel.instance:updateVoiceList(false)
end

function var_0_0.checkSwitchRecordVideo(arg_13_0)
	if SettingsShowHelper.canShowRecordVideo() then
		local var_13_0 = not SettingsModel.instance:getRecordVideo()

		if var_13_0 then
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

		SettingsModel.instance:setRecordVideo(var_13_0)

		return true
	end

	return false
end

function var_0_0._onChangeFinish(arg_14_0)
	arg_14_0._inSwitch = false
end

var_0_0.instance = var_0_0.New()

return var_0_0
