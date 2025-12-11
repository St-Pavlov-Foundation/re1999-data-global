module("modules.logic.weekwalk_2.model.WeekWalk_2TaskListModel", package.seeall)

local var_0_0 = class("WeekWalk_2TaskListModel", ListScrollModel)

function var_0_0.setTaskRewardList(arg_1_0, arg_1_1)
	arg_1_0._rewardList = arg_1_1
end

function var_0_0.getTaskRewardList(arg_2_0)
	return arg_2_0._rewardList
end

function var_0_0.getLayerTaskMapId(arg_3_0)
	return arg_3_0._layerTaskMapId
end

function var_0_0.getSortIndex(arg_4_0, arg_4_1)
	return arg_4_0._sortMap[arg_4_1] or 0
end

function var_0_0._canGet(arg_5_0, arg_5_1)
	local var_5_0 = var_0_0.instance:getTaskMo(arg_5_1)

	if var_5_0 then
		local var_5_1 = lua_task_weekwalk_ver2.configDict[arg_5_1]
		local var_5_2 = var_5_0.finishCount >= var_5_1.maxFinishCount

		if var_5_0.hasFinished and not var_5_2 then
			return true
		end
	end
end

function var_0_0.getCanGetList(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0:getList()) do
		if iter_6_1.id and arg_6_0:_canGet(iter_6_1.id) then
			table.insert(var_6_0, iter_6_1.id)
		end
	end

	return var_6_0
end

function var_0_0.checkPeriods(arg_7_0, arg_7_1)
	if string.nilorempty(arg_7_1.periods) then
		return true
	end

	local var_7_0 = string.splitToNumber(arg_7_1.periods, "#")
	local var_7_1 = var_7_0[1] or 0
	local var_7_2 = var_7_0[2] or 0
	local var_7_3 = WeekWalk_2Model.instance:getInfo()

	return var_7_3 and var_7_1 <= var_7_3.issueId and var_7_2 >= var_7_3.issueId
end

