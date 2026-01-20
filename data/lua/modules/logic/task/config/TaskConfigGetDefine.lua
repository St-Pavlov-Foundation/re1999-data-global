-- chunkname: @modules/logic/task/config/TaskConfigGetDefine.lua

module("modules.logic.task.config.TaskConfigGetDefine", package.seeall)

local TaskConfigGetDefine = class("TaskConfigGetDefine", BaseConfig)

function TaskConfigGetDefine:ctor()
	self._defineList = {
		[TaskEnum.TaskType.Activity189] = TaskConfigGetDefine._getActivity189,
		[TaskEnum.TaskType.Daily] = TaskConfigGetDefine._getDaily,
		[TaskEnum.TaskType.Weekly] = TaskConfigGetDefine._getWeekly,
		[TaskEnum.TaskType.Achievement] = TaskConfigGetDefine._getAchievement,
		[TaskEnum.TaskType.Novice] = TaskConfigGetDefine._getNovice,
		[TaskEnum.TaskType.Room] = TaskConfigGetDefine._getRoom,
		[TaskEnum.TaskType.Activity106] = TaskConfigGetDefine._getAct106,
		[TaskEnum.TaskType.Season] = TaskConfigGetDefine._getSeason,
		[TaskEnum.TaskType.ActivityDungeon] = TaskConfigGetDefine._getActivityDungeon,
		[TaskEnum.TaskType.ActivityShow] = TaskConfigGetDefine._getActivityShow,
		[TaskEnum.TaskType.Activity128] = TaskConfigGetDefine._getActivity128,
		[TaskEnum.TaskType.Season123] = TaskConfigGetDefine._getSeason123,
		[TaskEnum.TaskType.RoleActivity] = TaskConfigGetDefine._getRoleActivity,
		[TaskEnum.TaskType.Activity125] = TaskConfigGetDefine._getActivity125,
		[TaskEnum.TaskType.Activity183] = TaskConfigGetDefine._getAct183Task,
		[TaskEnum.TaskType.Activity189] = TaskConfigGetDefine._getActivity189,
		[TaskEnum.TaskType.AssassinOutside] = TaskConfigGetDefine._getAssassinOutside,
		[TaskEnum.TaskType.StoreLinkPackage] = TaskConfigGetDefine._getStoreLinkPackage,
		[TaskEnum.TaskType.NecrologistStory] = TaskConfigGetDefine._getNecrologistStory,
		[TaskEnum.TaskType.Activity210] = function(id)
			return lua_activity210_task.configDict[id]
		end
	}
end

function TaskConfigGetDefine._getDaily(id)
	return TaskConfig.instance:gettaskdailyCO(id)
end

function TaskConfigGetDefine._getWeekly(id)
	return TaskConfig.instance:gettaskweeklyCO(id)
end

function TaskConfigGetDefine._getAchievement(id)
	return TaskConfig.instance:gettaskachievementCO(id)
end

function TaskConfigGetDefine._getNovice(id)
	return TaskConfig.instance:gettaskNoviceConfig(id)
end

function TaskConfigGetDefine._getRoom(id)
	return TaskConfig.instance:gettaskRoomCO(id)
end

function TaskConfigGetDefine._getAct106(id)
	return Activity106Config.instance:getActivityWarmUpTaskCo(id)
end

function TaskConfigGetDefine._getSeason(id)
	return TaskConfig.instance:getSeasonTaskCo(id)
end

function TaskConfigGetDefine._getActivityDungeon(id)
	return VersionActivityConfig.instance:getAct113TaskConfig(id)
end

function TaskConfigGetDefine._getActivityShow(id)
	return TaskConfig.instance:getTaskActivityShowConfig(id)
end

function TaskConfigGetDefine._getActivity128(id)
	return BossRushConfig.instance:getTaskCO(id)
end

function TaskConfigGetDefine._getSeason123(id)
	return Season123Config.instance:getSeason123TaskCo(id)
end

function TaskConfigGetDefine._getRoleActivity(id)
	return RoleActivityConfig.instance:getTaskCo(id)
end

function TaskConfigGetDefine._getAct183Task(id)
	return Act183Config.instance:getTaskConfig(id)
end

function TaskConfigGetDefine:getTaskConfigFunc(type)
	type = tonumber(type)

	return self._defineList[type]
end

function TaskConfigGetDefine._getActivity125(id)
	return Activity125Config.instance:getTaskCO(id)
end

function TaskConfigGetDefine._getActivity189(id)
	return Activity189Config.instance:getTaskCO(id)
end

function TaskConfigGetDefine._getAssassinOutside(id)
	return AssassinConfig.instance:getTaskCo(id)
end

function TaskConfigGetDefine._getStoreLinkPackage(id)
	return StoreConfig.instance:getChargeConditionalConfig(id)
end

function TaskConfigGetDefine._getNecrologistStory(id)
	return NecrologistStoryConfig.instance:getTaskCo(id)
end

TaskConfigGetDefine.instance = TaskConfigGetDefine.New()

return TaskConfigGetDefine
