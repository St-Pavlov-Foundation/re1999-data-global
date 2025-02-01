module("modules.logic.versionactivity1_7.doubledrop.config.DoubleDropConfig", package.seeall)

slot0 = class("DoubleDropConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"activity153",
		"activity153_extra_bonus"
	}
end

function slot0.onInit(slot0)
	slot0._actCfgDict = {}
	slot0._actEpisodeDict = {}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot0[string.format("on%sConfigLoaded", slot1)] then
		slot3(slot0, slot2)
	end
end

function slot0.onactivity153ConfigLoaded(slot0, slot1)
	slot0._actCfgDict = slot1.configDict
end

function slot0.onactivity153_extra_bonusConfigLoaded(slot0, slot1)
	slot0._actEpisodeDict = slot1.configDict
end

function slot0.getAct153Co(slot0, slot1)
	return slot0._actCfgDict[slot1]
end

function slot0.getAct153ExtraBonus(slot0, slot1, slot2)
	slot3 = slot0._actEpisodeDict[slot1] and slot0._actEpisodeDict[slot1][slot2]

	return slot3 and slot3.extraBonus
end

function slot0.getAct153ActEpisodes(slot0, slot1)
	return slot0._actEpisodeDict[slot1]
end

slot0.instance = slot0.New()

return slot0
