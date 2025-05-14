module("modules.logic.room.controller.RoomSceneTaskController", package.seeall)

local var_0_0 = class("RoomSceneTaskController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	arg_3_0:release()
end

function var_0_0.release(arg_4_0)
	TaskController.instance:unregisterCallback(TaskEvent.SetTaskList, arg_4_0.refreshData, arg_4_0)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, arg_4_0.updateData, arg_4_0)
	RoomTaskModel.instance:clear()

	arg_4_0._taskList = nil
	arg_4_0._cfgGroup = nil
	arg_4_0._allTaskList = nil
	arg_4_0._taskMOIdSet = nil
	arg_4_0._needCheckFinish = true
end

function var_0_0.init(arg_5_0)
	arg_5_0:release()
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, arg_5_0.refreshData, arg_5_0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, arg_5_0.updateData, arg_5_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Room
	})
	RoomTaskModel.instance:buildDatas()
end

function var_0_0.showHideRoomTopTaskUI(arg_6_0, arg_6_1)
	arg_6_0:dispatchEvent(RoomEvent.TaskShowHideAnim, arg_6_1 == true)
end

function var_0_0.refreshData(arg_7_0)
	RoomTaskModel.instance:handleTaskUpdate()
	arg_7_0:dispatchEvent(RoomEvent.TaskUpdate)
	arg_7_0:checkTaskFinished()
end

function var_0_0.updateData(arg_8_0)
	RoomTaskModel.instance:handleTaskUpdate()
	arg_8_0:dispatchEvent(RoomEvent.TaskUpdate)

	if arg_8_0._needCheckFinish then
		arg_8_0:checkTaskFinished()
	end
end

function var_0_0.checkTaskFinished(arg_9_0)
	local var_9_0, var_9_1 = arg_9_0:isFirstTaskFinished()

	if var_9_0 then
		arg_9_0:dispatchEvent(RoomEvent.TaskCanFinish, var_9_1)
	end

	return var_9_0
end

function var_0_0.setTaskCheckFinishFlag(arg_10_0, arg_10_1)
	arg_10_0._needCheckFinish = arg_10_1
end

function var_0_0.isFirstTaskFinished(arg_11_0)
	local var_11_0 = RoomTaskModel.instance:getShowList()

	if var_11_0 ~= nil and #var_11_0 > 0 then
		local var_11_1

		for iter_11_0, iter_11_1 in ipairs(var_11_0) do
			local var_11_2 = iter_11_1.id
			local var_11_3 = RoomTaskModel.instance:tryGetTaskMO(var_11_2)

			if var_11_3 and var_11_3.hasFinished and var_11_3.finishCount <= 0 then
				var_11_1 = var_11_1 or {}

				table.insert(var_11_1, var_11_2)
			else
				return var_11_1 ~= nil, var_11_1
			end
		end

		return var_11_1 ~= nil, var_11_1
	end

	return false
end

function var_0_0.getProgressStatus(arg_12_0)
	return arg_12_0.hasFinished, arg_12_0.progress
end

function var_0_0.hasLocalModifyBlock(arg_13_0)
	if arg_13_0.hasFinished then
		return false
	end

	if not RoomSceneTaskValidator.canGetByLocal(arg_13_0) then
		return false
	end

	if RoomMapBlockModel.instance:getTempBlockMO() or RoomMapBuildingModel.instance:getTempBuildingMO() then
		return true
	else
		local var_13_0 = RoomMapBlockModel.instance:getBackBlockModel()

		if var_13_0 then
			return var_13_0:getCount() > 0
		end
	end

	return false
end

function var_0_0.sortTask(arg_14_0, arg_14_1)
	return var_0_0.sortTaskConfig(arg_14_0.config, arg_14_1.config)
end

function var_0_0.sortTaskConfig(arg_15_0, arg_15_1)
	local var_15_0 = var_0_0.getOrder(arg_15_0)
	local var_15_1 = var_0_0.getOrder(arg_15_1)

	if var_15_0 ~= var_15_1 then
		return var_15_0 < var_15_1
	else
		return arg_15_0.id < arg_15_1.id
	end
end

function var_0_0.getOrder(arg_16_0)
	if not string.nilorempty(arg_16_0.order) then
		local var_16_0 = string.match(arg_16_0.order, "%d+")

		if not string.nilorempty(var_16_0) then
			return tonumber(var_16_0)
		end
	end

	return 0
end

function var_0_0.getTaskTypeKey(arg_17_0, arg_17_1)
	if arg_17_0 == RoomSceneTaskEnum.ListenerType.EditResTypeReach then
		return tostring(arg_17_0) .. "_" .. tostring(arg_17_1)
	else
		return arg_17_0
	end
end

function var_0_0.isTaskOverUnlockLevel(arg_18_0)
	return RoomMapModel.instance:getRoomLevel() >= var_0_0.getTaskUnlockLevel(arg_18_0.openLimit)
end

function var_0_0.getTaskUnlockLevel(arg_19_0)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in string.gmatch(arg_19_0, "(%w+)=(%w+)") do
		var_19_0[iter_19_0] = iter_19_1
	end

	return tonumber(var_19_0.RoomLevel) or 0
end

function var_0_0.getRewardConfigAndIcon(arg_20_0)
	if arg_20_0 then
		local var_20_0 = string.split(arg_20_0.bonus, "|")

		if #var_20_0 > 0 then
			local var_20_1 = string.splitToNumber(var_20_0[1], "#")
			local var_20_2, var_20_3 = ItemModel.instance:getItemConfigAndIcon(var_20_1[1], var_20_1[2])

			return var_20_2, var_20_3, tonumber(var_20_1[3])
		end
	end

	return nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
