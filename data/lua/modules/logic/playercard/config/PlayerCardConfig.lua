module("modules.logic.playercard.config.PlayerCardConfig", package.seeall)

slot0 = class("PlayerCardConfig", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"playercard",
		"playercard_theme"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "playercard" then
		slot0.playcardConfig = slot2
	elseif slot1 == "playercard_theme" then
		slot0.playcardThemeConfig = slot2
	end
end

function slot0.getCardConfig(slot0, slot1)
	if not slot1 then
		return
	end

	return slot0.playcardConfig.configDict[slot1]
end

function slot0.getCardList(slot0)
	return slot0.playcardConfig.configList
end

function slot0.getCardThemeConfig(slot0, slot1)
	if not slot1 then
		return
	end

	return slot0.playcardThemeConfig.configDict[slot1]
end

function slot0.getCardThemeList(slot0)
	return slot0.playcardThemeConfig.configList
end

slot0.instance = slot0.New()

return slot0
