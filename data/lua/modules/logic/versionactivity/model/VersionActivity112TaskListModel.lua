module("modules.logic.versionactivity.model.VersionActivity112TaskListModel", package.seeall)

local var_0_0 = class("VersionActivity112TaskListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.taskDic = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.getActTask(arg_3_0, arg_3_1)
	if arg_3_0.taskDic[arg_3_1] == nil then
		arg_3_0.taskDic[arg_3_1] = {}

		local var_3_0 = VersionActivityConfig.instance:getActTaskDicConfig(arg_3_1)

		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			if iter_3_1.isOnline == 1 then
				local var_3_1 = VersionActivity112TaskMO.New()

				var_3_1:init(iter_3_1)

				arg_3_0.taskDic[arg_3_1][iter_3_1.taskId] = var_3_1
			end
		end
	end

	return arg_3_0.taskDic[arg_3_1]
end

function var_0_0.getTask(arg_4_0, arg_4_1, arg_4_2)
	return arg_4_0:getActTask(arg_4_1)[arg_4_2]
end

function var_0_0.refreshAlllTaskInfo(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.taskDic[arg_5_1] = nil

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		local var_5_0 = arg_5_0:getTask(arg_5_1, iter_5_1.taskId)

		if var_5_0 then
			var_5_0:update(iter_5_1)
		end
	end

	arg_5_0:sortTaksList()
end

function var_0_0.updateTaskInfo(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs(arg_6_2) do
		local var_6_0 = arg_6_0:getTask(arg_6_1, iter_6_1.taskId)

		if var_6_0 then
			var_6_0:update(iter_6_1)
		end
	end

	arg_6_0:sortTaksList()
	VersionActivityController.instance:dispatchEvent(VersionActivityEvent.VersionActivity112TaskUpdate)
end

function var_0_0.setGetBonus(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:getTask(arg_7_1, arg_7_2)

	if var_7_0 then
		var_7_0.hasGetBonus = true
	end

	arg_7_0:sortTaksList()
	VersionActivityController.instance:dispatchEvent(VersionActivityEvent.VersionActivity112TaskGetBonus, arg_7_2)
end

function var_0_0.sortTaksList(arg_8_0)
	local var_8_0 = arg_8_0:getList()

	table.sort(var_8_0, var_0_0.sort)
	arg_8_0:setList(var_8_0)
end

function var_0_0.updateTaksList(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:getActTask(arg_9_1)
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if arg_9_2 == (iter_9_1.config.minTypeId == 1) then
			table.insert(var_9_1, iter_9_1)
		end
	end

	table.sort(var_9_1, var_0_0.sort)
	arg_9_0:setList(var_9_1)
end

function var_0_0.sort(arg_10_0, arg_10_1)
	if arg_10_0.hasGetBonus ~= arg_10_1.hasGetBonus then
		return arg_10_1.hasGetBonus
	end

	local var_10_0 = arg_10_0:canGetBonus()

	if var_10_0 ~= arg_10_1:canGetBonus() then
		return var_10_0
	end

	return arg_10_0.id < arg_10_1.id
end

var_0_0.instance = var_0_0.New()

return var_0_0
