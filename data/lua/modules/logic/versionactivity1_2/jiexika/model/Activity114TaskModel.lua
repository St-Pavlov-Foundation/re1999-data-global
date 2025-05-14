module("modules.logic.versionactivity1_2.jiexika.model.Activity114TaskModel", package.seeall)

local var_0_0 = class("Activity114TaskModel", ListScrollModel)

function var_0_0.onGetTaskList(arg_1_0, arg_1_1)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		local var_1_1 = Activity114TaskMo.New()

		var_1_1:update(iter_1_1)
		table.insert(var_1_0, var_1_1)
	end

	table.sort(var_1_0, arg_1_0.sortFunc)
	arg_1_0:setList(var_1_0)
end

function var_0_0.sortFunc(arg_2_0, arg_2_1)
	if arg_2_0.finishStatus == arg_2_1.finishStatus then
		return arg_2_0.config.taskId < arg_2_1.config.taskId
	else
		return arg_2_0.finishStatus < arg_2_1.finishStatus
	end
end

function var_0_0.onTaskListUpdate(arg_3_0, arg_3_1, arg_3_2)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_0 = arg_3_0:getById(iter_3_1.taskId)

		if var_3_0 then
			var_3_0:update(iter_3_1)
		else
			local var_3_1 = Activity114TaskMo.New()

			var_3_1:update(iter_3_1)
			arg_3_0:addAtLast(var_3_1)
		end
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_2) do
		local var_3_2 = arg_3_0:getById(iter_3_3.taskId)

		if var_3_2 then
			arg_3_0:remove(var_3_2)
		end
	end

	arg_3_0:sort(arg_3_0.sortFunc)
end

var_0_0.instance = var_0_0.New()

return var_0_0
