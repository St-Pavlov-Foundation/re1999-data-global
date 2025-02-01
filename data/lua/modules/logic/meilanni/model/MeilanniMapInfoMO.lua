module("modules.logic.meilanni.model.MeilanniMapInfoMO", package.seeall)

slot0 = pureTable("MeilanniMapInfoMO")

function slot0.init(slot0, slot1)
	slot0.mapId = slot1.mapId
	slot0.mapConfig = lua_activity108_map.configDict[slot0.mapId]

	slot0:_initEpisodeInfos(slot1)

	slot0.score = slot1.score
	slot0.highestScore = slot1.highestScore
	slot0.getRewardIds = slot1.getRewardIds
	slot0.isFinish = slot1.isFinish
	slot0.totalCount = slot1.totalCount

	slot0:updateExcludeRules(slot1)
end

function slot0.getExcludeRules(slot0)
	return slot0.excludeRules
end

function slot0.updateExcludeRules(slot0, slot1)
	slot0.excludeRules = {}
	slot0.excludeRulesMap = {}
	slot0._excludeThreat = 0

	for slot5, slot6 in ipairs(slot1.excludeRules) do
		if lua_activity108_rule.configDict[slot6] then
			slot8 = tonumber(slot7.rules)

			table.insert(slot0.excludeRules, slot8)

			slot0.excludeRulesMap[slot8] = slot7
			slot0._excludeThreat = slot0._excludeThreat + slot7.threat
		end
	end
end

function slot0.isExcludeRule(slot0, slot1)
	return slot0.excludeRulesMap[slot1]
end

function slot0.getThreat(slot0)
	return math.max(slot0.mapConfig.threat - slot0._excludeThreat, 0)
end

function slot0.getMaxScore(slot0)
	return slot0.highestScore
end

function slot0._initEpisodeInfos(slot0, slot1)
	slot0.episodeInfos = {}
	slot0._episodeInfoMap = {}

	for slot5, slot6 in ipairs(slot1.episodeInfos) do
		slot7 = EpisodeInfoMO.New()

		slot7:init(slot6)
		table.insert(slot0.episodeInfos, slot7)

		slot0._episodeInfoMap[slot7.episodeId] = slot7
	end
end

function slot0.updateEpisodeInfo(slot0, slot1)
	if not slot0._episodeInfoMap[slot1.episodeId] then
		slot2 = EpisodeInfoMO.New()

		slot2:init(slot1)
		table.insert(slot0.episodeInfos, slot2)

		slot0._episodeInfoMap[slot2.episodeId] = slot2
	else
		slot2:init(slot1)
	end
end

function slot0.getEpisodeInfo(slot0, slot1)
	return slot0._episodeInfoMap[slot1]
end

function slot0.getCurEpisodeInfo(slot0)
	return slot0.episodeInfos[#slot0.episodeInfos]
end

function slot0.checkFinish(slot0)
	return slot0.isFinish and slot0:getCurEpisodeInfo().confirm
end

function slot0.getEventInfo(slot0, slot1)
	return slot0:getCurEpisodeInfo():getEventInfo(slot1)
end

function slot0.getEpisodeByBattleId(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.episodeInfos) do
		if slot6:getEventByBattleId(slot1) then
			return slot6
		end
	end
end

function slot0.isGetReward(slot0, slot1)
	return tabletool.indexOf(slot0.getRewardIds, slot1)
end

function slot0.getTotalCostAP(slot0)
	if not slot0._episodeInfoMap then
		return 0
	end

	for slot5, slot6 in pairs(slot0._episodeInfoMap) do
		slot1 = 0 + MeilanniConfig.instance:getEpisodeConfig(slot5).actpoint - slot6.leftActPoint
	end

	return slot1
end

return slot0
