module("modules.logic.seasonver.act123.model.Season123MO", package.seeall)

slot0 = pureTable("Season123MO")

function slot0.updateInfo(slot0, slot1)
	slot0.activityId = slot1.activityId
	slot0.stage = slot1.stage or 0

	if slot1.act123Retail then
		slot0.retailId = slot1.act123Retail.id
	else
		slot0.retailId = nil
	end

	slot0:setUnlockAct123EquipIds(slot1.unlockAct123EquipIds)
	slot0:initItems(slot1.act123Equips)
	slot0:initStages(slot1.act123Stage)

	slot0.heroGroupSnapshot = Season123HeroGroupUtils.buildSnapshotHeroGroups(slot1.heroGroupSnapshot)
	slot0.heroGroupSnapshotSubId = slot1.heroGroupSnapshotSubId
	slot0.retailHeroGroups = Season123HeroGroupUtils.buildSnapshotHeroGroups(slot1.retailHeroGroupSnapshot)
	slot0.unlockIndexes = {}
	slot0.unlockIndexSet = {}

	slot0:updateUnlockIndexes(slot1.unlockEquipIndexs)
	slot0:updateTrial(slot1.trial)
	Season123CardPackageModel.instance:initData(slot0.activityId)
end

function slot0.updateInfoBattle(slot0, slot1)
	slot0.stage = slot1.stage

	slot0:updateUnlockIndexes(slot1.unlockEquipIndexs)
	slot0:initStages(slot1.act123Stage)
	slot0:updateTrial(slot1.trial)
end

function slot0.initStages(slot0, slot1)
	slot0.stageList = {}
	slot0.stageMap = {}

	for slot5 = 1, #slot1 do
		slot6 = slot1[slot5]
		slot7 = Season123StageMO.New()

		slot7:init(slot6)
		table.insert(slot0.stageList, slot7)

		slot0.stageMap[slot6.stage] = slot7
	end
end

function slot0.initItems(slot0, slot1)
	slot0.itemMap = {}

	for slot5 = 1, #slot1 do
		slot6 = slot1[slot5]
		slot7 = Season123ItemMO.New()

		slot7:setData(slot6)

		slot0.itemMap[slot6.uid] = slot7
	end
end

function slot0.updateStages(slot0, slot1)
	slot2 = false

	for slot6 = 1, #slot1 do
		if not slot0.stageMap[slot1[slot6].stage] then
			slot8 = Season123StageMO.New()

			slot8:init(slot7)
			table.insert(slot0.stageList, slot8)

			slot2 = true
			slot0.stageMap[slot7.stage] = slot8
		else
			slot8:init(slot7)
		end
	end

	if slot2 then
		table.sort(slot0.stageList, function (slot0, slot1)
			return slot0.stage < slot1.stage
		end)
	end
end

function slot0.updateEpisodes(slot0, slot1, slot2)
	if not slot0.stageMap[slot1] then
		return
	end

	slot3:updateEpisodes(slot2)
end

function slot0.updateUnlockIndexes(slot0, slot1)
	if not slot1 or #slot1 < 1 then
		return
	end

	slot0.unlockIndexes = {}
	slot0.unlockIndexSet = {}

	for slot5 = 1, #slot1 do
		slot0.unlockIndexes = slot1[slot5]
		slot0.unlockIndexSet[slot1[slot5]] = true
	end
end

function slot0.updateTrial(slot0, slot1)
	if slot1 and slot1.id ~= 0 then
		slot0.trial = slot1.id
	else
		slot0.trial = 0
	end
end

function slot0.getStageMO(slot0, slot1)
	return slot0.stageMap[slot1]
end

function slot0.getCurrentStage(slot0)
	return slot0:getStageMO(slot0.stage)
end

function slot0.getCurHeroGroup(slot0)
	return slot0.heroGroupSnapshot[slot0.heroGroupSnapshotSubId]
end

function slot0.getAllItemMap(slot0)
	return slot0.itemMap
end

function slot0.getItemMO(slot0, slot1)
	if slot0.itemMap then
		return slot0.itemMap[slot1]
	end
end

function slot0.getItemIdByUid(slot0, slot1)
	if slot0.itemMap and slot0.itemMap[slot1] then
		return slot0.itemMap[slot1].itemId
	end
end

function slot0.isNotInStage(slot0)
	return slot0.stage == 0
end

function slot0.getTotalRound(slot0, slot1)
	slot2 = 0

	if not slot0.stageMap[slot1] then
		return 0
	end

	for slot7, slot8 in pairs(slot3.episodeMap) do
		slot2 = slot2 + slot8.round
	end

	return slot2
end

function slot0.isStageSlotUnlock(slot0, slot1, slot2)
	slot0._stage2UnlockSets = slot0._stage2UnlockSets or {}

	if not slot0._stage2UnlockSets[slot1] then
		slot3 = {}

		if Season123Config.instance:getSeasonEpisodeStageCos(slot0.activityId, slot1) then
			for slot8, slot9 in ipairs(slot4) do
				if slot8 ~= #slot4 then
					for slot14, slot15 in pairs(string.splitToNumber(slot9.unlockEquipIndex, "#")) do
						slot3[slot15] = true
					end
				end
			end
		end

		slot0._stage2UnlockSets[slot1] = slot3
	end

	return slot3[slot2]
end

function slot0.setUnlockAct123EquipIds(slot0, slot1)
	slot0.unlockAct123EquipIds = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0.unlockAct123EquipIds[slot6] = slot6
	end
end

function slot0.initStageRewardConfig(slot0)
	slot0.stageRewardMap = slot0.stageRewardMap or {}

	for slot5, slot6 in pairs(TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Season123) or {}) do
		if slot6.config and slot6.config.seasonId == slot0.activityId and slot6.config.isRewardView == Activity123Enum.TaskRewardViewType then
			slot9 = slot0.stageRewardMap[tonumber(Season123Config.instance:getTaskListenerParamCache(slot6.config)[1])] or {}
			slot9[slot5] = slot6
			slot0.stageRewardMap[slot8] = slot9
		end
	end
end

function slot0.getStageRewardCount(slot0, slot1)
	slot0:initStageRewardConfig()

	if not slot0.stageRewardMap[slot1] then
		return 0, Season123Config.instance:getRewardTaskCount(slot0.activityId, slot1)
	end

	for slot8, slot9 in pairs(slot2) do
		if slot9.config.maxFinishCount <= slot9.finishCount or slot9.hasFinished then
			slot4 = 0 + 1
		end
	end

	return slot4, slot3
end

return slot0
