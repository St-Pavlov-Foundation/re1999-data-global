module("modules.logic.task.config.TaskConfigGetDefine", package.seeall)

local var_0_0 = class("TaskConfigGetDefine", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._defineList = {
		[TaskEnum.TaskType.Activity189] = var_0_0._getActivity189,
		[TaskEnum.TaskType.Daily] = var_0_0._getDaily,
		[TaskEnum.TaskType.Weekly] = var_0_0._getWeekly,
		[TaskEnum.TaskType.Achievement] = var_0_0._getAchievement,
		[TaskEnum.TaskType.Novice] = var_0_0._getNovice,
		[TaskEnum.TaskType.Room] = var_0_0._getRoom,
		[TaskEnum.TaskType.Activity106] = var_0_0._getAct106,
		[TaskEnum.TaskType.Season] = var_0_0._getSeason,
		[TaskEnum.TaskType.ActivityDungeon] = var_0_0._getActivityDungeon,
		[TaskEnum.TaskType.ActivityShow] = var_0_0._getActivityShow,
		[TaskEnum.TaskType.Activity128] = var_0_0._getActivity128,
		[TaskEnum.TaskType.Season123] = var_0_0._getSeason123,
		[TaskEnum.TaskType.RoleActivity] = var_0_0._getRoleActivity,
		[TaskEnum.TaskType.Activity125] = var_0_0._getActivity125,
		[TaskEnum.TaskType.Activity183] = var_0_0._getAct183Task,
		[TaskEnum.TaskType.Activity189] = var_0_0._getActivity189,
		[TaskEnum.TaskType.AssassinOutside] = var_0_0._getAssassinOutside,
		[TaskEnum.TaskType.StoreLinkPackage] = var_0_0._getStoreLinkPackage,
		[TaskEnum.TaskType.NecrologistStory] = var_0_0._getNecrologistStory,
		[TaskEnum.TaskType.Activity210] = function(arg_2_0)
			return lua_activity210_task.configDict[arg_2_0]
		end
	}
end

function var_0_0._getDaily(arg_3_0)
	return TaskConfig.instance:gettaskdailyCO(arg_3_0)
end

function var_0_0._getWeekly(arg_4_0)
	return TaskConfig.instance:gettaskweeklyCO(arg_4_0)
end

function var_0_0._getAchievement(arg_5_0)
	return TaskConfig.instance:gettaskachievementCO(arg_5_0)
end

function var_0_0._getNovice(arg_6_0)
	return TaskConfig.instance:gettaskNoviceConfig(arg_6_0)
end

function var_0_0._getRoom(arg_7_0)
	return TaskConfig.instance:gettaskRoomCO(arg_7_0)
end

function var_0_0._getAct106(arg_8_0)
	return Activity106Config.instance:getActivityWarmUpTaskCo(arg_8_0)
end

function var_0_0._getSeason(arg_9_0)
	return TaskConfig.instance:getSeasonTaskCo(arg_9_0)
end

function var_0_0._getActivityDungeon(arg_10_0)
	return VersionActivityConfig.instance:getAct113TaskConfig(arg_10_0)
end

function var_0_0._getActivityShow(arg_11_0)
	return TaskConfig.instance:getTaskActivityShowConfig(arg_11_0)
end

function var_0_0._getActivity128(arg_12_0)
	return BossRushConfig.instance:getTaskCO(arg_12_0)
end

function var_0_0._getSeason123(arg_13_0)
	return Season123Config.instance:getSeason123TaskCo(arg_13_0)
end

function var_0_0._getRoleActivity(arg_14_0)
	return RoleActivityConfig.instance:getTaskCo(arg_14_0)
end

function var_0_0._getAct183Task(arg_15_0)
	return Act183Config.instance:getTaskConfig(arg_15_0)
end

function var_0_0.getTaskConfigFunc(arg_16_0, arg_16_1)
	arg_16_1 = tonumber(arg_16_1)

	return arg_16_0._defineList[arg_16_1]
end

function var_0_0._getActivity125(arg_17_0)
	return Activity125Config.instance:getTaskCO(arg_17_0)
end

function var_0_0._getActivity189(arg_18_0)
	return Activity189Config.instance:getTaskCO(arg_18_0)
end

function var_0_0._getAssassinOutside(arg_19_0)
	return AssassinConfig.instance:getTaskCo(arg_19_0)
end

function var_0_0._getStoreLinkPackage(arg_20_0)
	return StoreConfig.instance:getChargeConditionalConfig(arg_20_0)
end

function var_0_0._getNecrologistStory(arg_21_0)
	return NecrologistStoryConfig.instance:getTaskCo(arg_21_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
