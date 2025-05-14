module("modules.logic.roleactivity.config.RoleActivityConfig", package.seeall)

local var_0_0 = class("RoleActivityConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"roleactivity_enter",
		"role_activity_task"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "roleactivity_enter" then
		arg_3_0._enterConfig = arg_3_2
	elseif arg_3_1 == "role_activity_task" then
		arg_3_0._taskConfig = arg_3_2

		arg_3_0:_rebuildTaskConfig()
	end
end

function var_0_0._rebuildTaskConfig(arg_4_0)
	arg_4_0._taskDic = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0._taskConfig.configList) do
		arg_4_0._taskDic[iter_4_1.id] = iter_4_1
	end
end

function var_0_0.getActivityEnterInfo(arg_5_0, arg_5_1)
	return arg_5_0._enterConfig.configDict[arg_5_1]
end

function var_0_0.getTaskCo(arg_6_0, arg_6_1)
	return arg_6_0._taskDic[arg_6_1]
end

function var_0_0.getStoryLevelList(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._enterConfig.configDict[arg_7_1].storyGroupId

	return (DungeonConfig.instance:getChapterEpisodeCOList(var_7_0))
end

function var_0_0.getBattleLevelList(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._enterConfig.configDict[arg_8_1].episodeGroupId
	local var_8_1 = DungeonConfig.instance:getChapterEpisodeCOList(var_8_0) or {}

	table.sort(var_8_1, var_0_0.SortById)

	return var_8_1
end

function var_0_0.getActicityTaskList(arg_9_0, arg_9_1)
	return arg_9_0._taskConfig.configDict[arg_9_1]
end

function var_0_0.SortById(arg_10_0, arg_10_1)
	return arg_10_0.id < arg_10_1.id
end

var_0_0.instance = var_0_0.New()

return var_0_0
