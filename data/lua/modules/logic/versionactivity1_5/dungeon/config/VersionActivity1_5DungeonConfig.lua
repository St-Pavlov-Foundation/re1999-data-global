module("modules.logic.versionactivity1_5.dungeon.config.VersionActivity1_5DungeonConfig", package.seeall)

local var_0_0 = class("VersionActivity1_5DungeonConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"act139_dispatch_task",
		"activity140_building",
		"activity11502_episode_element",
		"act139_explore_task",
		"act139_hero_task",
		"act139_sub_hero_task",
		"activity139_const",
		"activity140_const"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity139_const" then
		arg_3_0.exploreTaskReward = string.splitToNumber(arg_3_2.configDict[1].value, "#")
		arg_3_0.exploreTaskUnlockEpisodeId = tonumber(arg_3_2.configDict[2].value)
		arg_3_0.exploreTaskLockToastId = tonumber(arg_3_2.configDict[3].value)
		arg_3_0.revivalTaskUnlockEpisodeId = tonumber(arg_3_2.configDict[4].value)
		arg_3_0.revivalTaskLockToastId = tonumber(arg_3_2.configDict[5].value)
	elseif arg_3_1 == "activity140_const" then
		arg_3_0.buildReward = string.splitToNumber(arg_3_2.configDict[2].value, "#")
		arg_3_0.buildUnlockEpisodeId = tonumber(arg_3_2.configDict[3].value)
		arg_3_0.buildLockToastId = tonumber(arg_3_2.configDict[4].value)
	end
end

function var_0_0.initSubHeroTaskCo(arg_4_0)
	if arg_4_0.initedSubHeroTask then
		return
	end

	local var_4_0 = {
		__index = function(arg_5_0, arg_5_1)
			return rawget(arg_5_0, arg_5_1) or rawget(arg_5_0, "srcCo")[arg_5_1]
		end
	}

	arg_4_0.taskId2SubTaskListDict = {}
	arg_4_0.subHeroTaskElementIdDict = {}

	for iter_4_0, iter_4_1 in ipairs(lua_act139_sub_hero_task.configList) do
		local var_4_1 = arg_4_0.taskId2SubTaskListDict[iter_4_1.taskId]

		if not var_4_1 then
			var_4_1 = {}
			arg_4_0.taskId2SubTaskListDict[iter_4_1.taskId] = var_4_1
		end

		local var_4_2 = {}

		setmetatable(var_4_2, var_4_0)

		var_4_2.elementList = string.splitToNumber(iter_4_1.elementIds, "#")
		var_4_2.srcCo = iter_4_1
		var_4_2.id = iter_4_1.id

		table.insert(var_4_1, var_4_2)

		for iter_4_2, iter_4_3 in ipairs(var_4_2.elementList) do
			arg_4_0.subHeroTaskElementIdDict[iter_4_3] = var_4_2
		end
	end

	for iter_4_4, iter_4_5 in ipairs(arg_4_0.taskId2SubTaskListDict) do
		table.sort(iter_4_5, function(arg_6_0, arg_6_1)
			return arg_6_0.id < arg_6_1.id
		end)
	end
end

function var_0_0.getDispatchCo(arg_7_0, arg_7_1)
	return lua_act139_dispatch_task.configDict[arg_7_1]
end

function var_0_0.initExploreTaskCo(arg_8_0)
	if arg_8_0.initedExploreTask then
		return
	end

	arg_8_0.exploreTaskCoDict = {}
	arg_8_0.exploreTaskCoList = {}
	arg_8_0.elementId2ExploreCoDict = {}
	arg_8_0.initedExploreTask = true

	local var_8_0 = {
		__index = function(arg_9_0, arg_9_1)
			return rawget(arg_9_0, arg_9_1) or rawget(arg_9_0, "srcCo")[arg_9_1]
		end
	}

	for iter_8_0, iter_8_1 in ipairs(lua_act139_explore_task.configList) do
		local var_8_1 = {}

		setmetatable(var_8_1, var_8_0)

		var_8_1.srcCo = iter_8_1
		var_8_1.elementList = string.splitToNumber(iter_8_1.elementIds, "#")

		local var_8_2 = string.splitToNumber(iter_8_1.areaPos, "#")

		var_8_1.areaPosX = var_8_2[1]
		var_8_1.areaPosY = var_8_2[2]

		table.insert(arg_8_0.exploreTaskCoList, var_8_1)

		arg_8_0.exploreTaskCoDict[iter_8_1.id] = var_8_1

		for iter_8_2, iter_8_3 in ipairs(var_8_1.elementList) do
			arg_8_0.elementId2ExploreCoDict[iter_8_3] = var_8_1
		end
	end
end

function var_0_0.getExploreTaskList(arg_10_0)
	arg_10_0:initExploreTaskCo()

	return arg_10_0.exploreTaskCoList
end

function var_0_0.getExploreTask(arg_11_0, arg_11_1)
	arg_11_0:initExploreTaskCo()

	return arg_11_0.exploreTaskCoDict[arg_11_1]
end

function var_0_0.getExploreTaskByElementId(arg_12_0, arg_12_1)
	arg_12_0:initExploreTaskCo()

	return arg_12_0.elementId2ExploreCoDict[arg_12_1]
end

function var_0_0.getHeroTaskCo(arg_13_0, arg_13_1)
	return lua_act139_hero_task.configDict[arg_13_1]
end

function var_0_0.getSubHeroTaskList(arg_14_0, arg_14_1)
	arg_14_0:initSubHeroTaskCo()

	return arg_14_0.taskId2SubTaskListDict[arg_14_1]
end

function var_0_0.getExploreReward(arg_15_0)
	return arg_15_0.exploreTaskReward[1], arg_15_0.exploreTaskReward[2], arg_15_0.exploreTaskReward[3]
end

function var_0_0.getExploreUnlockEpisodeId(arg_16_0)
	return arg_16_0.exploreTaskUnlockEpisodeId
end

function var_0_0.getSubHeroTaskCoByElementId(arg_17_0, arg_17_1)
	arg_17_0:initSubHeroTaskCo()

	return arg_17_0.subHeroTaskElementIdDict[arg_17_1]
end

function var_0_0.initBuildInfoList(arg_18_0)
	if arg_18_0.initBuild then
		return
	end

	local var_18_0 = {
		__index = function(arg_19_0, arg_19_1)
			return rawget(arg_19_0, arg_19_1) or rawget(arg_19_0, "srcCo")[arg_19_1]
		end
	}

	arg_18_0.initBuild = true
	arg_18_0.groupId2CoDict = {}
	arg_18_0.buildCoList = {}

	for iter_18_0, iter_18_1 in ipairs(lua_activity140_building.configList) do
		local var_18_1 = arg_18_0.groupId2CoDict[iter_18_1.group]

		if not var_18_1 then
			var_18_1 = {}
			arg_18_0.groupId2CoDict[iter_18_1.group] = var_18_1
		end

		local var_18_2 = {}

		setmetatable(var_18_2, var_18_0)

		var_18_2.costList = string.splitToNumber(iter_18_1.cost, "#")
		var_18_2.id = iter_18_1.id
		var_18_2.srcCo = iter_18_1

		local var_18_3 = string.splitToNumber(iter_18_1.focusPos, "#")

		var_18_2.focusPosX = var_18_3[1]
		var_18_2.focusPosY = var_18_3[2]

		table.insert(arg_18_0.buildCoList, var_18_2)

		var_18_1[iter_18_1.type] = var_18_2
	end
end

function var_0_0.getBuildCo(arg_20_0, arg_20_1)
	arg_20_0:initBuildInfoList()

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.buildCoList) do
		if iter_20_1.id == arg_20_1 then
			return iter_20_1
		end
	end

	logError("not found build id : " .. tostring(arg_20_1))
end

function var_0_0.getBuildCoByGroupAndType(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0:initBuildInfoList()

	return arg_21_0.groupId2CoDict[arg_21_1][arg_21_2]
end

function var_0_0.getBuildCoList(arg_22_0, arg_22_1)
	arg_22_0:initBuildInfoList()

	return arg_22_0.groupId2CoDict[arg_22_1]
end

function var_0_0.getBuildReward(arg_23_0)
	return arg_23_0.buildReward[1], arg_23_0.buildReward[2], arg_23_0.buildReward[3]
end

function var_0_0.getBuildUnlockEpisodeId(arg_24_0)
	return arg_24_0.buildUnlockEpisodeId
end

function var_0_0.checkElementBelongMapId(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = lua_activity11502_episode_element.configDict[arg_25_1.id]
	local var_25_1

	if not string.nilorempty(var_25_0.mapIds) then
		var_25_1 = string.splitToNumber(var_25_0.mapIds, "#")
	else
		var_25_1 = {
			arg_25_1.mapId
		}
	end

	return tabletool.indexOf(var_25_1, arg_25_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
