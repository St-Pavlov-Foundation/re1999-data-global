module("modules.logic.investigate.model.InvestigateTaskListModel", package.seeall)

local var_0_0 = class("InvestigateTaskListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.initTask(arg_3_0)
	arg_3_0.taskMoList = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Investigate)
end

function var_0_0.sortTaskMoList(arg_4_0)
	if not arg_4_0.taskMoList then
		return
	end

	local var_4_0 = {}
	local var_4_1 = {}
	local var_4_2 = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0.taskMoList) do
		if (iter_4_1.config and iter_4_1.config.maxFinishCount or 1) <= iter_4_1.finishCount then
			table.insert(var_4_2, iter_4_1)
		elseif iter_4_1.hasFinished then
			table.insert(var_4_0, iter_4_1)
		else
			table.insert(var_4_1, iter_4_1)
		end
	end

	table.sort(var_4_0, var_0_0._sortFunc)
	table.sort(var_4_1, var_0_0._sortFunc)
	table.sort(var_4_2, var_0_0._sortFunc)

	arg_4_0.taskMoList = {}

	tabletool.addValues(arg_4_0.taskMoList, var_4_0)
	tabletool.addValues(arg_4_0.taskMoList, var_4_1)
	tabletool.addValues(arg_4_0.taskMoList, var_4_2)
end

function var_0_0._sortFunc(arg_5_0, arg_5_1)
	return arg_5_0.id < arg_5_1.id
end

function var_0_0.refreshList(arg_6_0)
	if not arg_6_0.taskMoList then
		return
	end

	if arg_6_0:getFinishTaskCount() > 1 then
		local var_6_0 = tabletool.copy(arg_6_0.taskMoList)

		table.insert(var_6_0, 1, {
			getAll = true
		})
		arg_6_0:setList(var_6_0)
	else
		arg_6_0:setList(arg_6_0.taskMoList)
	end
end

function var_0_0.getFinishTaskCount(arg_7_0)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.taskMoList) do
		local var_7_1 = iter_7_1.config and iter_7_1.config.maxFinishCount or 1

		if iter_7_1.hasFinished and var_7_1 > iter_7_1.finishCount then
			var_7_0 = var_7_0 + 1
		end
	end

	return var_7_0
end

function var_0_0.getFinishTaskActivityCount(arg_8_0)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.taskMoList) do
		local var_8_1 = iter_8_1.config and iter_8_1.config.maxFinishCount or 1

		if iter_8_1.hasFinished and var_8_1 > iter_8_1.finishCount then
			var_8_0 = var_8_0 + iter_8_1.config.activity
		end
	end

	return var_8_0
end

function var_0_0.getGetRewardTaskCount(arg_9_0)
	local var_9_0 = 0

	if not arg_9_0.taskMoList then
		return 0
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.taskMoList) do
		if (iter_9_1.config and iter_9_1.config.maxFinishCount or 1) <= iter_9_1.finishCount then
			var_9_0 = var_9_0 + 1
		end
	end

	return var_9_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
