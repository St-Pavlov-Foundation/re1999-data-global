module("modules.logic.versionactivity1_4.act128.config.Activity128Config", package.seeall)

local var_0_0 = class("Activity128Config", BaseConfig)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.__activityId = arg_1_1
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity128_stage",
		"activity128_episode",
		"activity128_rewards",
		"activity128_task",
		"activity128_countboss",
		"activity128_const",
		"activity128_assess",
		"activity128_evaluate",
		"activity128_enhance",
		"monster_group",
		"monster",
		"monster_template",
		"battle",
		"episode",
		"skin"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity128_stage" then
		-- block empty
	elseif arg_3_1 == "activity128_episode" then
		-- block empty
	elseif arg_3_1 == "activity128_rewards" then
		arg_3_0:__getOrCreateStageRewardList()
	elseif arg_3_1 == "activity128_task" then
		arg_3_0:__getOrCreateTaskList()
		arg_3_0:_initActLayer4rewards()
	elseif arg_3_1 == "activity128_countboss" then
		-- block empty
	elseif arg_3_1 == "activity128_const" then
		-- block empty
	elseif arg_3_1 == "activity128_evaluate" then
		-- block empty
	elseif arg_3_1 == "activity128_enhance" then
		-- block empty
	end
end

local function var_0_1(arg_4_0)
	return lua_scene_level.configDict[arg_4_0]
end

local function var_0_2(arg_5_0)
	return var_0_1(arg_5_0).resName
end

local function var_0_3(arg_6_0)
	return lua_battle.configDict[arg_6_0]
end

local function var_0_4(arg_7_0)
	return var_0_3(arg_7_0).monsterGroupIds
end

local function var_0_5(arg_8_0)
	return lua_monster_group.configDict[arg_8_0]
end

local function var_0_6(arg_9_0)
	return lua_monster.configDict[arg_9_0]
end

local function var_0_7(arg_10_0)
	return lua_episode.configDict[arg_10_0]
end

local function var_0_8(arg_11_0)
	return lua_monster_template.configDict[arg_11_0]
end

local function var_0_9(arg_12_0)
	return var_0_8(arg_12_0.template)
end

local function var_0_10(arg_13_0)
	local var_13_0 = var_0_6(arg_13_0)

	return var_0_9(var_13_0)
end

local function var_0_11(arg_14_0)
	return lua_activity128_stage.configDict[arg_14_0]
end

local function var_0_12(arg_15_0, arg_15_1)
	return lua_activity128_stage.configDict[arg_15_0][arg_15_1]
end

local function var_0_13(arg_16_0, arg_16_1)
	return lua_activity128_episode.configDict[arg_16_0][arg_16_1]
end

local function var_0_14(arg_17_0, arg_17_1, arg_17_2)
	return lua_activity128_episode.configDict[arg_17_0][arg_17_1][arg_17_2]
end

local function var_0_15(arg_18_0, arg_18_1, arg_18_2)
	return lua_activity128_episode.configDict[arg_18_0][arg_18_1][arg_18_2]
end

local function var_0_16(arg_19_0)
	return lua_activity128_countboss.configDict[arg_19_0]
end

local function var_0_17(arg_20_0)
	return lua_activity128_evaluate.configDict[arg_20_0]
end

function var_0_0.__getOrCreateStageRewardList(arg_21_0)
	local var_21_0 = arg_21_0.__activityId

	if arg_21_0.__cumulativeRewards then
		return arg_21_0.__cumulativeRewards
	end

	local var_21_1 = {}

	arg_21_0.__cumulativeRewards = var_21_1

	if lua_activity128_rewards.configDict[var_21_0] then
		for iter_21_0, iter_21_1 in pairs(lua_activity128_rewards.configDict[var_21_0]) do
			local var_21_2 = iter_21_1.stage

			if not var_21_1[var_21_2] then
				var_21_1[var_21_2] = {}
			end

			table.insert(var_21_1[var_21_2], iter_21_1)
		end
	end

	for iter_21_2, iter_21_3 in pairs(var_21_1) do
		table.sort(iter_21_3, function(arg_22_0, arg_22_1)
			if arg_22_0.rewardPointNum ~= arg_22_1.rewardPointNum then
				return arg_22_0.rewardPointNum < arg_22_1.rewardPointNum
			end

			return arg_22_0.id < arg_22_1.id
		end)
	end

	return var_21_1
end

