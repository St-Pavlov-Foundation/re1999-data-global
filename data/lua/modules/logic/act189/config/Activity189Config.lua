module("modules.logic.act189.config.Activity189Config", package.seeall)

local var_0_0 = string.format
local var_0_1 = table.insert
local var_0_2 = class("Activity189Config", BaseConfig)

function var_0_2.reqConfigNames(arg_1_0)
	return {
		"activity189_const",
		"activity189_mlstring",
		"activity189",
		"activity189_task"
	}
end

function var_0_2.onConfigLoaded(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == "activity189_task" then
		arg_2_0.__onlineTaskList = nil

		arg_2_0:__init_activity189_task(arg_2_2)
	end
end

function var_0_2.__init_activity189_task(arg_3_0, arg_3_1)
	if arg_3_0.__onlineTaskList then
		return arg_3_0.__onlineTaskList
	end

	local var_3_0 = {}

	if isDebugBuild then
		local var_3_1 = var_0_0("[logError] 189_运营改版活动.xlsx - export_任务")

		TaskConfig.instance:initReadTaskList(var_3_1, var_3_0, Activity189Enum.TaskTag, arg_3_1)
	else
		TaskConfig.instance:initReadTaskList(nil, var_3_0, Activity189Enum.TaskTag, arg_3_1)
	end

	arg_3_0.__onlineTaskList = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.configList) do
		if iter_3_1.isOnline then
			var_0_1(arg_3_0.__onlineTaskList, iter_3_1)
		end
	end

	arg_3_0.__readTasksTagTaskCoDict = var_3_0
end

function var_0_2.getSettingCO(arg_4_0, arg_4_1)
	return lua_activity189.configDict[arg_4_1]
end

function var_0_2.getBonusList(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getSettingCO(arg_5_1).bonus

	return GameUtil.splitString2(var_5_0, true) or {}
end

function var_0_2.getAllTaskList(arg_6_0, arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.__onlineTaskList) do
		if iter_6_1.activityId == arg_6_1 then
			var_0_1(var_6_0, iter_6_1)
		end
	end

	return var_6_0
end

function var_0_2.getTaskCO(arg_7_0, arg_7_1)
	return lua_activity189_task.configDict[arg_7_1]
end

function var_0_2.getConstCoById(arg_8_0, arg_8_1)
	return lua_activity189_const.configDict[arg_8_1]
end

function var_0_2.getTaskCO_ReadTask(arg_9_0, arg_9_1)
	return arg_9_0.__readTasksTagTaskCoDict[arg_9_1] or {}
end

function var_0_2.getTaskCO_ReadTask_Tag(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_0:getTaskCO_ReadTask(arg_10_1)[arg_10_2]
end

function var_0_2.getTaskCO_ReadTask_Tag_TaskId(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	return arg_11_0:getTaskCO_ReadTask_Tag(arg_11_1, arg_11_2)[arg_11_3]
end

function var_0_2.getTaskType(arg_12_0)
	return TaskEnum.TaskType.Activity189
end

var_0_2.instance = var_0_2.New()

return var_0_2
