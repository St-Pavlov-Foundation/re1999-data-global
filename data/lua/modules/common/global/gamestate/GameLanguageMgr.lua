module("modules.common.global.gamestate.GameLanguageMgr", package.seeall)

slot0 = class("GameLanguageMgr")

function slot0.ctor(slot0)
	slot0._languageType = slot0:getStoryIndexByShortCut(LangSettings.shortcutTab[GameConfig:GetCurLangType()])
	slot0._voiceType = slot0:getStoryIndexByShortCut(SettingsController.instance:getStoryVoiceType())
end

function slot0.getLanguageTypeStoryIndex(slot0)
	return slot0._languageType
end

function slot0.setLanguageTypeByStoryIndex(slot0, slot1)
	slot0._languageType = slot1
end

function slot0.setVoiceTypeByStoryIndex(slot0, slot1)
	slot0._voiceType = slot1
end

function slot0.getVoiceTypeStoryIndex(slot0)
	if slot0._voiceType then
		return slot0._voiceType
	else
		return slot0:getStoryIndexByShortCut(SettingsController.instance:getStoryVoiceType())
	end

	return LanguageEnum.LanguageStoryType.EN
end

function slot0.getShortCutByStoryIndex(slot0, slot1)
	return LangSettings.shortcutTab[bit.lshift(1, slot1 - 1)]
end

function slot0.setStoryIndexByShortCut(slot0, slot1)
	slot0._languageType = LangSettings[slot1] and math.log(slot2) / math.log(2) + 1
end

function slot0.getStoryIndexByShortCut(slot0, slot1)
	return LangSettings[slot1] and math.log(slot2) / math.log(2) + 1 or 1
end

slot0.instance = slot0.New()

return slot0
