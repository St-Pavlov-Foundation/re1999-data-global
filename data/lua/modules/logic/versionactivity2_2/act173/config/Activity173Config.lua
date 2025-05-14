module("modules.logic.versionactivity2_2.act173.config.Activity173Config", package.seeall)

local var_0_0 = class("Activity173Config", BaseConfig)

function var_0_0.onInit(arg_1_0)
	arg_1_0._taskCfg = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity173_task",
		"act173_global_task"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity173_task" then
		arg_3_0._taskCfg = arg_3_2
	elseif arg_3_1 == "act173_global_task" then
		arg_3_0._globalTaskCo = arg_3_2
	end
end

function var_0_0.getTaskConfig(arg_4_0, arg_4_1)
	return arg_4_0._taskCfg.configDict[arg_4_1]
end

function var_0_0.getAllOnlineTasks(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._taskCfg.configList) do
		if iter_5_1.isOnline == 1 then
			table.insert(var_5_0, iter_5_1)
		end
	end

	table.sort(var_5_0, arg_5_0.onlineTaskSortFunc)

	return var_5_0
end

function var_0_0.onlineTaskSortFunc(arg_6_0, arg_6_1)
	if arg_6_0.sortId ~= arg_6_1.sortId then
		return arg_6_0.sortId < arg_6_1.sortId
	end

	return arg_6_0.id < arg_6_1.id
end

function var_0_0.getGlobalTaskStages(arg_7_0)
	return arg_7_0._globalTaskCo and arg_7_0._globalTaskCo.configList
end

function var_0_0.getGlobalVisibleTaskStages(arg_8_0)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._globalTaskCo.configList) do
		if iter_8_1.isVisible == 1 then
			table.insert(var_8_0, iter_8_1)
		end
	end

	return var_8_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
