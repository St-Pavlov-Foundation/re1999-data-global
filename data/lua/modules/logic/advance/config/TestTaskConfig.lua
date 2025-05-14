module("modules.logic.advance.config.TestTaskConfig", package.seeall)

local var_0_0 = class("TestTaskConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._taskConfigs = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"test_server_task"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._taskConfigs = arg_3_2
end

function var_0_0.getTaskList(arg_4_0)
	if arg_4_0._task_list then
		return arg_4_0._task_list
	end

	arg_4_0._task_list = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0._taskConfigs.configDict) do
		table.insert(arg_4_0._task_list, iter_4_1)
	end

	return arg_4_0._task_list
end

var_0_0.instance = var_0_0.New()

return var_0_0
