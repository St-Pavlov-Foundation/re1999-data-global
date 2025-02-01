module("modules.logic.bossrush.model.V1a4_BossRush_ScoreTaskAchievementListModel", package.seeall)

slot0 = class("V1a4_BossRush_ScoreTaskAchievementListModel", ListScrollModel)

function slot0.setStaticData(slot0, slot1)
	slot0._staticData = slot1
end

function slot0.getStaticData(slot0)
	return slot0._staticData
end

function slot0.claimRewardByIndex(slot0, slot1)
	if not slot0:getByIndex(slot1) then
		return
	end

	slot2.finishCount = math.min(slot2.finishCount + 1, slot2.config.maxFinishCount)
	slot2.hasFinished = false

	slot0:sort(slot0._sort)
	TaskRpc.instance:sendFinishTaskRequest(slot2.id)
end

function slot0._sort(slot0, slot1)
	if slot0.getAll then
		return true
	end

	if slot1.getAll then
		return false
	end

	slot4 = slot0.id
	slot5 = slot1.id
	slot6 = slot0.config.maxFinishCount <= slot0.finishCount and 1 or 0
	slot7 = slot1.config.maxFinishCount <= slot1.finishCount and 1 or 0
	slot10 = slot0.maxProgress
	slot11 = slot1.maxProgress

	if (slot0.hasFinished and 1 or 0) ~= (slot1.hasFinished and 1 or 0) then
		return slot9 < slot8
	end

	if slot6 ~= slot7 then
		return slot6 < slot7
	end

	if slot10 ~= slot11 then
		return slot10 < slot11
	end

	return slot4 < slot5
end

function slot0.getFinishCount(slot0, slot1, slot2)
	for slot7, slot8 in pairs(slot1) do
		if slot8.config and slot8.config.stage == slot2 and slot8.finishCount < slot8.config.maxFinishCount and slot8.hasFinished then
			slot3 = 0 + 1
		end
	end

	return slot3
end

function slot0.setAchievementMoList(slot0, slot1)
	if slot0:getFinishCount(BossRushModel.instance:getTaskMoListByStage(slot1), slot1) > 1 then
		table.insert(slot2, 1, {
			getAll = true,
			stage = slot1
		})
	end

	table.sort(slot2, slot0._sort)
	slot0:setList(slot2)
end

function slot0.getAllAchievementTask(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in pairs(BossRushModel.instance:getTaskMoListByStage(slot1)) do
		table.insert(slot3, slot8.id)
	end

	return slot3
end

function slot0.isReddot(slot0, slot1)
	if BossRushModel.instance:getTaskMoListByStage(slot1) then
		for slot6, slot7 in pairs(slot2) do
			if slot7.finishCount < slot7.config.maxFinishCount and slot7.hasFinished then
				return true
			end
		end
	end
end

slot0.instance = slot0.New()

return slot0
