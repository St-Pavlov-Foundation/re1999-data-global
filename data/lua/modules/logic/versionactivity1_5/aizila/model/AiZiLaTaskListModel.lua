module("modules.logic.versionactivity1_5.aizila.model.AiZiLaTaskListModel", package.seeall)

slot0 = class("AiZiLaTaskListModel", ListScrollModel)

function slot0.init(slot0)
	for slot9, slot10 in ipairs(AiZiLaConfig.instance:getTaskList(VersionActivity1_5Enum.ActivityId.AiZiLa)) do
		slot11 = AiZiLaTaskMO.New()

		slot11:init(slot10, (TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.RoleAiZiLa) or {})[slot10.id])
		table.insert({}, slot11)

		if slot11:alreadyGotReward() then
			slot5 = 0 + 1
		end
	end

	if slot5 > 1 then
		slot6 = AiZiLaTaskMO.New()
		slot6.id = AiZiLaEnum.TaskMOAllFinishId
		slot6.activityId = slot3

		table.insert(slot2, 1, slot6)
	end

	table.sort(slot2, uv0.sortMO)

	slot0._hasRankDiff = false

	slot0:_refreshShowTab(slot2)
	slot0:setList(slot2)
end

function slot0.sortMO(slot0, slot1)
	if uv0.getSortIndex(slot0) ~= uv0.getSortIndex(slot1) then
		return slot2 < slot3
	elseif slot0.id ~= slot1.id then
		return slot0.id < slot1.id
	end
end

function slot0.getSortIndex(slot0)
	if slot0.id == AiZiLaEnum.TaskMOAllFinishId then
		return 1
	end

	if slot0:isFinished() then
		return 99 + (slot0:isMainTask() and 0 or 200)
	elseif slot0:alreadyGotReward() then
		return 2 + slot1
	end

	return 50 + slot1
end

function slot0.createMO(slot0, slot1, slot2)
	return {
		config = slot2.config,
		originTaskMO = slot2
	}
end

function slot0.getRankDiff(slot0, slot1)
	if slot0._hasRankDiff and slot1 then
		slot3 = slot0:getIndex(slot1)

		if tabletool.indexOf(slot0._idIdxList, slot1.id) and slot3 then
			slot0._idIdxList[slot2] = -2

			return slot3 - slot2
		end
	end

	return 0
end

function slot0.refreshRankDiff(slot0)
	slot0._idIdxList = {}

	for slot5, slot6 in ipairs(slot0:getList()) do
		table.insert(slot0._idIdxList, slot6.id)
	end
end

function slot0.refreshShowTab(slot0)
	slot0:_refreshShowTab(slot0:getList())
end

function slot0._refreshShowTab(slot0, slot1)
	for slot6, slot7 in ipairs(slot1) do
		slot8 = slot7:isMainTask()

		if slot7.id ~= AiZiLaEnum.TaskMOAllFinishId and nil ~= slot8 then
			slot2 = slot8

			slot7:setShowTab(true)
		else
			slot7:setShowTab(false)
		end
	end
end

function slot0.getInfoList(slot0, slot1)
	slot2 = {}
	slot3 = slot0:getList()

	slot0:_refreshShowTab(slot3)

	for slot7, slot8 in ipairs(slot3) do
		table.insert(slot2, SLFramework.UGUI.MixCellInfo.New(slot7, slot8:getLineHeight(), slot7))
	end

	return slot2
end

function slot0.preFinish(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = false
	slot0._hasRankDiff = false

	slot0:refreshRankDiff()

	slot3 = 0
	slot4 = slot0:getList()

	if slot1.id == AiZiLaEnum.TaskMOAllFinishId then
		for slot8, slot9 in ipairs(slot4) do
			if slot9:alreadyGotReward() and slot9.id ~= AiZiLaEnum.TaskMOAllFinishId then
				slot9.preFinish = true
				slot2 = true
				slot3 = slot3 + 1
			end
		end
	elseif slot1:alreadyGotReward() then
		slot1.preFinish = true
		slot2 = true
		slot3 = slot3 + 1
	end

	if slot2 then
		if slot0:getById(AiZiLaEnum.TaskMOAllFinishId) and slot0:getGotRewardCount() < slot3 + 1 then
			tabletool.removeValue(slot4, slot5)
		end

		slot0._hasRankDiff = true

		table.sort(slot4, uv0.sortMO)
		slot0:setList(slot4)

		slot0._hasRankDiff = false
	end
end

function slot0.getGotRewardCount(slot0, slot1)
	for slot7, slot8 in ipairs(slot1 or slot0:getList()) do
		if slot8:alreadyGotReward() and not slot8.preFinish and slot8.id ~= AiZiLaEnum.TaskMOAllFinishId then
			slot3 = 0 + 1
		end
	end

	return slot3
end

slot0.instance = slot0.New()

return slot0
