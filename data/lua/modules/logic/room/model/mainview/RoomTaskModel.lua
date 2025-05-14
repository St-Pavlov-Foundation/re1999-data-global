module("modules.logic.room.model.mainview.RoomTaskModel", package.seeall)

local var_0_0 = class("RoomTaskModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)

	arg_3_0._taskDatas = nil
	arg_3_0._taskMap = nil
	arg_3_0._showList = nil
	arg_3_0._taskFinishMap = nil
	arg_3_0.hasTask = false
	arg_3_0._isRunning = false
end

function var_0_0.buildDatas(arg_4_0)
	arg_4_0._isRunning = true
	arg_4_0.hasTask = false

	arg_4_0:initData()
	arg_4_0:initConfig()
end

function var_0_0.handleTaskUpdate(arg_5_0)
	if arg_5_0._isRunning then
		arg_5_0.hasTask = false

		return arg_5_0:updateData()
	end
end

function var_0_0.initData(arg_6_0)
	local var_6_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Room)
	local var_6_1 = {}
	local var_6_2 = {}
	local var_6_3 = {}

	if var_6_0 then
		for iter_6_0, iter_6_1 in pairs(var_6_0) do
			if iter_6_1.config ~= nil then
				if iter_6_1.finishCount <= 0 then
					arg_6_0.hasTask = true

					table.insert(var_6_1, iter_6_1)

					var_6_2[iter_6_1.id] = iter_6_1
				else
					var_6_3[iter_6_1.id] = iter_6_1
				end
			end
		end
	end

	table.sort(var_6_1, RoomSceneTaskController.sortTask)

	arg_6_0._taskDatas = var_6_1
	arg_6_0._taskMap = var_6_2
	arg_6_0._taskFinishMap = var_6_3
end

function var_0_0.initConfig(arg_7_0)
	local var_7_0 = TaskConfig.instance:gettaskroomlist()
	local var_7_1 = {}
	local var_7_2 = false

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_3 = iter_7_1.id

		if not var_7_2 and (arg_7_0._taskFinishMap[var_7_3] or arg_7_0._taskMap[var_7_3]) and iter_7_1.isOnline == 1 then
			var_7_2 = true
		end

		local var_7_4 = arg_7_0._taskFinishMap[var_7_3] == nil

		if var_7_2 and var_7_4 then
			table.insert(var_7_1, iter_7_1)
		end
	end

	table.sort(var_7_1, RoomSceneTaskController.sortTaskConfig)

	arg_7_0._showList = var_7_1
end

function var_0_0.updateData(arg_8_0)
	local var_8_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Room)
	local var_8_1

	if var_8_0 then
		local var_8_2 = false

		for iter_8_0, iter_8_1 in pairs(var_8_0) do
			if iter_8_1.config ~= nil then
				local var_8_3 = iter_8_1.finishCount <= 0

				if not var_8_3 then
					if arg_8_0._taskMap[iter_8_0] then
						var_8_1 = var_8_1 or {}

						table.insert(var_8_1, iter_8_1)
						arg_8_0:deleteTaskData(iter_8_1)
					end

					arg_8_0._taskFinishMap[iter_8_1.id] = iter_8_1
				elseif var_8_3 then
					if not arg_8_0._taskMap[iter_8_0] then
						arg_8_0:addTaskData(iter_8_1)

						var_8_2 = true
					else
						arg_8_0:updateTaskData(iter_8_1)
					end
				end
			end
		end

		if var_8_2 then
			table.sort(arg_8_0._taskDatas, RoomSceneTaskController.sortTask)
			arg_8_0:initConfig()
		end
	end

	return var_8_1
end

function var_0_0.deleteTaskData(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.config.id

	for iter_9_0, iter_9_1 in pairs(arg_9_0._taskDatas) do
		if iter_9_1.config.id == var_9_0 then
			table.remove(arg_9_0._taskDatas, iter_9_0)
		end
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_0._showList) do
		if var_9_0 == iter_9_3.id then
			table.remove(arg_9_0._showList, iter_9_2)
		end
	end

	arg_9_0._taskMap[var_9_0] = nil
end

function var_0_0.addTaskData(arg_10_0, arg_10_1)
	table.insert(arg_10_0._taskDatas, arg_10_1)

	arg_10_0._taskMap[arg_10_1.id] = arg_10_1
end

function var_0_0.updateTaskData(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.config.id

	for iter_11_0, iter_11_1 in pairs(arg_11_0._taskDatas) do
		if iter_11_1.config.id == var_11_0 then
			arg_11_0._taskDatas[iter_11_0] = arg_11_1

			break
		end
	end

	arg_11_0._taskMap[var_11_0] = arg_11_1
end

function var_0_0.getTaskDatas(arg_12_0)
	return arg_12_0._taskDatas
end

function var_0_0.getNextTaskConfig(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0._showList) do
		if not arg_13_0._taskMap[iter_13_1.id] and not arg_13_0._taskFinishMap[iter_13_1.id] then
			return iter_13_1
		end
	end

	return nil
end

function var_0_0.tryGetTaskMO(arg_14_0, arg_14_1)
	return arg_14_0._taskMap[arg_14_1]
end

function var_0_0.getShowList(arg_15_0)
	return arg_15_0._showList
end

var_0_0.instance = var_0_0.New()

return var_0_0
