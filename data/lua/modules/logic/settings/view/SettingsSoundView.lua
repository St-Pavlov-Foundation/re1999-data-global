module("modules.logic.settings.view.SettingsSoundView", package.seeall)

local var_0_0 = class("SettingsSoundView", BaseView)

function var_0_0.onInitView(arg_1_0)
	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "SoundScroll/Viewport/Content")

	arg_1_0._gomusic = gohelper.findChild(var_1_0, "#go_music")
	arg_1_0._govoice = gohelper.findChild(var_1_0, "#go_voice")
	arg_1_0._goeffect = gohelper.findChild(var_1_0, "#go_effect")
	arg_1_0._goglobal = gohelper.findChild(var_1_0, "#go_global")
	arg_1_0._gobackgroundsound = gohelper.findChild(var_1_0, "backgroundsound")
	arg_1_0._btnbackgroundsoundswitch = gohelper.findChildButtonWithAudio(var_1_0, "backgroundsound/text/#btn_backgroundsoundswitch")
	arg_1_0._gobackgroundsoundoff = gohelper.findChild(var_1_0, "backgroundsound/text/#btn_backgroundsoundswitch/#go_backgroundsoundoff")
	arg_1_0._gobackgroundsoundon = gohelper.findChild(var_1_0, "backgroundsound/text/#btn_backgroundsoundswitch/#go_backgroundsoundon")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbackgroundsoundswitch:AddClickListener(arg_2_0.__btnbackgroundsoundswitchOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbackgroundsoundswitch:RemoveClickListener()
end

var_0_0.VoiceKeyEnum = {
	Global = 4,
	Effect = 3,
	Voice = 2,
	Music = 1
}

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._itemTables = {}
	arg_4_0._itemTables[var_0_0.VoiceKeyEnum.Music] = arg_4_0:_initItem(arg_4_0._gomusic, var_0_0.VoiceKeyEnum.Music)
	arg_4_0._itemTables[var_0_0.VoiceKeyEnum.Voice] = arg_4_0:_initItem(arg_4_0._govoice, var_0_0.VoiceKeyEnum.Voice)
	arg_4_0._itemTables[var_0_0.VoiceKeyEnum.Effect] = arg_4_0:_initItem(arg_4_0._goeffect, var_0_0.VoiceKeyEnum.Effect)
	arg_4_0._itemTables[var_0_0.VoiceKeyEnum.Global] = arg_4_0:_initItem(arg_4_0._goglobal, var_0_0.VoiceKeyEnum.Global)

	gohelper.setActive(arg_4_0._gobackgroundsound, BootNativeUtil.isWindows())
end

function var_0_0._initItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:getUserDataTb_()

	var_5_0.slider = gohelper.findChildSlider(arg_5_1, "slider")
	var_5_0.sliderClick = gohelper.getClick(var_5_0.slider.gameObject)

	var_5_0.sliderClick:AddClickDownListener(function()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)
	end, arg_5_0)
	var_5_0.slider:SetValue(arg_5_0:getVoiceValue(arg_5_2))
	var_5_0.slider:AddOnValueChanged(arg_5_0.onSliderValueChanged, arg_5_0, arg_5_2)

	var_5_0.txtvalue = gohelper.findChildText(arg_5_1, "slider/area/handle/#txt_value")
	var_5_0.key = arg_5_2
	var_5_0.txtvalue.text = arg_5_0:getVoiceValue(arg_5_2)

	return var_5_0
end

function var_0_0.onSliderValueChanged(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == var_0_0.VoiceKeyEnum.Music then
		SettingsModel.instance:setMusicValue(arg_7_2)
	elseif arg_7_1 == var_0_0.VoiceKeyEnum.Voice then
		SettingsModel.instance:setVoiceValue(arg_7_2)
	elseif arg_7_1 == var_0_0.VoiceKeyEnum.Effect then
		SettingsModel.instance:setEffectValue(arg_7_2)
	elseif arg_7_1 == var_0_0.VoiceKeyEnum.Global then
		SettingsModel.instance:setGlobalAudioVolume(arg_7_2)
	end

	arg_7_0._itemTables[arg_7_1].txtvalue.text = arg_7_2
end

function var_0_0.getVoiceValue(arg_8_0, arg_8_1)
	if arg_8_1 == var_0_0.VoiceKeyEnum.Music then
		return SettingsModel.instance:getMusicValue()
	elseif arg_8_1 == var_0_0.VoiceKeyEnum.Voice then
		return SettingsModel.instance:getVoiceValue()
	elseif arg_8_1 == var_0_0.VoiceKeyEnum.Effect then
		return SettingsModel.instance:getEffectValue()
	elseif arg_8_1 == var_0_0.VoiceKeyEnum.Global then
		return SettingsModel.instance:getGlobalAudioVolume()
	else
		return 0
	end
end

function var_0_0.__btnbackgroundsoundswitchOnClick(arg_9_0)
	local var_9_0 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.WWise_SL_ActivateDuringFocusLoss, 0) == 0 and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.WWise_SL_ActivateDuringFocusLoss, var_9_0)
	arg_9_0:_refreshgroundsound()
end

function var_0_0._refreshgroundsound(arg_10_0)
	local var_10_0 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.WWise_SL_ActivateDuringFocusLoss, 0)

	gohelper.setActive(arg_10_0._gobackgroundsoundoff, var_10_0 == 0)
	gohelper.setActive(arg_10_0._gobackgroundsoundon, var_10_0 == 1)
end

function var_0_0.onUpdateParam(arg_11_0)
	arg_11_0:_refreshgroundsound()
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:_refreshgroundsound()
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0._itemTables) do
		iter_14_1.sliderClick:RemoveClickDownListener()
		iter_14_1.slider:RemoveOnValueChanged()
	end
end

return var_0_0
