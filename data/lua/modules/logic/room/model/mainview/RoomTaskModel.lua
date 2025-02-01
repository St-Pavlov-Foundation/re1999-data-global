module("modules.logic.room.model.mainview.RoomTaskModel", package.seeall)

slot0 = class("RoomTaskModel", BaseModel)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)

	slot0._taskDatas = nil
	slot0._taskMap = nil
	slot0._showList = nil
	slot0._taskFinishMap = nil
	slot0.hasTask = false
	slot0._isRunning = false
end

function slot0.buildDatas(slot0)
	slot0._isRunning = true
	slot0.hasTask = false

	slot0:initData()
	slot0:initConfig()
end

function slot0.handleTaskUpdate(slot0)
	if slot0._isRunning then
		slot0.hasTask = false

		return slot0:updateData()
	end
end

function slot0.initData(slot0)
	slot2 = {}
	slot3 = {}
	slot4 = {}

	if TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Room) then
		for slot8, slot9 in pairs(slot1) do
			if slot9.config ~= nil then
				if slot9.finishCount <= 0 then
					slot0.hasTask = true

					table.insert(slot2, slot9)

					slot3[slot9.id] = slot9
				else
					slot4[slot9.id] = slot9
				end
			end
		end
	end

	table.sort(slot2, RoomSceneTaskController.sortTask)

	slot0._taskDatas = slot2
	slot0._taskMap = slot3
	slot0._taskFinishMap = slot4
end

function slot0.initConfig(slot0)
	slot2 = {}

	for slot7, slot8 in ipairs(TaskConfig.instance:gettaskroomlist()) do
		slot9 = slot8.id

		if not false and (slot0._taskFinishMap[slot9] or slot0._taskMap[slot9]) and slot8.isOnline == 1 then
			slot3 = true
		end

		if slot3 and slot0._taskFinishMap[slot9] == nil then
			table.insert(slot2, slot8)
		end
	end

	table.sort(slot2, RoomSceneTaskController.sortTaskConfig)

	slot0._showList = slot2
end

function slot0.updateData(slot0)
	slot2 = nil

	if TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Room) then
		slot3 = false

		for slot7, slot8 in pairs(slot1) do
			if slot8.config ~= nil then
				if not (slot8.finishCount <= 0) then
					if slot0._taskMap[slot7] then
						table.insert(slot2 or {}, slot8)
						slot0:deleteTaskData(slot8)
					end

					slot0._taskFinishMap[slot8.id] = slot8
				elseif slot9 then
					if not slot0._taskMap[slot7] then
						slot0:addTaskData(slot8)

						slot3 = true
					else
						slot0:updateTaskData(slot8)
					end
				end
			end
		end

		if slot3 then
			table.sort(slot0._taskDatas, RoomSceneTaskController.sortTask)
			slot0:initConfig()
		end
	end

	return slot2
end

function slot0.deleteTaskData(slot0, slot1)
	for slot6, slot7 in pairs(slot0._taskDatas) do
		if slot7.config.id == slot1.config.id then
			table.remove(slot0._taskDatas, slot6)
		end
	end

	for slot6, slot7 in pairs(slot0._showList) do
		if slot2 == slot7.id then
			table.remove(slot0._showList, slot6)
		end
	end

	slot0._taskMap[slot2] = nil
end

function slot0.addTaskData(slot0, slot1)
	table.insert(slot0._taskDatas, slot1)

	slot0._taskMap[slot1.id] = slot1
end

function slot0.updateTaskData(slot0, slot1)
	slot2 = slot1.config.id

	for slot6, slot7 in pairs(slot0._taskDatas) do
		if slot7.config.id == slot2 then
			slot0._taskDatas[slot6] = slot1

			break
		end
	end

	slot0._taskMap[slot2] = slot1
end

function slot0.getTaskDatas(slot0)
	return slot0._taskDatas
end

function slot0.getNextTaskConfig(slot0)
	for slot4, slot5 in ipairs(slot0._showList) do
		if not slot0._taskMap[slot5.id] and not slot0._taskFinishMap[slot5.id] then
			return slot5
		end
	end

	return nil
end

function slot0.tryGetTaskMO(slot0, slot1)
	return slot0._taskMap[slot1]
end

function slot0.getShowList(slot0)
	return slot0._showList
end

slot0.instance = slot0.New()

return slot0
