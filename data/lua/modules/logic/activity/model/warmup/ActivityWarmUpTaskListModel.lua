module("modules.logic.activity.model.warmup.ActivityWarmUpTaskListModel", package.seeall)

local var_0_0 = class("ActivityWarmUpTaskListModel", ListScrollModel)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._totalDict = arg_1_0._totalDict or {}

	local var_1_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity106)
	local var_1_1 = Activity106Config.instance:getTaskByActId(arg_1_1)
	local var_1_2 = {}

	if var_1_0 ~= nil then
		for iter_1_0, iter_1_1 in ipairs(var_1_1) do
			local var_1_3 = iter_1_1.id
			local var_1_4 = var_1_0[var_1_3]

			if var_1_4 ~= nil then
				local var_1_5 = arg_1_0._totalDict[var_1_3]

				if not var_1_5 then
					var_1_5 = ActivityWarmUpTaskMO.New()
					arg_1_0._totalDict[var_1_3] = var_1_5
				end

				var_1_5:init(var_1_4, iter_1_1)
				table.insert(var_1_2, var_1_5)
			end
		end

		table.sort(var_1_2, var_0_0.sortMO)
	end

	arg_1_0._totalDatas = var_1_2

	arg_1_0:groupByDay()
end

function var_0_0.sortMO(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:alreadyGotReward()
	local var_2_1 = arg_2_1:alreadyGotReward()

	if var_2_0 ~= var_2_1 then
		return var_2_1
	else
		local var_2_2 = arg_2_0:isFinished()

		if var_2_2 ~= arg_2_1:isFinished() then
			return var_2_2
		end
	end

	return arg_2_0.id < arg_2_1.id
end

function var_0_0.setSelectedDay(arg_3_0, arg_3_1)
	arg_3_0._selectDay = arg_3_1
end

function var_0_0.updateDayList(arg_4_0)
	local var_4_0 = arg_4_0._taskGroup[arg_4_0:getSelectedDay()]

	if var_4_0 then
		arg_4_0:setList(var_4_0)
	end
end

function var_0_0.getSelectedDay(arg_5_0)
	return arg_5_0._selectDay
end

function var_0_0.groupByDay(arg_6_0)
	arg_6_0._taskGroup = {}

	local var_6_0 = arg_6_0._totalDatas

	if not var_6_0 then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = iter_6_1.config.openDay

		arg_6_0._taskGroup[var_6_1] = arg_6_0._taskGroup[var_6_1] or {}

		table.insert(arg_6_0._taskGroup[var_6_1], iter_6_1)
	end
end

function var_0_0.dayHasReward(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._taskGroup[arg_7_1]

	if var_7_0 then
		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			if not iter_7_1:alreadyGotReward() and iter_7_1:isFinished() then
				return true
			end
		end
	end

	return false
end

function var_0_0.release(arg_8_0)
	arg_8_0._totalDict = nil
	arg_8_0._totalDatas = nil
	arg_8_0._taskGroup = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
