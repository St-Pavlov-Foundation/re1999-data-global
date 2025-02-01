module("modules.logic.seasonver.act123.model.Season123ResetModel", package.seeall)

slot0 = class("Season123ResetModel", BaseModel)
slot0.EmptySelect = -1

function slot0.release(slot0)
end

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.activityId = slot1
	slot0.stage = slot2

	slot0:initEpisodeList()
	slot0:initDefaultSelected(slot3)
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

	if slot0:getById(slot1).isFinished then
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

function slot0.initDefaultSelected(slot0, slot1)
	slot0.layer = slot1

	slot0:updateHeroList()
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

function slot0.getStageCO(slot0)
	return Season123Config.instance:getStageCo(slot0.activityId, slot0.stage)
end

function slot0.getSelectLayerCO(slot0)
	if slot0.layer then
		return Season123Config.instance:getSeasonEpisodeCo(slot0.activityId, slot0.stage, slot0.layer)
	end
end

function slot0.updateHeroList(slot0)
	slot0._showHeroMOList = {}

	if slot0.layer == uv0.EmptySelect then
		return
	end

	if not Season123Model.instance:getActInfo(slot0.activityId) then
		return
	end

	if not slot1:getStageMO(slot0.stage) then
		return
	end

	if slot0.layer or slot0:getCurrentChallengeLayer() then
		if not slot2.episodeMap[slot3] then
			return
		end

		for slot9, slot10 in ipairs(slot4.heroes) do
			if not HeroModel.instance:getById(slot10.heroUid) then
				slot12, slot13 = Season123Model.instance:getAssistData(slot0.activityId, slot0.stage)

				if slot13 and slot13.heroUid == slot10.heroUid then
					slot14 = Season123ShowHeroMO.New()

					slot14:init(slot12, slot13.heroUid, slot13.heroId, slot13.skin, slot10.hpRate, true)
					table.insert(slot0._showHeroMOList, slot14)
				end
			else
				slot12 = Season123ShowHeroMO.New()

				slot12:init(slot11, slot11.uid, slot11.heroId, slot11.skin, slot10.hpRate, false)
				table.insert(slot0._showHeroMOList, slot12)
			end
		end
	end
end

function slot0.getHeroList(slot0)
	return slot0._showHeroMOList
end

slot0.instance = slot0.New()

return slot0
