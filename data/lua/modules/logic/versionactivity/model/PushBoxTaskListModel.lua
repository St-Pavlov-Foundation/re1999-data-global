module("modules.logic.versionactivity.model.PushBoxTaskListModel", package.seeall)

local var_0_0 = class("PushBoxTaskListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.initData(arg_3_0, arg_3_1)
	arg_3_0.data = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_0 = {
			id = iter_3_1.taskId,
			config = iter_3_1
		}

		table.insert(arg_3_0.data, var_3_0)
	end
end

function var_0_0.sortData(arg_4_0)
	table.sort(arg_4_0.data, var_0_0.sortList)
end

function var_0_0.sortList(arg_5_0, arg_5_1)
	local var_5_0 = PushBoxModel.instance:getTaskData(arg_5_0.config.taskId)
	local var_5_1 = PushBoxModel.instance:getTaskData(arg_5_1.config.taskId)

	if var_5_0.hasGetBonus and not var_5_1.hasGetBonus then
		return false
	elseif not var_5_0.hasGetBonus and var_5_1.hasGetBonus then
		return true
	else
		local var_5_2 = var_5_0.progress >= arg_5_0.config.maxProgress
		local var_5_3 = var_5_1.progress >= arg_5_1.config.maxProgress

		if var_5_2 and not var_5_3 then
			return true
		elseif not var_5_2 and var_5_3 then
			return false
		else
			return arg_5_0.config.sort < arg_5_1.config.sort
		end
	end
end

function var_0_0.refreshData(arg_6_0)
	arg_6_0:setList(arg_6_0.data)
end

function var_0_0.clearData(arg_7_0)
	arg_7_0:clear()

	arg_7_0.data = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
