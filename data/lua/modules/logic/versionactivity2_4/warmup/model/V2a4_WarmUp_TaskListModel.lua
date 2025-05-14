module("modules.logic.versionactivity2_4.warmup.model.V2a4_WarmUp_TaskListModel", package.seeall)

local var_0_0 = class("V2a4_WarmUp_TaskListModel", ListScrollModel)

function var_0_0.setTaskList(arg_1_0)
	arg_1_0._taskMoList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity125, V2a4_WarmUpConfig.instance:actId())

	table.sort(arg_1_0._taskMoList, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_2_0.config.sorting
		local var_2_1 = arg_2_1.config.sorting
		local var_2_2 = arg_2_0.hasFinished and 1 or 0
		local var_2_3 = arg_2_1.hasFinished and 1 or 0

		if var_2_2 ~= var_2_3 then
			return var_2_3 < var_2_2
		end

		local var_2_4 = arg_2_0:isClaimed() and 1 or 0
		local var_2_5 = arg_2_1:isClaimed() and 1 or 0

		if var_2_4 ~= var_2_5 then
			return var_2_4 < var_2_5
		end

		if var_2_0 ~= var_2_1 then
			return var_2_0 < var_2_1
		end

		return arg_2_0.id < arg_2_1.id
	end)
	arg_1_0:setList(arg_1_0._taskMoList)
end

function var_0_0.refreshList(arg_3_0)
	local var_3_0 = arg_3_0:getFinishTaskCount()

	if false and var_3_0 > 1 then
		local var_3_1 = tabletool.copy(arg_3_0._taskMoList)

		table.insert(var_3_1, 1, {
			getAll = true
		})
		arg_3_0:setList(var_3_1)
	else
		arg_3_0:setList(arg_3_0._taskMoList)
	end
end

function var_0_0.getFinishTaskCount(arg_4_0)
	local var_4_0 = 0

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._taskMoList) do
		if iter_4_1.hasFinished and iter_4_1.finishCount < iter_4_1:getMaxFinishCount() then
			var_4_0 = var_4_0 + 1
		end
	end

	return var_4_0
end

function var_0_0.getFinishTaskActivityCount(arg_5_0)
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._taskMoList) do
		if iter_5_1.hasFinished and iter_5_1.finishCount < iter_5_1:getMaxFinishCount() then
			var_5_0 = var_5_0 + iter_5_1.config.activity
		end
	end

	return var_5_0
end

function var_0_0.getGetRewardTaskCount(arg_6_0)
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._taskMoList) do
		if iter_6_1:isClaimed() then
			var_6_0 = var_6_0 + 1
		end
	end

	return var_6_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
