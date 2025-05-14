module("modules.logic.versionactivity.config.VersionActivityConfig", package.seeall)

local var_0_0 = class("VersionActivityConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity106_task",
		"activity106_order",
		"activity106_minigame",
		"version_activity_puzzle_question",
		"activity112_task",
		"activity112",
		"activity113_task",
		"activity113_dungeon",
		"activity105"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0.activityId2TaskCountDict = {}
	arg_2_0.activityId2TaskConfigList = {}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity112_task" then
		arg_3_0._activity112TaskConfig = arg_3_2
	elseif arg_3_1 == "activity112" then
		arg_3_0._activity112Config = arg_3_2
	end
end

function var_0_0.getAct112Config(arg_4_0, arg_4_1)
	return arg_4_0._activity112Config.configDict[arg_4_1]
end

function var_0_0.getActTaskDicConfig(arg_5_0, arg_5_1)
	if arg_5_0._activity112TaskConfig.configDict[arg_5_1] then
		return arg_5_0._activity112TaskConfig.configDict[arg_5_1]
	end
end

function var_0_0.getTaskConfig(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._activity112TaskConfig.configDict[arg_6_1] then
		return arg_6_0._activity112TaskConfig.configDict[arg_6_1][arg_6_2]
	end
end

function var_0_0.getAct113TaskCount(arg_7_0, arg_7_1)
	if arg_7_0.activityId2TaskCountDict[arg_7_1] then
		return arg_7_0.activityId2TaskCountDict[arg_7_1]
	end

	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(lua_activity113_task.configList) do
		if iter_7_1.activityId == arg_7_1 and iter_7_1.isOnline == 1 then
			var_7_0 = var_7_0 + 1
		end
	end

	arg_7_0.activityId2TaskCountDict[arg_7_1] = var_7_0

	return arg_7_0.activityId2TaskCountDict[arg_7_1]
end

function var_0_0.getAct113TaskList(arg_8_0, arg_8_1)
	if arg_8_0.activityId2TaskConfigList[arg_8_1] then
		return arg_8_0.activityId2TaskConfigList[arg_8_1]
	end

	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(lua_activity113_task.configList) do
		if iter_8_1.activityId == arg_8_1 then
			table.insert(var_8_0, iter_8_1)
		end
	end

	arg_8_0.activityId2TaskConfigList[arg_8_1] = var_8_0

	return arg_8_0.activityId2TaskConfigList[arg_8_1]
end

function var_0_0.getAct113TaskConfig(arg_9_0, arg_9_1)
	return lua_activity113_task.configDict[arg_9_1]
end

function var_0_0.getAct113DungeonChapterIsOpen(arg_10_0, arg_10_1)
	local var_10_0 = lua_activity113_dungeon.configDict[arg_10_1]

	if not var_10_0 then
		return true
	end

	if ActivityHelper.getActivityStatus(var_10_0.activityId) ~= ActivityEnum.ActivityStatus.Normal then
		return false
	end

	local var_10_1 = ActivityModel.instance:getActivityInfo()[var_10_0.activityId]:getRealStartTimeStamp() + (var_10_0.openDay - 1) * TimeUtil.OneDaySecond

	return ServerTime.now() - var_10_1 >= 0
end

function var_0_0.getAct113DungeonChapterOpenTimeStamp(arg_11_0, arg_11_1)
	local var_11_0 = lua_activity113_dungeon.configDict[arg_11_1]

	return ActivityModel.instance:getActivityInfo()[var_11_0.activityId]:getRealStartTimeStamp() + (var_11_0.openDay - 1) * TimeUtil.OneDaySecond
end

var_0_0.instance = var_0_0.New()

return var_0_0
