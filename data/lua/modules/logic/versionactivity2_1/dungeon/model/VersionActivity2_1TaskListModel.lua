module("modules.logic.versionactivity2_1.dungeon.model.VersionActivity2_1TaskListModel", package.seeall)

local var_0_0 = class("VersionActivity2_1TaskListModel", ListScrollModel)

local function var_0_1(arg_1_0, arg_1_1)
	return arg_1_0.id < arg_1_1.id
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.reInit(arg_3_0)
	return
end

function var_0_0.initTask(arg_4_0)
	arg_4_0:clear()

	arg_4_0.taskMoList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityDungeon, VersionActivity2_1Enum.ActivityId.Dungeon)
end

function var_0_0.sortTaskMoList(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = {}
	local var_5_2 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.taskMoList) do
		if iter_5_1.finishCount >= iter_5_1.config.maxFinishCount then
			table.insert(var_5_2, iter_5_1)
		elseif iter_5_1.hasFinished then
			table.insert(var_5_0, iter_5_1)
		else
			table.insert(var_5_1, iter_5_1)
		end
	end

	table.sort(var_5_0, var_0_1)
	table.sort(var_5_1, var_0_1)
	table.sort(var_5_2, var_0_1)

	arg_5_0.taskMoList = {}

	tabletool.addValues(arg_5_0.taskMoList, var_5_0)
	tabletool.addValues(arg_5_0.taskMoList, var_5_1)
	tabletool.addValues(arg_5_0.taskMoList, var_5_2)
end

function var_0_0.refreshList(arg_6_0)
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
		if iter_7_1.hasFinished and iter_7_1.finishCount < iter_7_1.config.maxFinishCount then
			var_7_0 = var_7_0 + 1
		end
	end

	return var_7_0
end

function var_0_0.getFinishTaskActivityCount(arg_8_0)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.taskMoList) do
		if iter_8_1.hasFinished and iter_8_1.finishCount < iter_8_1.config.maxFinishCount then
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
		if iter_9_1.finishCount >= iter_9_1.config.maxFinishCount then
			var_9_0 = var_9_0 + 1
		end
	end

	return var_9_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
