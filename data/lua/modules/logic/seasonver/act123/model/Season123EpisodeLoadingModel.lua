module("modules.logic.seasonver.act123.model.Season123EpisodeLoadingModel", package.seeall)

slot0 = class("Season123EpisodeLoadingModel", BaseModel)

function slot0.release(slot0)
	slot0.activityId = nil
	slot0.stage = nil
	slot0.layer = nil
	slot0._layerDict = nil

	slot0:clear()
end

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.activityId = slot1
	slot0.stage = slot2
	slot0.layer = slot3
	slot0._layerDict = {}

	slot0:initEpisodeList()
end

slot0.AnimCount = 7
slot0.EmptyStyleCount = 3
slot0.TargetEpisodeOrder = 5

function slot0.initEpisodeList(slot0)
	slot1 = {}

	logNormal("episode list length : " .. tostring(#Season123Config.instance:getSeasonEpisodeByStage(slot0.activityId, slot0.stage)))

	if Season123Model.instance:getActInfo(slot0.activityId):getStageMO(slot0.stage) then
		for slot9 = 1, uv0.AnimCount do
			if (slot0.layer - uv0.TargetEpisodeOrder + slot9) % (#slot2 + 1) == 0 then
				Season123EpisodeLoadingMO.New():init(slot9, nil, , 1)
			else
				slot12 = slot2[slot10]

				slot11:init(slot9, slot4.episodeMap[slot12.layer], slot12)

				if not slot0._layerDict[slot12.layer] then
					slot0._layerDict[slot12.layer] = slot11
				end
			end

			table.insert(slot1, slot11)
		end
	end

	slot0:setList(slot1)
end

function slot0.isEpisodeUnlock(slot0, slot1)
	slot2 = Season123Model.instance:getActInfo(slot0.activityId)

	if slot0._layerDict[slot1] and slot3.isFinished then
		return true
	end

	if slot1 <= 1 then
		if not slot2 then
			return false
		end

		return slot0.stage == slot2.stage
	end

	if not slot0._layerDict[slot1 - 1] or not slot4.isFinished then
		return false
	end

	return true
end

function slot0.inCurrentStage(slot0)
	return Season123Model.instance:getActInfo(slot0.activityId) ~= nil and not slot1:isNotInStage() and slot1.stage == uv0.instance.stage
end

slot0.instance = slot0.New()

return slot0
