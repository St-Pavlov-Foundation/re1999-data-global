module("modules.logic.versionactivity2_5.challenge.config.Act183Config", package.seeall)

local var_0_0 = class("Act183Config", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"challenge_episode",
		"challenge_daily_unlock",
		"challenge_condition",
		"challenge_badge",
		"challenge_task",
		"challenge_const"
	}
end

function var_0_0.onConfigLoaded(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == "challenge_episode" then
		arg_2_0:_onEpisodeConfigLoaded(arg_2_2)
	elseif arg_2_1 == "challenge_reward" then
		arg_2_0:_onRewardConfigsLoad(arg_2_2)
	elseif arg_2_1 == "challenge_task" then
		arg_2_0:_onTaskConfigLoaded(arg_2_2)
	end
end

function var_0_0._onEpisodeConfigLoaded(arg_3_0, arg_3_1)
	arg_3_0._episodeTab = arg_3_1
	arg_3_0._episodeGroupTab = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.configList) do
		local var_3_0 = iter_3_1.groupId
		local var_3_1 = iter_3_1.activityId
		local var_3_2 = arg_3_0._episodeGroupTab[var_3_1]

		if not var_3_2 then
			var_3_2 = {}
			arg_3_0._episodeGroupTab[var_3_1] = var_3_2
		end

		local var_3_3 = var_3_2[var_3_0]

		if not var_3_3 then
			var_3_3 = {}
			var_3_2[var_3_0] = var_3_3
		end

		table.insert(var_3_3, iter_3_1)
	end
end

