module("modules.logic.act189.model.Activity189_TaskListModel", package.seeall)

slot0 = class("Activity189_TaskListModel", ListScrollModel)
slot1 = table.sort
slot2 = table.insert

function slot0.setTaskList(slot0, slot1)
	slot6 = slot1
	slot0._taskMoList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity189, slot6)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0._taskMoList) do
		slot8 = false
		slot9 = slot7.config
		slot12 = JumpConfig.instance:getJumpConfig(slot9.jumpId)

		if slot9.openLimitActId > 0 then
			slot8 = ActivityHelper.getActivityStatusAndToast(slot10, true) ~= ActivityEnum.ActivityStatus.Normal
		end

		if slot12 then
			slot8 = slot8 or not JumpController.instance:canJumpNew(slot12.param)
		end

		slot2[slot7.id] = slot8
	end

	uv0(slot0._taskMoList, function (slot0, slot1)
		if (slot0.hasFinished and 1 or 0) ~= (slot1.hasFinished and 1 or 0) then
			return slot3 < slot2
		end

		if (uv0[slot0.id] and 1 or 0) ~= (uv0[slot1.id] and 1 or 0) then
			return slot4 < slot5
		end

		if (slot0:isClaimed() and 1 or 0) ~= (slot1:isClaimed() and 1 or 0) then
			return slot6 < slot7
		end

		if slot0.config.sorting ~= slot1.config.sorting then
			return slot10 < slot11
		end

		return slot0.id < slot1.id
	end)
	slot0:setList(slot0._taskMoList)
end

function slot0.refreshList(slot0)
	if false and slot0:getFinishTaskCount() > 1 then
		slot2 = tabletool.copy(slot0._taskMoList)

		uv0(slot2, 1, {
			getAll = true
		})
		slot0:setList(slot2)
	else
		slot0:setList(slot0._taskMoList)
	end
end

function slot0.getFinishTaskCount(slot0)
	for slot5, slot6 in ipairs(slot0._taskMoList) do
		if slot6.hasFinished and slot6.finishCount < slot6:getMaxFinishCount() then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.getFinishTaskActivityCount(slot0)
	for slot5, slot6 in ipairs(slot0._taskMoList) do
		if slot6.hasFinished and slot6.finishCount < slot6:getMaxFinishCount() then
			slot1 = 0 + slot6.config.activity
		end
	end

	return slot1
end

function slot0.getGetRewardTaskCount(slot0)
	for slot5, slot6 in ipairs(slot0._taskMoList) do
		if slot6:isClaimed() then
			slot1 = 0 + 1
		end
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
