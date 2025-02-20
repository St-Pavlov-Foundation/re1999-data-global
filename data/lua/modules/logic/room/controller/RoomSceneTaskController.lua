module("modules.logic.room.controller.RoomSceneTaskController", package.seeall)

slot0 = class("RoomSceneTaskController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	slot0:release()
end

function slot0.release(slot0)
	TaskController.instance:unregisterCallback(TaskEvent.SetTaskList, slot0.refreshData, slot0)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, slot0.updateData, slot0)
	RoomTaskModel.instance:clear()

	slot0._taskList = nil
	slot0._cfgGroup = nil
	slot0._allTaskList = nil
	slot0._taskMOIdSet = nil
	slot0._needCheckFinish = true
end

function slot0.init(slot0)
	slot0:release()
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, slot0.refreshData, slot0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, slot0.updateData, slot0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Room
	})
	RoomTaskModel.instance:buildDatas()
end

function slot0.showHideRoomTopTaskUI(slot0, slot1)
	slot0:dispatchEvent(RoomEvent.TaskShowHideAnim, slot1 == true)
end

function slot0.refreshData(slot0)
	RoomTaskModel.instance:handleTaskUpdate()
	slot0:dispatchEvent(RoomEvent.TaskUpdate)
	slot0:checkTaskFinished()
end

function slot0.updateData(slot0)
	RoomTaskModel.instance:handleTaskUpdate()
	slot0:dispatchEvent(RoomEvent.TaskUpdate)

	if slot0._needCheckFinish then
		slot0:checkTaskFinished()
	end
end

function slot0.checkTaskFinished(slot0)
	slot1, slot2 = slot0:isFirstTaskFinished()

	if slot1 then
		slot0:dispatchEvent(RoomEvent.TaskCanFinish, slot2)
	end

	return slot1
end

function slot0.setTaskCheckFinishFlag(slot0, slot1)
	slot0._needCheckFinish = slot1
end

function slot0.isFirstTaskFinished(slot0)
	if RoomTaskModel.instance:getShowList() ~= nil and #slot1 > 0 then
		slot2 = nil

		for slot6, slot7 in ipairs(slot1) do
			if RoomTaskModel.instance:tryGetTaskMO(slot7.id) and slot9.hasFinished and slot9.finishCount <= 0 then
				table.insert(slot2 or {}, slot8)
			else
				return slot2 ~= nil, slot2
			end
		end

		return slot2 ~= nil, slot2
	end

	return false
end

function slot0.getProgressStatus(slot0)
	return slot0.hasFinished, slot0.progress
end

function slot0.hasLocalModifyBlock(slot0)
	if slot0.hasFinished then
		return false
	end

	if not RoomSceneTaskValidator.canGetByLocal(slot0) then
		return false
	end

	if RoomMapBlockModel.instance:getTempBlockMO() or RoomMapBuildingModel.instance:getTempBuildingMO() then
		return true
	elseif RoomMapBlockModel.instance:getBackBlockModel() then
		return slot1:getCount() > 0
	end

	return false
end

function slot0.sortTask(slot0, slot1)
	return uv0.sortTaskConfig(slot0.config, slot1.config)
end

function slot0.sortTaskConfig(slot0, slot1)
	if uv0.getOrder(slot0) ~= uv0.getOrder(slot1) then
		return slot2 < slot3
	else
		return slot0.id < slot1.id
	end
end

function slot0.getOrder(slot0)
	if not string.nilorempty(slot0.order) and not string.nilorempty(string.match(slot0.order, "%d+")) then
		return tonumber(slot1)
	end

	return 0
end

function slot0.getTaskTypeKey(slot0, slot1)
	if slot0 == RoomSceneTaskEnum.ListenerType.EditResTypeReach then
		return tostring(slot0) .. "_" .. tostring(slot1)
	else
		return slot0
	end
end

function slot0.isTaskOverUnlockLevel(slot0)
	return uv0.getTaskUnlockLevel(slot0.openLimit) <= RoomMapModel.instance:getRoomLevel()
end

function slot0.getTaskUnlockLevel(slot0)
	slot5 = "(%w+)=(%w+)"

	for slot5, slot6 in string.gmatch(slot0, slot5) do
		-- Nothing
	end

	return tonumber(({
		[slot5] = slot6
	}).RoomLevel) or 0
end

function slot0.getRewardConfigAndIcon(slot0)
	if slot0 and #string.split(slot0.bonus, "|") > 0 then
		slot1 = string.splitToNumber(slot1[1], "#")
		slot2, slot3 = ItemModel.instance:getItemConfigAndIcon(slot1[1], slot1[2])

		return slot2, slot3, tonumber(slot1[3])
	end

	return nil
end

slot0.instance = slot0.New()

return slot0
