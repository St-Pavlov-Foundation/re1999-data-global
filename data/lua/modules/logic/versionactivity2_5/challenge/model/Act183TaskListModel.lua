module("modules.logic.versionactivity2_5.challenge.model.Act183TaskListModel", package.seeall)

slot0 = class("Act183TaskListModel", MixScrollModel)

function slot0.init(slot0, slot1, slot2)
	slot0._activityId = slot1
	slot0._taskType = slot2

	slot0:_buildTaskMap()
	slot0:refresh()
end

function slot0._buildTaskMap(slot0)
	slot0._taskTypeMap = {}

	if TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity183, slot0._activityId) then
		for slot5, slot6 in ipairs(slot1) do
			slot8 = slot6.config and slot7.type
			slot0._taskTypeMap[slot8] = slot0._taskTypeMap[slot8] or {}

			table.insert(slot0._taskTypeMap[slot8], slot6)
		end
	end

	for slot5, slot6 in pairs(slot0._taskTypeMap) do
		table.sort(slot6, slot0._taskMoListSortFunc)
	end
end

function slot0.getTaskMosByType(slot0, slot1)
	return slot0._taskTypeMap and slot0._taskTypeMap[slot1]
end

function slot0._taskMoListSortFunc(slot0, slot1)
	if slot0.config.groupId ~= slot1.config.groupId then
		return slot4 < slot5
	end

	return slot0.id < slot1.id
end

function slot0.refresh(slot0)
	slot0:setList(slot0:_createTaskItemMoList(slot0._taskTypeMap and slot0._taskTypeMap[slot0._taskType] or {}))
end

function slot0.getInfoList(slot0, slot1)
	slot0._mixCellInfo = {}

	for slot6, slot7 in ipairs(slot0:getList()) do
		if Act183Enum.TaskItemHeightMap[slot7.type] then
			table.insert(slot0._mixCellInfo, SLFramework.UGUI.MixCellInfo.New(slot8, slot9, slot6))
		else
			logError(string.format("任务条缺少高度配置(Act183Enum.TaskItemHeightMap) dataType = %s", slot8))
		end
	end

	return slot0._mixCellInfo
end

function slot0._createTaskItemMoList(slot0, slot1)
	slot3 = {}
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in ipairs(slot1) do
		slot13 = slot10.id

		if nil ~= slot10.config.groupId then
			slot0:_addGroupItemToList(slot4, slot3)
			table.insert(slot3, slot0:_createItemMo(Act183Enum.TaskListItemType.Head, slot10))
		end

		if slot10 then
			table.insert(slot4, slot0:_createItemMo(Act183Enum.TaskListItemType.Task, slot10))

			if Act183Helper.isTaskCanGetReward(slot13) then
				table.insert(slot5, slot10)
			end

			slot2 = slot12
		else
			logError(string.format("缺少任务数据 taskId = %s", slot13))
		end
	end

	slot0:_addGroupItemToList(slot4, slot3)
	slot0:_addOneKeyItemToList(slot5, slot3)

	return slot3
end

function slot0._addOneKeyItemToList(slot0, slot1, slot2)
	if not slot1 or #slot1 <= 1 then
		slot0._oneKeyTaskItem = nil

		return
	end

	slot0._oneKeyTaskItem = slot0:_createItemMo(Act183Enum.TaskListItemType.OneKey, slot1)
end

function slot0.getOneKeyTaskItem(slot0)
	return slot0._oneKeyTaskItem
end

function slot0._addGroupItemToList(slot0, slot1, slot2)
	if slot1 and #slot1 > 0 then
		table.sort(slot1, slot0._taskItemListSortFunc)
		tabletool.addValues(slot2, slot1)

		slot1 = {}
	end
end

function slot0._createItemMo(slot0, slot1, slot2)
	return {
		type = slot1,
		data = slot2
	}
end

function slot0._taskItemListSortFunc(slot0, slot1)
	if slot0.data.config.groupId ~= slot1.data.config.groupId then
		return slot4 < slot5
	end

	slot6 = slot0.data.id
	slot7 = slot1.data.id
	slot9 = Act183Helper.isTaskHasGetReward(slot6)
	slot11 = Act183Helper.isTaskHasGetReward(slot7)

	if Act183Helper.isTaskCanGetReward(slot6) ~= Act183Helper.isTaskCanGetReward(slot7) then
		return slot8
	end

	if slot9 ~= slot11 then
		return not slot9
	end

	return slot6 < slot7
end

slot0.instance = slot0.New()

return slot0
