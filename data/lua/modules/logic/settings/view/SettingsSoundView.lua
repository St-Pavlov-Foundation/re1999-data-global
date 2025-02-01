module("modules.logic.settings.view.SettingsSoundView", package.seeall)

slot0 = class("SettingsSoundView", BaseView)

function slot0.onInitView(slot0)
	slot1 = gohelper.findChild(slot0.viewGO, "SoundScroll/Viewport/Content")
	slot0._gomusic = gohelper.findChild(slot1, "#go_music")
	slot0._govoice = gohelper.findChild(slot1, "#go_voice")
	slot0._goeffect = gohelper.findChild(slot1, "#go_effect")
	slot0._goglobal = gohelper.findChild(slot1, "#go_global")
	slot0._gobackgroundsound = gohelper.findChild(slot1, "backgroundsound")
	slot0._btnbackgroundsoundswitch = gohelper.findChildButtonWithAudio(slot1, "backgroundsound/text/#btn_backgroundsoundswitch")
	slot0._gobackgroundsoundoff = gohelper.findChild(slot1, "backgroundsound/text/#btn_backgroundsoundswitch/#go_backgroundsoundoff")
	slot0._gobackgroundsoundon = gohelper.findChild(slot1, "backgroundsound/text/#btn_backgroundsoundswitch/#go_backgroundsoundon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbackgroundsoundswitch:AddClickListener(slot0.__btnbackgroundsoundswitchOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbackgroundsoundswitch:RemoveClickListener()
end

slot0.VoiceKeyEnum = {
	Global = 4,
	Effect = 3,
	Voice = 2,
	Music = 1
}

function slot0._editableInitView(slot0)
	slot0._itemTables = {
		[uv0.VoiceKeyEnum.Music] = slot0:_initItem(slot0._gomusic, uv0.VoiceKeyEnum.Music),
		[uv0.VoiceKeyEnum.Voice] = slot0:_initItem(slot0._govoice, uv0.VoiceKeyEnum.Voice),
		[uv0.VoiceKeyEnum.Effect] = slot0:_initItem(slot0._goeffect, uv0.VoiceKeyEnum.Effect),
		[uv0.VoiceKeyEnum.Global] = slot0:_initItem(slot0._goglobal, uv0.VoiceKeyEnum.Global)
	}

	gohelper.setActive(slot0._gobackgroundsound, BootNativeUtil.isWindows())
end

function slot0._initItem(slot0, slot1, slot2)
	slot3 = slot0:getUserDataTb_()
	slot3.slider = gohelper.findChildSlider(slot1, "slider")
	slot3.sliderClick = gohelper.getClick(slot3.slider.gameObject)

	slot3.sliderClick:AddClickDownListener(function ()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)
	end, slot0)
	slot3.slider:SetValue(slot0:getVoiceValue(slot2))
	slot3.slider:AddOnValueChanged(slot0.onSliderValueChanged, slot0, slot2)

	slot3.txtvalue = gohelper.findChildText(slot1, "slider/area/handle/#txt_value")
	slot3.key = slot2
	slot3.txtvalue.text = slot0:getVoiceValue(slot2)

	return slot3
end

function slot0.onSliderValueChanged(slot0, slot1, slot2)
	if slot1 == uv0.VoiceKeyEnum.Music then
		SettingsModel.instance:setMusicValue(slot2)
	elseif slot1 == uv0.VoiceKeyEnum.Voice then
		SettingsModel.instance:setVoiceValue(slot2)
	elseif slot1 == uv0.VoiceKeyEnum.Effect then
		SettingsModel.instance:setEffectValue(slot2)
	elseif slot1 == uv0.VoiceKeyEnum.Global then
		SettingsModel.instance:setGlobalAudioVolume(slot2)
	end

	slot0._itemTables[slot1].txtvalue.text = slot2
end

function slot0.getVoiceValue(slot0, slot1)
	if slot1 == uv0.VoiceKeyEnum.Music then
		return SettingsModel.instance:getMusicValue()
	elseif slot1 == uv0.VoiceKeyEnum.Voice then
		return SettingsModel.instance:getVoiceValue()
	elseif slot1 == uv0.VoiceKeyEnum.Effect then
		return SettingsModel.instance:getEffectValue()
	elseif slot1 == uv0.VoiceKeyEnum.Global then
		return SettingsModel.instance:getGlobalAudioVolume()
	else
		return 0
	end
end

function slot0.__btnbackgroundsoundswitchOnClick(slot0)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.WWise_SL_ActivateDuringFocusLoss, PlayerPrefsHelper.getNumber(PlayerPrefsKey.WWise_SL_ActivateDuringFocusLoss, 0) == 0 and 1 or 0)
	slot0:_refreshgroundsound()
end

function slot0._refreshgroundsound(slot0)
	gohelper.setActive(slot0._gobackgroundsoundoff, PlayerPrefsHelper.getNumber(PlayerPrefsKey.WWise_SL_ActivateDuringFocusLoss, 0) == 0)
	gohelper.setActive(slot0._gobackgroundsoundon, slot1 == 1)
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshgroundsound()
end

function slot0.onOpen(slot0)
	slot0:_refreshgroundsound()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0._itemTables) do
		slot5.sliderClick:RemoveClickDownListener()
		slot5.slider:RemoveOnValueChanged()
	end
end

return slot0
