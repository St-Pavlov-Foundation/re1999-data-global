module("modules.logic.versionactivity1_6.dungeon.config.Activity149Config", package.seeall)

slot0 = class("Activity149Config", BaseConfig)

function slot0.ctor(slot0)
	slot0._bossEpisodeCfgList = {}
	slot0._bossEpisodeCfgDict = {}
	slot0._bossMapElementDict = {}
	slot0._rewardCfgDict = {}
	slot0._rewardCfgList = {}
	slot0._activityConstDict = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"activity149_episode",
		"activity149_rewards",
		"activity149_const",
		"activity149_map_element"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity149_episode" then
		slot0._bossEpisodeCfgList = slot2.configList
		slot0._bossEpisodeCfgDict = slot2.configDict
	elseif slot1 == "activity149_rewards" then
		slot0:initRewardCfg(slot2)
	elseif slot1 == "activity149_const" then
		slot0._activityConstDict = slot2.configDict
	elseif slot1 == "activity149_map_element" then
		slot0._bossMapElementDict = slot2.configDict
	end
end

function slot0.initRewardCfg(slot0, slot1)
	slot0._rewardCfgDict = slot1.configDict
	slot0._rewardCfgList = slot1.configList
	slot0._maxScore = 0

	for slot5, slot6 in ipairs(slot0._rewardCfgList) do
		slot0._maxScore = math.max(slot0._maxScore, slot6.rewardPointNum)
	end
end

function slot0.getAct149EpisodeCfg(slot0, slot1)
	return slot0._bossEpisodeCfgDict[slot1]
end

function slot0.getDungeonEpisodeCfg(slot0, slot1)
	return lua_episode.configDict[slot0._bossEpisodeCfgDict[slot1].episodeId]
end

function slot0.getAct149EpisodeCfgByOrder(slot0, slot1, slot2)
	if slot2 then
		slot3 = {}

		for slot7, slot8 in pairs(slot0._bossEpisodeCfgDict) do
			if slot8.order == slot1 then
				slot3[#slot3 + 1] = slot8
			end
		end

		return slot3
	end

	for slot6, slot7 in pairs(slot0._bossEpisodeCfgDict) do
		if slot7.order == slot1 then
			return slot7
		end
	end
end

function slot0.getAct149EpisodeCfgByEpisodeId(slot0, slot1)
	for slot5, slot6 in pairs(slot0._bossEpisodeCfgDict) do
		if slot6.episodeId == slot1 then
			return slot6
		end
	end
end

function slot0.getNextBossEpisodeCfgById(slot0, slot1)
	if slot0._bossEpisodeCfgDict[slot1 + 1] then
		if slot3.order == slot0._bossEpisodeCfgDict[slot1].order then
			return slot3
		end
	else
		for slot8, slot9 in ipairs(slot0._bossEpisodeCfgList) do
			if slot4 == slot9.order then
				return slot9
			end
		end
	end
end

function slot0.getEpisodeMaxScore(slot0, slot1, slot2)
	if not slot0._bossEpisodeCfgDict[slot1] then
		return 0
	end

	return tonumber(slot0._activityConstDict[1].value) * slot3.multi
end

function slot0.getAct149BossMapElement(slot0, slot1)
	return slot0._bossMapElementDict[slot1]
end

function slot0.getAct149BossMapElementByMapId(slot0, slot1)
	for slot5, slot6 in pairs(slot0._bossMapElementDict) do
		if slot6.mapId == slot1 then
			return slot6
		end
	end
end

function slot0.getAct149ConstValue(slot0, slot1)
	return slot0._activityConstDict[slot1] and slot2.value
end

function slot0.getBossRewardCfgList(slot0)
	return slot0._rewardCfgList
end

function slot0.getBossRewardMaxScore(slot0)
	return slot0._maxScore
end

function slot0.calRewardProgressWidth(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if #slot0:getBossRewardCfgList() == 0 then
		return 0, 0
	end

	slot6 = slot6 or 0
	slot10 = (slot4 or slot3 / 2) + (slot9 - 1) * (slot5 or slot3 + slot2) + (slot7 or 0)
	slot12 = 0

	for slot16, slot17 in ipairs(slot8) do
		if slot17.rewardPointNum <= slot1 then
			slot11 = 0 + (slot16 == 1 and slot4 or slot5)
			slot12 = slot18
		else
			slot11 = slot11 + GameUtil.remap(slot1, slot12, slot18, 0, slot19)

			break
		end
	end

	return math.max(0, slot11 - slot6), slot10
end

function slot0.getAlternateDay(slot0)
	if not slot0._alternateDay then
		slot0._alternateDay = 1

		if slot0._bossEpisodeCfgDict then
			for slot4, slot5 in pairs(slot0._bossEpisodeCfgDict) do
				if not string.nilorempty(slot5.effectCondition) and string.splitToNumber(slot5.effectCondition, "_") and slot6[2] then
					slot0._alternateDay = math.max(slot0._alternateDay, slot6[2])
				end
			end
		end
	end

	return slot0._alternateDay
end

slot0.instance = slot0.New()

return slot0
