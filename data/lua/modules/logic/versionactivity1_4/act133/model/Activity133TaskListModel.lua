module("modules.logic.versionactivity1_4.act133.model.Activity133TaskListModel", package.seeall)

local var_0_0 = class("Activity133TaskListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.sortTaskMoList(arg_3_0)
	local var_3_0 = Activity133Model.instance:getTasksInfo()
	local var_3_1 = {}
	local var_3_2 = {}
	local var_3_3 = {}

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		if iter_3_1.finishCount >= iter_3_1.config.maxProgress then
			table.insert(var_3_3, iter_3_1)
		elseif iter_3_1.hasFinished then
			table.insert(var_3_1, iter_3_1)
		else
			table.insert(var_3_2, iter_3_1)
		end
	end

	table.sort(var_3_1, var_0_0._sortFunc)
	table.sort(var_3_2, var_0_0._sortFunc)
	table.sort(var_3_3, var_0_0._sortFunc)

	arg_3_0.taskMoList = {}

	tabletool.addValues(arg_3_0.taskMoList, var_3_1)
	tabletool.addValues(arg_3_0.taskMoList, var_3_2)
	tabletool.addValues(arg_3_0.taskMoList, var_3_3)
	arg_3_0:refreshList()
end

function var_0_0._sortFunc(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.finishCount > 0 and 3 or arg_4_0.progress >= arg_4_0.config.maxProgress and 1 or 2
	local var_4_1 = arg_4_1.finishCount > 0 and 3 or arg_4_1.progress >= arg_4_1.config.maxProgress and 1 or 2

	if var_4_0 ~= var_4_1 then
		return var_4_0 < var_4_1
	else
		return arg_4_0.config.id < arg_4_1.config.id
	end
end

function var_0_0.refreshList(arg_5_0)
	if arg_5_0:getFinishTaskCount() > 1 then
		local var_5_0 = tabletool.copy(arg_5_0.taskMoList)

		table.insert(var_5_0, 1, {
			getAll = true
		})
		arg_5_0:setList(var_5_0)
	else
		arg_5_0:setList(arg_5_0.taskMoList)
	end
end

function var_0_0.getFinishTaskCount(arg_6_0)
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.taskMoList) do
		if iter_6_1.hasFinished and iter_6_1.finishCount < iter_6_1.config.maxProgress then
			var_6_0 = var_6_0 + 1
		end
	end

	return var_6_0
end

function var_0_0.getFinishTaskActivityCount(arg_7_0)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.taskMoList) do
		if iter_7_1.hasFinished and iter_7_1.finishCount < iter_7_1.config.maxProgress then
			var_7_0 = var_7_0 + iter_7_1.config.activity
		end
	end

	return var_7_0
end

function var_0_0.getGetRewardTaskCount(arg_8_0)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.taskMoList) do
		if iter_8_1.finishCount >= iter_8_1.config.maxProgress then
			var_8_0 = var_8_0 + 1
		end
	end

	return var_8_0
end

function var_0_0.getKeyRewardMo(arg_9_0)
	if arg_9_0.taskMoList then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0.taskMoList) do
			if iter_9_1.config.isKeyReward == 1 and iter_9_1.finishCount < iter_9_1.config.maxProgress then
				return iter_9_1
			end
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
