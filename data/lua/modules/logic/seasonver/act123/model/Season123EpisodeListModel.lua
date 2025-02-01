module("modules.logic.seasonver.act123.model.Season123EpisodeListModel", package.seeall)

slot0 = class("Season123EpisodeListModel", BaseModel)

function slot0.reInit(slot0)
	slot0._loadingRecordMap = nil
end

function slot0.onInit(slot0)
end

function slot0.release(slot0)
	slot0.activityId = nil
	slot0.stage = nil
	slot0.lastSendEpisodeCfg = nil
	slot0.curSelectLayer = nil

	slot0:clear()
end

function slot0.init(slot0, slot1, slot2)
	slot0.activityId = slot1
	slot0.stage = slot2

	slot0:initEpisodeList()
	slot0:initSelectLayer()
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

function slot0.initSelectLayer(slot0)
	slot0.curSelectLayer = slot0:getCurrentChallengeLayer()
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

function slot0.inCurrentStage(slot0)
	return Season123Model.instance:getActInfo(slot0.activityId) ~= nil and not slot1:isNotInStage() and slot1.stage == uv0.instance.stage
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

function slot0.getEnemyCareerList(slot0, slot1)
	slot2 = FightParam.New()

	slot2:setEpisodeId(slot1)

	slot3 = {}
	slot4 = {}
	slot5 = {}
	slot6 = {}

	for slot10, slot11 in ipairs(slot2.monsterGroupIds) do
		for slot17, slot18 in ipairs(string.splitToNumber(lua_monster_group.configDict[slot11].monster, "#")) do
			slot19 = lua_monster.configDict[slot18].career

			if slot18 == lua_monster_group.configDict[slot11].bossId then
				slot3[slot19] = (slot3[slot19] or 0) + 1

				table.insert(slot6, slot18)
			else
				slot4[slot19] = (slot4[slot19] or 0) + 1

				table.insert(slot5, slot18)
			end
		end
	end

	slot7 = {}

	for slot11, slot12 in pairs(slot3) do
		table.insert(slot7, {
			career = slot11,
			count = slot12
		})
	end

	slot8 = #slot7

	for slot12, slot13 in pairs(slot4) do
		table.insert(slot7, {
			career = slot12,
			count = slot13
		})
	end

	return slot7, slot8
end

function slot0.setSelectLayer(slot0, slot1)
	slot0.curSelectLayer = slot1
end

function slot0.cleanPlayLoadingAnimRecord(slot0, slot1)
	if not slot0._loadingRecordMap then
		return
	end

	slot0._loadingRecordMap = slot0._loadingRecordMap or {}
	slot0._loadingRecordMap[slot1] = nil
end

function slot0.savePlayLoadingAnimRecord(slot0, slot1)
	slot0._loadingRecordMap = slot0._loadingRecordMap or {}
	slot0._loadingRecordMap[slot1] = true
end

function slot0.isLoadingAnimNeedPlay(slot0, slot1)
	return slot0._loadingRecordMap == nil or slot0._loadingRecordMap[slot1] == nil
end

function slot0.stageIsPassed(slot0)
	if not Season123Model.instance:getActInfo(slot0.activityId) then
		return false
	end

	return slot1.stageMap[slot0.stage] and slot2.isPass
end

slot0.instance = slot0.New()

return slot0
