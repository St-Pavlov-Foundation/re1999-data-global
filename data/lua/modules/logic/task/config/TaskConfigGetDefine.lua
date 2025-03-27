module("modules.logic.task.config.TaskConfigGetDefine", package.seeall)

slot0 = class("TaskConfigGetDefine", BaseConfig)

function slot0._getActivity189(slot0)
	return Activity189Config.instance:getTaskCO(slot0)
end

function slot0.ctor(slot0)
	slot0._defineList = {
		[TaskEnum.TaskType.Activity189] = uv0._getActivity189,
		[TaskEnum.TaskType.Daily] = uv0._getDaily,
		[TaskEnum.TaskType.Weekly] = uv0._getWeekly,
		[TaskEnum.TaskType.Achievement] = uv0._getAchievement,
		[TaskEnum.TaskType.Novice] = uv0._getNovice,
		[TaskEnum.TaskType.Room] = uv0._getRoom,
		[TaskEnum.TaskType.Activity106] = uv0._getAct106,
		[TaskEnum.TaskType.Season] = uv0._getSeason,
		[TaskEnum.TaskType.ActivityDungeon] = uv0._getActivityDungeon,
		[TaskEnum.TaskType.ActivityShow] = uv0._getActivityShow,
		[TaskEnum.TaskType.Activity128] = uv0._getActivity128,
		[TaskEnum.TaskType.Season123] = uv0._getSeason123,
		[TaskEnum.TaskType.RoleActivity] = uv0._getRoleActivity,
		[TaskEnum.TaskType.Activity125] = uv0._getActivity125
	}
end

function slot0._getDaily(slot0)
	return TaskConfig.instance:gettaskdailyCO(slot0)
end

function slot0._getWeekly(slot0)
	return TaskConfig.instance:gettaskweeklyCO(slot0)
end

function slot0._getAchievement(slot0)
	return TaskConfig.instance:gettaskachievementCO(slot0)
end

function slot0._getNovice(slot0)
	return TaskConfig.instance:gettaskNoviceConfig(slot0)
end

function slot0._getRoom(slot0)
	return TaskConfig.instance:gettaskRoomCO(slot0)
end

function slot0._getAct106(slot0)
	return Activity106Config.instance:getActivityWarmUpTaskCo(slot0)
end

function slot0._getSeason(slot0)
	return TaskConfig.instance:getSeasonTaskCo(slot0)
end

function slot0._getActivityDungeon(slot0)
	return VersionActivityConfig.instance:getAct113TaskConfig(slot0)
end

function slot0._getActivityShow(slot0)
	return TaskConfig.instance:getTaskActivityShowConfig(slot0)
end

function slot0._getActivity128(slot0)
	return BossRushConfig.instance:getTaskCO(slot0)
end

function slot0._getSeason123(slot0)
	return Season123Config.instance:getSeason123TaskCo(slot0)
end

function slot0._getRoleActivity(slot0)
	return RoleActivityConfig.instance:getTaskCo(slot0)
end

function slot0.getTaskConfigFunc(slot0, slot1)
	return slot0._defineList[tonumber(slot1)]
end

function slot0._getActivity125(slot0)
	return Activity125Config.instance:getTaskCO(slot0)
end

slot0.instance = slot0.New()

return slot0
