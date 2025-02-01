module("modules.logic.seasonver.act166.model.Season166BaseSpotModel", package.seeall)

slot0 = class("Season166BaseSpotModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0:cleanData()
end

function slot0.cleanData(slot0)
	slot0.curBaseSpotId = nil
	slot0.curBaseSpotConfig = nil
	slot0.curEpisodeId = nil
	slot0.talentId = nil
end

function slot0.initBaseSpotData(slot0, slot1, slot2)
	slot0.actId = slot1
	slot0.curBaseSpotId = slot2
	slot0.curBaseSpotConfig = Season166Config.instance:getSeasonBaseSpotCo(slot1, slot2)
	slot0.curEpisodeId = slot0.curBaseSpotConfig and slot0.curBaseSpotConfig.episodeId
	slot0.talentId = slot0.curBaseSpotConfig and slot0.curBaseSpotConfig.talentId
end

function slot0.getBaseSpotMaxScore(slot0, slot1, slot2)
	if Season166Model.instance:getActInfo(slot1).baseSpotInfoMap[slot2] then
		return slot4.maxScore
	end

	return 0
end

function slot0.getStarCount(slot0, slot1, slot2, slot3)
	slot6 = 0

	for slot10, slot11 in ipairs(Season166Config.instance:getSeasonScoreCos(slot1)) do
		if slot11.needScore <= (slot3 or slot0:getBaseSpotMaxScore(slot1, slot2)) then
			slot6 = slot11.star
		end
	end

	return slot6
end

function slot0.getScoreLevelCfg(slot0, slot1, slot2, slot3)
	for slot9 = #Season166Config.instance:getSeasonScoreCos(slot1), 1, -1 do
		if slot5[slot9].needScore <= (slot3 or slot0:getBaseSpotMaxScore(slot1, slot2)) then
			return slot10
		end
	end
end

function slot0.getCurTotalStarCount(slot0, slot1)
	for slot7, slot8 in ipairs(Season166Config.instance:getSeasonBaseSpotCos(slot1)) do
		slot2 = 0 + slot0:getStarCount(slot1, slot8.baseId)
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