function var_0_0.getEpisodeCo(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._episodeTab.configDict[arg_4_1]

	if not var_4_0 then
		logError(string.format("关卡配置不存在 episodeId = %s", arg_4_1))
	end

	return var_4_0
end

function var_0_0.getEpisodeCosByGroupId(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0._episodeGroupTab[arg_5_1]
	local var_5_1 = var_5_0 and var_5_0[arg_5_2]

	if not var_5_1 then
		logError(string.format("关卡组配置不存在 activityId = %s, groupId = %s", arg_5_1, arg_5_2))
	end

	return var_5_1
end

function var_0_0.getEpisodeAllRuleDesc(arg_6_0, arg_6_1)
	local var_6_0 = {}
	local var_6_1 = arg_6_0:getEpisodeRuleDesc(arg_6_1, 1)
	local var_6_2 = arg_6_0:getEpisodeRuleDesc(arg_6_1, 2)

	if not string.nilorempty(var_6_1) then
		table.insert(var_6_0, var_6_1)
	end

	if not string.nilorempty(var_6_2) then
		table.insert(var_6_0, var_6_2)
	end

	return var_6_0
end

function var_0_0.getEpisodeRuleDesc(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:getEpisodeCo(arg_7_1)

	if not var_7_0 then
		return
	end

	if arg_7_2 == 1 then
		return var_7_0.ruleDesc1
	elseif arg_7_2 == 2 then
		return var_7_0.ruleDesc2
	else
		logError(string.format("关卡机制序号不存在 episodeId = %s, ruleIndex = %s", arg_7_1, arg_7_2))
	end
end

function var_0_0._onRewardConfigsLoad(arg_8_0, arg_8_1)
	arg_8_0._taskTab = arg_8_1
	arg_8_0._taskChapterTab = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1.configList) do
		local var_8_0 = arg_8_0._taskChapterTab[iter_8_1.type1]

		if not var_8_0 then
			var_8_0 = {}
			arg_8_0._taskChapterTab[iter_8_1.type1] = var_8_0
		end

		local var_8_1 = var_8_0[iter_8_1.type2]

		if not var_8_1 then
			var_8_1 = {}
			var_8_0[iter_8_1.type2] = var_8_1
		end

		table.insert(var_8_1, iter_8_1)
	end
end

function var_0_0.getAllTaskByType(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._taskChapterTab[arg_9_1]

	if not var_9_0 then
		logError(string.format("无法找到挑战任务配置! taskType = %s", arg_9_1))
	end

	return var_9_0
end

function var_0_0.getChapterTasks(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:getAllTaskByType(arg_10_1)
	local var_10_1 = var_10_0 and var_10_0[arg_10_2]

	if not var_10_1 then
		logError(string.format("无法找到挑战任务配置! taskType = %s, subTaskType = %s", arg_10_1, arg_10_2))
	end

	return var_10_1
end

function var_0_0.getConditionCo(arg_11_0, arg_11_1)
	local var_11_0 = lua_challenge_condition and lua_challenge_condition.configDict[arg_11_1]

	if not var_11_0 then
		logError(string.format("战斗条件配置为空 conditionId = %s", arg_11_1))
	end

	return var_11_0
end

function var_0_0.getActivityBadgeCos(arg_12_0, arg_12_1)
	local var_12_0 = lua_challenge_badge.configDict[arg_12_1]

	if not var_12_0 then
		logError(string.format("活动中的神秘刻纹配置为空 activityId = %s", arg_12_1, arg_12_1))
	end

	return var_12_0
end

function var_0_0.getBadgeCo(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:getActivityBadgeCos(arg_13_1)
	local var_13_1 = var_13_0 and var_13_0[arg_13_2]

	if not var_13_1 then
		logError(string.format("神秘刻纹配置为空 activityId = %s, badgeNum = %s", arg_13_1, arg_13_2))
	end

	return var_13_1
end

function var_0_0.getEpisodeConditions(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0:getEpisodeCo(arg_14_1, arg_14_2)

	if var_14_0 then
		return (string.splitToNumber(var_14_0.condition, "#"))
	end
end

function var_0_0.getGroupSubEpisodeConditions(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:getEpisodeCosByGroupId(arg_15_1, arg_15_2)

	if not var_15_0 then
		return
	end

	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		if Act183Helper.getEpisodeType(iter_15_1.episodeId) == Act183Enum.EpisodeType.Sub then
			local var_15_2 = string.splitToNumber(iter_15_1.condition, "#")

			tabletool.addValues(var_15_1, var_15_2)
		end
	end

	return var_15_1
end

function var_0_0._onTaskConfigLoaded(arg_16_0, arg_16_1)
	arg_16_0._taskTab = arg_16_1
	arg_16_0._taskTypeMap = {}
	arg_16_0._taskGroupMap = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1.configList) do
		arg_16_0:_onSingleTaskConfigLoaded(iter_16_1)
	end
end

function var_0_0._onSingleTaskConfigLoaded(arg_17_0, arg_17_1)
	if not (arg_17_1.isOnline == 1) then
		return
	end

	local var_17_0 = arg_17_1.activityId
	local var_17_1 = arg_17_0._taskTypeMap[var_17_0]

	if not var_17_1 then
		var_17_1 = {}
		arg_17_0._taskTypeMap[var_17_0] = var_17_1
	end

	local var_17_2 = arg_17_1.type
	local var_17_3 = var_17_1[var_17_2]

	if not var_17_3 then
		var_17_3 = {}
		var_17_1[var_17_2] = var_17_3
	end

	table.insert(var_17_3, arg_17_1)

	local var_17_4 = arg_17_1.groupId

	arg_17_0._taskGroupMap[var_17_4] = arg_17_0._taskGroupMap[var_17_4] or {}

	table.insert(arg_17_0._taskGroupMap[var_17_4], arg_17_1)
end

function var_0_0.getAllOnlineTypeTasks(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0._taskTypeMap[arg_18_1]

	return var_18_0 and var_18_0[arg_18_2]
end

function var_0_0.getAllOnlineGroupTasks(arg_19_0, arg_19_1)
	return arg_19_0._taskGroupMap and arg_19_0._taskGroupMap[arg_19_1]
end

function var_0_0.getTaskConfig(arg_20_0, arg_20_1)
	local var_20_0 = lua_challenge_task.configDict[arg_20_1]

	if not var_20_0 then
		logError(string.format("任务配置不存在 taskId = %s", arg_20_1))
	end

	return var_20_0
end

function var_0_0.getPreEpisodeIds(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0:getEpisodeCo(arg_21_1, arg_21_2)

	if var_21_0 and string.nilorempty(var_21_0.preEpisodeIds) then
		return (string.splitToNumber(var_21_0.preEpisodeIds, "#"))
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
