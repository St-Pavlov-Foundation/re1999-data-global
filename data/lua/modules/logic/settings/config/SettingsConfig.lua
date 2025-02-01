module("modules.logic.settings.config.SettingsConfig", package.seeall)

slot0 = class("SettingsConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0.SettingsConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"setting_lang",
		"setting_voice"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "setting_lang" then
		slot0.SettingLangConfig = slot2
	elseif slot1 == "setting_voice" then
		slot0.SettingVoiceConfig = slot2
	end
end

function slot0.getSettingLang(slot0, slot1)
	return slot0.SettingLangConfig.configDict[slot1].lang
end

function slot0.getVoiceTips(slot0, slot1)
	if slot0.SettingVoiceConfig.configDict[slot1] then
		return slot0.SettingVoiceConfig.configDict[slot1].tips
	end

	return ""
end

slot0.instance = slot0.New()

return slot0
