module("modules.logic.versionactivity2_4.warmup.model.V2a4_WarmUp_TaskListModel", package.seeall)

slot0 = class("V2a4_WarmUp_TaskListModel", ListScrollModel)

function slot0.setTaskList(slot0)
	slot0._taskMoList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity125, V2a4_WarmUpConfig.instance:actId())

	table.sort(slot0._taskMoList, function (slot0, slot1)
		slot2 = slot0.config.sorting
		slot3 = slot1.config.sorting

		if (slot0.hasFinished and 1 or 0) ~= (slot1.hasFinished and 1 or 0) then
			return slot5 < slot4
		end

		if (slot0:isClaimed() and 1 or 0) ~= (slot1:isClaimed() and 1 or 0) then
			return slot6 < slot7
		end

		if slot2 ~= slot3 then
			return slot2 < slot3
		end

		return slot0.id < slot1.id
	end)
	slot0:setList(slot0._taskMoList)
end

function slot0.refreshList(slot0)
	if false and slot0:getFinishTaskCount() > 1 then
		slot2 = tabletool.copy(slot0._taskMoList)

		table.insert(slot2, 1, {
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
