module("modules.logic.settings.model.SettingsRoleVoiceModel", package.seeall)

slot0 = class("SettingsRoleVoiceModel", BaseModel)

function slot0._getValidLangStr(slot0, slot1)
	slot2 = GameConfig:GetCurVoiceShortcut()
	slot4 = false

	if SettingsVoicePackageModel.instance:getPackInfo(slot1) and not slot3:needDownload() then
		slot4 = true
	end

	slot5 = slot4 and slot1 or slot2

	return LangSettings.shortCut2LangIdxTab[slot5], slot5, slot1 == slot2
end

function slot0.onInit(slot0)
end

function slot0.setCharVoiceLangPrefValue(slot0, slot1, slot2)
	slot3 = type(slot1) == "number" and LangSettings.shortcutTab[slot1] or slot1

	slot0:statCharVoiceData(StatEnum.EventName.ChangeCharVoiceLang, slot2, slot3)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(SettingsEnum.CharVoiceLangPrefsKey .. slot2 .. "_"), slot3)
end

function slot0.getCharVoiceLangPrefValue(slot0, slot1)
	slot4 = false

	if type(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(SettingsEnum.CharVoiceLangPrefsKey .. slot1 .. "_"))) ~= "string" or string.nilorempty(slot3) then
		slot3 = GameConfig:GetCurVoiceShortcut()
		slot4 = true
	end

	slot5 = LangSettings.shortCut2LangIdxTab[slot3]
	slot6, slot7, slot8 = slot0:_getValidLangStr(slot3)

	return slot6, slot7, slot8
end

function slot0.statCharVoiceData(slot0, slot1, slot2, slot3)
	if not HeroConfig.instance:getHeroCO(slot2) then
		return
	end

	if slot1 == StatEnum.EventName.ChangeCharVoiceLang then
		slot6, slot7, slot8 = slot0:getCharVoiceLangPrefValue(slot2)
	end

	StatController.instance:track(slot1, {
		[StatEnum.EventProperties.HeroId] = tonumber(slot2),
		[StatEnum.EventProperties.HeroName] = slot4.name,
		[StatEnum.EventProperties.CharVoiceLang] = slot3,
		[StatEnum.EventProperties.GlobalVoiceLang] = GameConfig:GetCurVoiceShortcut(),
		[StatEnum.EventProperties.CharVoiceLangBefore] = slot8 and slot9 or slot7
	})
end

slot0.instance = slot0.New()

return slot0
