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

function var_0_0.isGroupExist(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:getEpisodeCosByGroupId(arg_6_1, arg_6_2)

	return var_6_0 and #var_6_0 > 0
end

function var_0_0.getEpisodeAllRuleDesc(arg_7_0, arg_7_1)
	local var_7_0 = {}
	local var_7_1 = arg_7_0:getEpisodeRuleDesc(arg_7_1, 1)
	local var_7_2 = arg_7_0:getEpisodeRuleDesc(arg_7_1, 2)

	if not string.nilorempty(var_7_1) then
		table.insert(var_7_0, var_7_1)
	end

	if not string.nilorempty(var_7_2) then
		table.insert(var_7_0, var_7_2)
	end

	return var_7_0
end

function var_0_0.getEpisodeRuleDesc(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:getEpisodeCo(arg_8_1)

	if not var_8_0 then
		return
	end

	if arg_8_2 == 1 then
		return var_8_0.ruleDesc1
	elseif arg_8_2 == 2 then
		return var_8_0.ruleDesc2
	else
		logError(string.format("关卡机制序号不存在 episodeId = %s, ruleIndex = %s", arg_8_1, arg_8_2))
	end
end

function var_0_0._onRewardConfigsLoad(arg_9_0, arg_9_1)
	arg_9_0._taskTab = arg_9_1
	arg_9_0._taskChapterTab = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1.configList) do
		local var_9_0 = arg_9_0._taskChapterTab[iter_9_1.type1]

		if not var_9_0 then
			var_9_0 = {}
			arg_9_0._taskChapterTab[iter_9_1.type1] = var_9_0
		end

		local var_9_1 = var_9_0[iter_9_1.type2]

		if not var_9_1 then
			var_9_1 = {}
			var_9_0[iter_9_1.type2] = var_9_1
		end

		table.insert(var_9_1, iter_9_1)
	end
end

function var_0_0.getAllTaskByType(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._taskChapterTab[arg_10_1]

	if not var_10_0 then
		logError(string.format("无法找到挑战任务配置! taskType = %s", arg_10_1))
	end

	return var_10_0
end

function var_0_0.getChapterTasks(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:getAllTaskByType(arg_11_1)
	local var_11_1 = var_11_0 and var_11_0[arg_11_2]

	if not var_11_1 then
		logError(string.format("无法找到挑战任务配置! taskType = %s, subTaskType = %s", arg_11_1, arg_11_2))
	end

	return var_11_1
end

function var_0_0.getConditionCo(arg_12_0, arg_12_1)
	local var_12_0 = lua_challenge_condition and lua_challenge_condition.configDict[arg_12_1]

	if not var_12_0 then
		logError(string.format("战斗条件配置为空 conditionId = %s", arg_12_1))
	end

	return var_12_0
end

function var_0_0.getActivityBadgeCos(arg_13_0, arg_13_1)
	local var_13_0 = lua_challenge_badge.configDict[arg_13_1]

	if not var_13_0 then
		logError(string.format("活动中的神秘刻纹配置为空 activityId = %s", arg_13_1, arg_13_1))
	end

	return var_13_0
end

function var_0_0.getBadgeCo(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0:getActivityBadgeCos(arg_14_1)
	local var_14_1 = var_14_0 and var_14_0[arg_14_2]

	if not var_14_1 then
		logError(string.format("神秘刻纹配置为空 activityId = %s, badgeNum = %s", arg_14_1, arg_14_2))
	end

	return var_14_1
end

function var_0_0.getEpisodeConditions(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:getEpisodeCo(arg_15_1, arg_15_2)

	if var_15_0 then
		return (string.splitToNumber(var_15_0.condition, "#"))
	end
end

function var_0_0.getGroupSubEpisodeConditions(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:getEpisodeCosByGroupId(arg_16_1, arg_16_2)

	if not var_16_0 then
		return
	end

	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if Act183Helper.getEpisodeType(iter_16_1.episodeId) == Act183Enum.EpisodeType.Sub then
			local var_16_2 = string.splitToNumber(iter_16_1.condition, "#")

			tabletool.addValues(var_16_1, var_16_2)
		end
	end

	return var_16_1
end

function var_0_0._onTaskConfigLoaded(arg_17_0, arg_17_1)
	arg_17_0._taskTab = arg_17_1
	arg_17_0._taskTypeMap = {}
	arg_17_0._taskGroupMap = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1.configList) do
		arg_17_0:_onSingleTaskConfigLoaded(iter_17_1)
	end
end

function var_0_0._onSingleTaskConfigLoaded(arg_18_0, arg_18_1)
	if not (arg_18_1.isOnline == 1) then
		return
	end

	local var_18_0 = arg_18_1.activityId
	local var_18_1 = arg_18_0._taskTypeMap[var_18_0]

	if not var_18_1 then
		var_18_1 = {}
		arg_18_0._taskTypeMap[var_18_0] = var_18_1
	end

	local var_18_2 = arg_18_1.type
	local var_18_3 = var_18_1[var_18_2]

	if not var_18_3 then
		var_18_3 = {}
		var_18_1[var_18_2] = var_18_3
	end

	table.insert(var_18_3, arg_18_1)

	local var_18_4 = arg_18_1.activityId

	arg_18_0._taskGroupMap[var_18_4] = arg_18_0._taskGroupMap[var_18_4] or {}

	local var_18_5 = arg_18_1.groupId

	arg_18_0._taskGroupMap[var_18_4][var_18_5] = arg_18_0._taskGroupMap[var_18_4][var_18_5] or {}

	table.insert(arg_18_0._taskGroupMap[var_18_4][var_18_5], arg_18_1)
end

function var_0_0.getAllOnlineTypeTasks(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0._taskTypeMap[arg_19_1]

	return var_19_0 and var_19_0[arg_19_2]
end

function var_0_0.getAllOnlineGroupTasks(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0._taskGroupMap and arg_20_0._taskGroupMap[arg_20_1]

	return var_20_0 and var_20_0[arg_20_2]
end

function var_0_0.getTaskConfig(arg_21_0, arg_21_1)
	local var_21_0 = lua_challenge_task.configDict[arg_21_1]

	if not var_21_0 then
		logError(string.format("任务配置不存在 taskId = %s", arg_21_1))
	end

	return var_21_0
end

function var_0_0.getPreEpisodeIds(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0:getEpisodeCo(arg_22_1, arg_22_2)

	if var_22_0 and string.nilorempty(var_22_0.preEpisodeIds) then
		return (string.splitToNumber(var_22_0.preEpisodeIds, "#"))
	end
end

function var_0_0.getLeaderSkillDesc(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getEpisodeCo(arg_23_1)

	return var_23_0 and var_23_0.skillDesc
end

function var_0_0.getEpisodeLeaderPosition(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:getEpisodeCo(arg_24_1)

	return var_24_0 and var_24_0.leaderPosition or 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
