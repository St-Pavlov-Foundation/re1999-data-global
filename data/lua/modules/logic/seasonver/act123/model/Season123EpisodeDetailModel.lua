module("modules.logic.seasonver.act123.model.Season123EpisodeDetailModel", package.seeall)

slot0 = class("Season123EpisodeDetailModel", BaseModel)

function slot0.release(slot0)
	slot0.activityId = nil
	slot0.stage = nil
	slot0.layer = nil
	slot0.lastSendEpisodeCfg = nil

	slot0:clear()
end

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.activityId = slot1
	slot0.stage = slot2
	slot0.layer = slot3
	slot0.animRecord = Season123LayerLocalRecord.New()

	slot0.animRecord:init(slot0.activityId)
	slot0:initEpisodeList()
end

function slot0.initEpisodeList(slot0)
	slot1 = {}

	logNormal("episode list length : " .. tostring(#Season123Config.instance:getSeasonEpisodeByStage(slot0.activityId, slot0.stage)))

	if Season123Model.instance:getActInfo(slot0.activityId):getStageMO(slot0.stage) then
		for slot8 = 1, #slot2 do
			slot9 = slot2[slot8]
			slot11 = Season123EpisodeListMO.New()

			slot11:init(slot4.episodeMap[slot9.layer], slot9)
			table.insert(slot1, slot11)
		end
	end

	slot0:setList(slot1)
end

function slot0.isEpisodeUnlock(slot0, slot1)
	slot2 = Season123Model.instance:getActInfo(slot0.activityId)

	if not slot0:getById(slot1) then
		return false
	end

	if slot3.isFinished then
		return true
	end

	if slot1 <= 1 then
		if not slot2 then
			return false
		end

		return slot0.stage == slot2.stage
	end

	if not slot0:getById(slot1 - 1) or not slot4.isFinished then
		return false
	end

	return true
end

function slot0.setMakertLayerAnim(slot0, slot1)
	return slot0.animRecord:add(slot0.stage, slot1)
end

function slot0.isNeedPlayMakertLayerAnim(slot0, slot1)
	return slot0.animRecord:contain(slot0.stage, slot1)
end

function slot0.getCurrentChallengeLayer(slot0)
	if not slot0:getList() or #slot1 <= 0 then
		return 0
	end

	for slot5 = 1, #slot1 do
		if not slot1[slot5].isFinished then
			return slot5
		end
	end

	return slot1[#slot1].cfg.layer
end

function slot0.isNextLayerNewStarGroup(slot0, slot1)
	slot3 = Season123Config.instance:getSeasonEpisodeCo(slot0.activityId, slot1) and slot2.starGroup or 0

	if not Season123Config.instance:getSeasonEpisodeCo(slot0.activityId, slot1 + 1) then
		return false
	end

	return slot3 ~= nil and slot3 ~= slot4.starGroup
end

function slot0.alreadyPassEpisode(slot0, slot1)
	if not slot0:getById(slot1) then
		return false
	end

	slot3 = Season123Config.instance:getSeasonEpisodeCo(slot0.activityId, slot0.stage, slot1)

	if slot2.round <= 0 and slot3 and DungeonModel.instance:getEpisodeInfo(slot3.episodeId) and slot4.star > 0 then
		return true
	end

	return slot2.round > 0
end

function slot0.getCurStarGroup(slot0, slot1, slot2)
	return Season123Config.instance:getSeasonEpisodeCo(slot1, slot0.stage, slot2) and slot3.group or 0
end

function slot0.getEpisodeCOListByStar(slot0, slot1)
	slot2 = {}

	if Season123Config.instance:getSeasonEpisodeByStage(slot0.activityId, slot0.stage) then
		for slot7, slot8 in ipairs(slot3) do
			if not slot8.starGroup or slot8.starGroup == slot1 then
				table.insert(slot2, slot8)
			end
		end
	end

	return slot2
end

function slot0.getCurFinishRound(slot0)
	if not Season123Model.instance:getActInfo(slot0.activityId) then
		return
	end

	if not slot1:getStageMO(slot0.stage) then
		return
	end

	if not slot2.episodeMap[slot0.layer] then
		return
	end

	return slot3.round
end

slot0.instance = slot0.New()

return slot0
