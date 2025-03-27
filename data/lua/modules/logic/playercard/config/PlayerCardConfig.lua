module("modules.logic.playercard.config.PlayerCardConfig", package.seeall)

slot0 = class("PlayerCardConfig", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"playercard",
		"player_newspaper"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "playercard" then
		slot0.playcardBaseInfoConfig = slot2
	elseif slot1 == "player_newspaper" then
		slot0.playcardProgressConfig = slot2
	end
end

function slot0.getCardBaseInfoList(slot0)
	return slot0.playcardBaseInfoConfig.configList
end

function slot0.getCardBaseInfoById(slot0, slot1)
	return slot0.playcardBaseInfoConfig.configList[slot1]
end

function slot0.getCardProgressList(slot0)
	return slot0.playcardProgressConfig.configList
end

function slot0.getCardProgressById(slot0, slot1)
	return slot0.playcardProgressConfig.configList[slot1]
end

function slot0.getBgPath(slot0, slot1)
	if not slot1 then
		return "ui/viewres/player/playercard/playercardview_bg.prefab"
	else
		return string.format("ui/viewres/player/playercard/playercardview_bg_%s.prefab", slot1)
	end
end

function slot0.getTopEffectPath(slot0, slot1)
	if not slot1 then
		return "ui/viewres/player/playercard/playercardview_effect.prefab"
	else
		return string.format("ui/viewres/player/playercard/playercardview_playercardview_effect_%s.prefab", slot1)
	end
end

slot0.instance = slot0.New()

return slot0