function var_0_0.__getOrCreateTaskList(arg_23_0)
	local var_23_0 = arg_23_0.__activityId

	if arg_23_0.__taskList then
		return arg_23_0.__taskList
	end

	local var_23_1 = {}

	arg_23_0.__taskList = var_23_1

	for iter_23_0, iter_23_1 in ipairs(lua_activity128_task.configList) do
		if iter_23_1.isOnline and var_23_0 == iter_23_1.activityId and iter_23_1.totalTaskType == 0 then
			var_23_1[#var_23_1 + 1] = iter_23_1
		end
	end

	return var_23_1
end

function var_0_0.getStageRewardList(arg_24_0, arg_24_1)
	arg_24_0:__getOrCreateStageRewardList()

	return arg_24_0.__cumulativeRewards[arg_24_1]
end

function var_0_0.getAllTaskList(arg_25_0)
	return arg_25_0:__getOrCreateTaskList()
end

function var_0_0.getTaskCO(arg_26_0, arg_26_1)
	return lua_activity128_task.configDict[arg_26_1]
end

function var_0_0.getStages(arg_27_0)
	return var_0_11(arg_27_0.__activityId)
end

function var_0_0.getStageCO(arg_28_0, arg_28_1)
	return var_0_12(arg_28_0.__activityId, arg_28_1)
end

function var_0_0.getStageCOMaxPoints(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:getStageRewardList(arg_29_1)

	return var_29_0[#var_29_0].rewardPointNum
end

function var_0_0.getEpisodeStages(arg_30_0, arg_30_1)
	return var_0_13(arg_30_0.__activityId, arg_30_1)
end

function var_0_0.getEpisodeCO(arg_31_0, arg_31_1, arg_31_2)
	return var_0_14(arg_31_0.__activityId, arg_31_1, arg_31_2)
end

function var_0_0.getDungeonEpisodeId(arg_32_0, arg_32_1, arg_32_2)
	return arg_32_0:getEpisodeCO(arg_32_1, arg_32_2).episodeId
end

function var_0_0.getDungeonEpisodeCO(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0:getDungeonEpisodeId(arg_33_1, arg_33_2)

	return var_0_7(var_33_0)
end

function var_0_0.getDungeonBattleId(arg_34_0, arg_34_1, arg_34_2)
	return arg_34_0:getDungeonEpisodeCO(arg_34_1, arg_34_2).battleId
end

function var_0_0.getDungeonBattleCO(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_0:getDungeonBattleId(arg_35_1, arg_35_2)

	return var_0_3(var_35_0)
end

function var_0_0.getDungeonBattleScenceIds(arg_36_0, arg_36_1, arg_36_2)
	return arg_36_0:getDungeonBattleCO(arg_36_1, arg_36_2).sceneIds
end

function var_0_0.getAchievementTaskCO(arg_37_0, arg_37_1, arg_37_2)
	return var_0_15(arg_37_0.__activityId, arg_37_1, arg_37_2)
end

function var_0_0.isInfinite(arg_38_0, arg_38_1, arg_38_2)
	return arg_38_0:getEpisodeCO(arg_38_1, arg_38_2).type == 1
end

function var_0_0.getStageCOOpenDay(arg_39_0, arg_39_1)
	return arg_39_0:getStageCO(arg_39_1).openDay
end

function var_0_0.getEpisodeCOOpenDay(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0:getEpisodeStages(arg_40_1)

	if var_40_0 then
		local var_40_1, var_40_2 = next(var_40_0)

		if var_40_1 then
			return var_40_2.openDay
		end
	end
end

function var_0_0.getBattleCOByASL(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_0:getDungeonBattleId(arg_41_1, arg_41_2)

	return var_0_3(var_41_0)
end

function var_0_0.getMonsterGroupBossId(arg_42_0, arg_42_1)
	return var_0_5(arg_42_1).bossId
end

function var_0_0.getBattleMaxPoints(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0:getDungeonBattleId(arg_43_1, arg_43_2)

	return var_0_16(var_43_0).maxPoints
end

function var_0_0.getFinalMonsterId(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = arg_44_0:getDungeonBattleId(arg_44_1, arg_44_2)

	return tonumber(var_0_16(var_44_0).finalMonsterId)
end

function var_0_0.getDungeonBattleSceneResName(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = arg_45_0:getDungeonBattleId(arg_45_1, arg_45_2)
	local var_45_1 = var_0_3(var_45_0)
	local var_45_2 = string.splitToNumber(var_45_1.sceneIds, "#")[1]

	return var_0_2(var_45_2)
end

function var_0_0.getDungeonBattleMonsterSkinCOs(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = arg_46_0:getDungeonBattleId(arg_46_1, arg_46_2)
	local var_46_1 = var_0_4(var_46_0)
	local var_46_2 = string.splitToNumber(var_46_1, "#")[1]
	local var_46_3 = var_0_5(var_46_2).monster
	local var_46_4 = string.splitToNumber(var_46_3, "#")
	local var_46_5 = {}

	for iter_46_0, iter_46_1 in ipairs(var_46_4) do
		local var_46_6 = var_0_6(iter_46_1).skinId

		var_46_5[#var_46_5 + 1] = FightConfig.instance:getSkinCO(var_46_6)
	end

	return var_46_5
end

function var_0_0.getConst(arg_47_0, arg_47_1)
	local var_47_0 = lua_activity128_const.configDict[arg_47_1]

	return var_47_0.value1, var_47_0.value2
end

function var_0_0.tryGetStageAndLayerByEpisodeId(arg_48_0, arg_48_1)
	for iter_48_0, iter_48_1 in ipairs(lua_activity128_episode.configList) do
		if iter_48_1.episodeId == arg_48_1 then
			return iter_48_1.stage, iter_48_1.layer
		end
	end
end

function var_0_0.tryGetStageNextLayer(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = arg_49_0:getEpisodeStages(arg_49_1)

	for iter_49_0, iter_49_1 in ipairs(var_49_0) do
		local var_49_1 = iter_49_1.layer

		if arg_49_2 + 1 == var_49_1 then
			return var_49_1
		end
	end
end

function var_0_0.getEvaluateConfig(arg_50_0, arg_50_1)
	return (var_0_17(arg_50_1))
end

local var_0_18 = {
	GEqual_1Day = 1,
	GEqual_1Hour = 2,
	GEqual_1Second = 4,
	GEqual_1Min = 3
}
local var_0_19 = {
	[var_0_18.GEqual_1Day] = "v1a4_bossrushleveldetail_remain_days_hours",
	[var_0_18.GEqual_1Hour] = "v1a4_bossrushleveldetail_remain_hours",
	[var_0_18.GEqual_1Min] = "v1a4_bossrushleveldetail_remain_mins",
	[var_0_18.GEqual_1Second] = "v1a4_bossrushleveldetail_remain_1min"
}
local var_0_20 = {
	[var_0_18.GEqual_1Day] = "v1a4_bossrushleveldetail_unlock_days_hours",
	[var_0_18.GEqual_1Hour] = "v1a4_bossrushleveldetail_unlock_hours",
	[var_0_18.GEqual_1Min] = "v1a4_bossrushleveldetail_unlock_mins",
	[var_0_18.GEqual_1Second] = "v1a4_bossrushleveldetail_unlock_1min"
}

var_0_0.ETimeFmtStyle = {
	Default = var_0_19,
	UnLock = var_0_20
}

function var_0_0.getRemainTimeStrWithFmt(arg_51_0, arg_51_1, arg_51_2)
	arg_51_2 = arg_51_2 or var_0_0.ETimeFmtStyle.Default

	local var_51_0, var_51_1, var_51_2, var_51_3 = TimeUtil.secondsToDDHHMMSS(arg_51_1)

	if var_51_0 >= 1 then
		local var_51_4 = {
			var_51_0,
			var_51_1
		}

		return GameUtil.getSubPlaceholderLuaLang(luaLang(arg_51_2[var_0_18.GEqual_1Day]), var_51_4)
	end

	if var_51_1 >= 1 then
		return formatLuaLang(arg_51_2[var_0_18.GEqual_1Hour], var_51_1)
	end

	if var_51_2 >= 1 then
		return formatLuaLang(arg_51_2[var_0_18.GEqual_1Min], var_51_2)
	end

	return luaLang(arg_51_2[var_0_18.GEqual_1Second])
end

function var_0_0.getRemainTimeStr(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = arg_52_1 - ServerTime.now()

	return arg_52_0:getRemainTimeStrWithFmt(var_52_0, arg_52_2)
end

function var_0_0.checkActivityId(arg_53_0, arg_53_1)
	return arg_53_0.__activityId == arg_53_1
end

function var_0_0.getActivityId(arg_54_0)
	return arg_54_0.__activityId
end

function var_0_0.getActRoleEnhance(arg_55_0)
	return lua_activity128_enhance.configDict[arg_55_0.__activityId]
end

function var_0_0._initActLayer4rewards(arg_56_0)
	arg_56_0.layer4Rewards = {}

	for iter_56_0, iter_56_1 in ipairs(lua_activity128_task.configList) do
		if iter_56_1.totalTaskType == 1 then
			local var_56_0 = arg_56_0.layer4Rewards[iter_56_1.activityId]

			if not var_56_0 then
				var_56_0 = {}
				arg_56_0.layer4Rewards[iter_56_1.activityId] = var_56_0
			end

			local var_56_1 = var_56_0[iter_56_1.stage]

			if not var_56_1 then
				var_56_1 = {}
				var_56_0[iter_56_1.stage] = var_56_1
			end

			table.insert(var_56_1, iter_56_1)
		end
	end
end

function var_0_0.getActLayer4rewards(arg_57_0, arg_57_1)
	if arg_57_0.layer4Rewards[arg_57_0.__activityId] then
		return arg_57_0.layer4Rewards[arg_57_0.__activityId][arg_57_1]
	end

	return {}
end

return var_0_0