function var_0_0.showLayerTaskList(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._layerTaskMapId = arg_8_2

	local var_8_0 = {}

	arg_8_0._sortMap = {}

	local var_8_1 = 1
	local var_8_2 = 0
	local var_8_3 = lua_weekwalk_ver2.configDict[arg_8_2]
	local var_8_4 = var_8_3 and var_8_3.layer or 0
	local var_8_5 = WeekWalk_2Config.instance:getWeekWalkTaskList(arg_8_1)

	for iter_8_0, iter_8_1 in ipairs(var_8_5) do
		if iter_8_1.layerId == var_8_4 and arg_8_0:checkPeriods(iter_8_1) then
			table.insert(var_8_0, iter_8_1)

			arg_8_0._sortMap[iter_8_1] = var_8_1
			var_8_1 = var_8_1 + 1

			if arg_8_0:_canGet(iter_8_1.id) then
				var_8_2 = var_8_2 + 1
			end
		end
	end

	table.sort(var_8_0, arg_8_0._sort)

	if var_8_2 > 1 then
		table.insert(var_8_0, 1, {
			id = 0,
			isGetAll = true,
			minTypeId = arg_8_1
		})
	end

	local var_8_6 = {
		isDirtyData = true
	}

	table.insert(var_8_0, var_8_6)
	arg_8_0:setList(var_8_0)
end

function var_0_0.showTaskList(arg_9_0, arg_9_1, arg_9_2)
	var_0_0._mapId = tostring(arg_9_2)

	local var_9_0 = WeekWalk_2Config.instance:getWeekWalkTaskList(arg_9_1)

	table.sort(var_9_0, arg_9_0._sort)

	local var_9_1 = {}

	if arg_9_0:canGetRewardNum(arg_9_1) > 1 then
		table.insert(var_9_1, 1, {
			id = 0,
			isGetAll = true,
			minTypeId = arg_9_1
		})
	end

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		table.insert(var_9_1, iter_9_1)
	end

	local var_9_2 = {
		isDirtyData = true
	}

	table.insert(var_9_1, var_9_2)
	arg_9_0:setList(var_9_1)
end

function var_0_0.canGetRewardNum(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = WeekWalk_2Config.instance:getWeekWalkTaskList(arg_10_1)
	local var_10_1 = 0
	local var_10_2 = 0
	local var_10_3

	if arg_10_2 then
		var_10_3 = lua_weekwalk_ver2.configDict[arg_10_2].layer
	end

	if not var_10_0 then
		return var_10_1, var_10_2
	end

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_4 = var_0_0.instance:getTaskMo(iter_10_1.id)

		if var_10_4 then
			local var_10_5 = lua_task_weekwalk_ver2.configDict[iter_10_1.id]
			local var_10_6 = var_10_4.finishCount >= var_10_5.maxFinishCount
			local var_10_7 = var_10_4.hasFinished

			if (not var_10_3 or iter_10_1.layerId == var_10_3) and arg_10_0:checkPeriods(iter_10_1) then
				if not var_10_6 then
					var_10_2 = var_10_2 + 1
				end

				if var_10_7 and not var_10_6 then
					var_10_1 = var_10_1 + 1
				end
			end
		end
	end

	return var_10_1, var_10_2
end

function var_0_0.getAllTaskInfo(arg_11_0)
	local var_11_0 = 0
	local var_11_1 = 0
	local var_11_2 = {}
	local var_11_3
	local var_11_4
	local var_11_5 = WeekWalk_2Model.instance:getInfo()

	for iter_11_0 = 1, WeekWalk_2Enum.MaxLayer do
		local var_11_6 = var_11_5:getLayerInfoByLayerIndex(iter_11_0)
		local var_11_7 = WeekWalk_2Config.instance:getWeekWalkRewardList(var_11_6.config.layer)

		if var_11_7 then
			var_11_3 = var_11_3 or var_11_6.id

			for iter_11_1, iter_11_2 in pairs(var_11_7) do
				local var_11_8 = lua_task_weekwalk_ver2.configDict[iter_11_1]

				if var_11_8 and var_0_0.instance:checkPeriods(var_11_8) then
					var_11_1 = var_11_1 + iter_11_2

					local var_11_9 = var_0_0.instance:getTaskMo(iter_11_1)
					local var_11_10 = lua_task_weekwalk_ver2.configDict[iter_11_1]

					if var_11_9 and var_11_9.finishCount >= var_11_10.maxFinishCount then
						var_11_0 = var_11_0 + iter_11_2
					elseif var_11_9 and var_11_9.hasFinished then
						table.insert(var_11_2, iter_11_1)

						var_11_4 = var_11_4 or var_11_6.id
					end
				end
			end
		end
	end

	return var_11_0, var_11_1, var_11_2, var_11_4 or var_11_3
end

function var_0_0.getOnceAllTaskInfo(arg_12_0)
	local var_12_0 = 0
	local var_12_1 = 0
	local var_12_2 = {}
	local var_12_3 = WeekWalk_2Config.instance:getWeekWalkTaskList(WeekWalk_2Enum.TaskType.Once)

	if var_12_3 then
		for iter_12_0, iter_12_1 in pairs(var_12_3) do
			local var_12_4 = iter_12_1.id
			local var_12_5 = lua_task_weekwalk_ver2.configDict[var_12_4]

			if var_12_5 and var_0_0.instance:checkPeriods(var_12_5) then
				local var_12_6 = var_0_0.instance:getTaskMo(var_12_4)
				local var_12_7 = lua_task_weekwalk_ver2.configDict[var_12_4]

				if var_12_6 and var_12_6.finishCount >= var_12_7.maxFinishCount then
					-- block empty
				elseif var_12_6 and var_12_6.hasFinished then
					table.insert(var_12_2, var_12_4)
				end
			end
		end
	end

	return var_12_0, var_12_1, var_12_2
end

function var_0_0.canGetReward(arg_13_0, arg_13_1)
	local var_13_0 = WeekWalk_2Config.instance:getWeekWalkTaskList(arg_13_1)

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_1 = var_0_0.instance:getTaskMo(iter_13_1.id)

		if not var_13_1 then
			return false
		end

		local var_13_2 = lua_task_weekwalk_ver2.configDict[iter_13_1.id]
		local var_13_3 = var_13_1.finishCount >= var_13_2.maxFinishCount

		if var_13_1.hasFinished and not var_13_3 then
			return true
		end
	end
end

function var_0_0._sort(arg_14_0, arg_14_1)
	local var_14_0 = var_0_0.instance:_taskStatus(arg_14_0)
	local var_14_1 = var_0_0.instance:_taskStatus(arg_14_1)
	local var_14_2 = arg_14_0.listenerParam == var_0_0._mapId
	local var_14_3 = arg_14_1.listenerParam == var_0_0._mapId

	if var_14_2 and not var_14_3 and var_14_0 ~= 3 then
		return true
	end

	if not var_14_2 and var_14_3 and var_14_1 ~= 3 then
		return false
	end

	if var_14_0 ~= var_14_1 then
		return var_14_0 < var_14_1
	end

	return arg_14_0.id < arg_14_1.id
end

function var_0_0._taskStatus(arg_15_0, arg_15_1)
	local var_15_0 = var_0_0.instance:getTaskMo(arg_15_1.id)
	local var_15_1 = lua_task_weekwalk_ver2.configDict[arg_15_1.id]

	if not var_15_0 or not var_15_1 then
		return 2
	end

	local var_15_2 = var_15_0.finishCount >= var_15_1.maxFinishCount
	local var_15_3 = var_15_0.hasFinished

	if var_15_2 then
		return 3
	elseif var_15_3 then
		return 1
	end

	return 2
end

function var_0_0.hasFinished(arg_16_0)
	local var_16_0 = arg_16_0:getList()

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_1 = var_0_0.instance:getTaskMo(iter_16_1.id)

		if var_16_1 and var_16_1.hasFinished then
			return true
		end
	end
end

function var_0_0.updateTaskList(arg_17_0)
	arg_17_0._taskList = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.WeekWalk_2)
end

function var_0_0.hasTaskList(arg_18_0)
	return arg_18_0._taskList
end

function var_0_0.getTaskMo(arg_19_0, arg_19_1)
	return arg_19_0._taskList and arg_19_0._taskList[arg_19_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
