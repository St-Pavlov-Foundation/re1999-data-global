module("modules.logic.bossrush.config.BossRushConfig", package.seeall)

local var_0_0 = class("BossRushConfig", Activity128Config)

function var_0_0.InfiniteDoubleMaxTimes(arg_1_0)
	return arg_1_0:getConst(2) or 0
end

function var_0_0.getActivityRewardStr(arg_2_0)
	local var_2_0, var_2_1 = arg_2_0:getConst(3)

	return var_2_1
end

function var_0_0.getIssxIconName(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:getFinalMonsterId(arg_3_1, arg_3_2 or 1)
	local var_3_1 = lua_monster.configDict[var_3_0].career

	return "lssx_" .. var_3_1
end

function var_0_0.getAssessCo(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = "needPointBoss" .. tostring(arg_4_1)
	local var_4_1 = lua_activity128_assess.configList
	local var_4_2 = arg_4_3 and 1 or 0

	for iter_4_0 = #var_4_1, 1, -1 do
		local var_4_3 = var_4_1[iter_4_0]

		if var_4_3.layer4Assess == var_4_2 and arg_4_2 >= var_4_3[var_4_0] then
			return var_4_3
		end
	end
end

function var_0_0.getAssessSpriteName(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0:getAssessCo(arg_5_1, arg_5_2, arg_5_3)

	if var_5_0 then
		return var_5_0.spriteName, var_5_0.level, var_5_0.strLevel
	end

	return "", -1, ""
end

function var_0_0.getAssessBattleIconBgName(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0:getAssessCo(arg_6_1, arg_6_2, arg_6_3)

	if var_6_0 then
		return var_6_0.battleIconBg, var_6_0.level
	end

	return "v1a4_bossrush_ig_tipsbgempty", -1
end

function var_0_0.getAssessMainBossBgName(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0:getAssessCo(arg_7_1, arg_7_2, arg_7_3)

	if var_7_0 then
		return var_7_0.mainBg, var_7_0.level
	end

	return "v1a6_bossrush_taskitembg1", -1
end

function var_0_0.getAssessPointByStrLevel(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = "needPointBoss" .. tostring(arg_8_1)
	local var_8_1 = lua_activity128_assess.configList

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		if iter_8_1.strLevel == arg_8_2 then
			return iter_8_1[var_8_0]
		end
	end

	return 0
end

function var_0_0.getScoreStr(arg_9_0, arg_9_1, arg_9_2)
	assert(arg_9_1 >= 0)

	local var_9_0 = math.modf(arg_9_1 / 10)
	local var_9_1 = math.fmod(arg_9_1, 10)
	local var_9_2 = 1
	local var_9_3 = tostring(var_9_1)

	arg_9_2 = arg_9_2 or ","

	while var_9_0 > 0 do
		local var_9_4 = math.fmod(var_9_0, 10)

		if var_9_2 >= 3 then
			var_9_3 = arg_9_2 .. var_9_3
			var_9_2 = 0
		end

		var_9_3 = tostring(var_9_4) .. var_9_3
		var_9_0 = math.modf(var_9_0 / 10)
		var_9_2 = var_9_2 + 1
	end

	return var_9_3
end

function var_0_0.getBossRushMainItemBossSprite(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getStageCO(arg_10_1).bossRushMainItemBossSprite

	return ResUrl.getV1a4BossRushIcon(var_10_0)
end

function var_0_0.getResultViewFullBgSImage(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getStageCO(arg_11_1).resultViewFullBgSImage

	return ResUrl.getV1a4BossRushSinglebg(var_11_0)
end

function var_0_0.getResultViewNameSImage(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getStageCO(arg_12_1).resultViewNameSImage

	return ResUrl.getV1a4BossRushLangPath(var_12_0)
end

function var_0_0.getBossRushLevelDetailFullBgSimage(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getStageCO(arg_13_1).bossRushLevelDetailFullBgSimage

	return ResUrl.getV1a4BossRushSinglebg(var_13_0)
end

function var_0_0.getMonsterSkinIdList(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getStageCO(arg_14_1).skinIds

	return string.splitToNumber(var_14_0, "#")
end

function var_0_0.getMonsterSkinScaleList(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getStageCO(arg_15_1).skinScales

	return string.splitToNumber(var_15_0, "#")
end

function var_0_0.getMonsterSkinOffsetXYs(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getStageCO(arg_16_1).skinOffsetXYs

	return GameUtil.splitString2(var_16_0, true)
end

function var_0_0.getQualityBgSpriteName(arg_17_0, arg_17_1)
	return "bg_pinjidi_" .. arg_17_1
end

function var_0_0.getQualityFrameSpriteName(arg_18_0, arg_18_1)
	return "bg_pinjidi_lanse_" .. arg_18_1
end

local var_0_1 = {
	[0] = "bg_xingjidian",
	"bg_xingjidian_1",
	"bg_xingjidian_dis",
	"bg_xingjidian_1_dis",
	"bg_xingjidian_layer4"
}

function var_0_0.getRewardStatusSpriteName(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = 0

	if arg_19_1 then
		var_19_0 = var_19_0 + 1
	end

	if not arg_19_2 then
		var_19_0 = var_19_0 + 2
	end

	return var_0_1[var_19_0]
end

function var_0_0.getSpriteRewardStatusSpriteName(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1 and 4 or 2

	return var_0_1[var_20_0]
end

function var_0_0.getStageRewardDisplayIndexesList(arg_21_0, arg_21_1)
	return arg_21_0:__getOrCreateStageRewardDisplayIndexesList(arg_21_1)
end

function var_0_0.__getOrCreateStageRewardDisplayIndexesList(arg_22_0, arg_22_1)
	arg_22_0.__cumulativeDisplayRewards = arg_22_0.__cumulativeDisplayRewards or {}

	if arg_22_0.__cumulativeDisplayRewards[arg_22_1] then
		return arg_22_0.__cumulativeDisplayRewards[arg_22_1]
	end

	local var_22_0 = {}
	local var_22_1 = arg_22_0:getStageRewardList(arg_22_1)

	for iter_22_0, iter_22_1 in ipairs(var_22_1) do
		if iter_22_1.display > 0 then
			var_22_0[#var_22_0 + 1] = iter_22_0
		end
	end

	arg_22_0.__cumulativeDisplayRewards[arg_22_1] = var_22_0

	return var_22_0
end

function var_0_0.calcStageRewardProgWidthByListScrollParam(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5, arg_23_6)
	local var_23_0 = arg_23_3.cellWidth
	local var_23_1 = arg_23_3.cellSpaceH
	local var_23_2 = var_23_0 + var_23_1

	arg_23_6 = arg_23_6 or arg_23_3.endSpace or 0

	return arg_23_0:calcStageRewardProgWidth(arg_23_1, arg_23_2, var_23_1, var_23_0, arg_23_4, var_23_2, arg_23_5, arg_23_6)
end

function var_0_0.calcStageRewardProgWidth(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5, arg_24_6, arg_24_7, arg_24_8)
	local var_24_0 = arg_24_0:getStageRewardList(arg_24_1)
	local var_24_1 = #var_24_0

	if var_24_1 == 0 then
		return 0, 0
	end

	arg_24_7 = arg_24_7 or 0
	arg_24_8 = arg_24_8 or 0
	arg_24_5 = arg_24_5 or arg_24_4 / 2
	arg_24_6 = arg_24_6 or arg_24_4 + arg_24_3

	local var_24_2 = arg_24_5 + (var_24_1 - 1) * arg_24_6 + arg_24_8
	local var_24_3 = 0
	local var_24_4 = 0

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		local var_24_5 = iter_24_1.rewardPointNum
		local var_24_6 = iter_24_0 == 1 and arg_24_5 or arg_24_6

		if var_24_5 <= arg_24_2 then
			var_24_3 = var_24_3 + var_24_6
			var_24_4 = var_24_5
		else
			var_24_3 = var_24_3 + GameUtil.remap(arg_24_2, var_24_4, var_24_5, 0, var_24_6)

			break
		end
	end

	return math.max(0, var_24_3 - arg_24_7), var_24_2
end

function var_0_0.getBgmViewNames(arg_25_0)
	if not arg_25_0._bgmViews then
		arg_25_0._bgmViews = {
			ViewName.V1a4_BossRushMainView,
			ViewName.V1a4_BossRushLevelDetail,
			ViewName.V1a4_BossRush_ScoreTaskAchievement,
			ViewName.V1a4_BossRush_ScheduleView
		}
	end

	return arg_25_0._bgmViews
end

function var_0_0.getMonsterResPathList(arg_26_0, arg_26_1)
	local var_26_0 = {}
	local var_26_1 = var_0_0.instance:getMonsterSkinIdList(arg_26_1)

	for iter_26_0, iter_26_1 in ipairs(var_26_1) do
		local var_26_2 = FightConfig.instance:getSkinCO(iter_26_1)

		if var_26_2 then
			local var_26_3 = ResUrl.getSpineUIPrefab(var_26_2.spine)

			table.insert(var_26_0, var_26_3)
		end
	end

	return var_26_0
end

function var_0_0.initEvaluateCo(arg_27_0)
	return
end

function var_0_0.getEvaluateInfo(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0:getEvaluateConfig(arg_28_1)

	return var_28_0.name, var_28_0.desc
end

function var_0_0.getActRoleEnhanceCoById(arg_29_0, arg_29_1)
	return arg_29_0:getActRoleEnhance()[arg_29_1]
end

function var_0_0.getEpisodeCoByEpisodeId(arg_30_0, arg_30_1)
	local var_30_0 = lua_activity128_episode.configDict[arg_30_0.__activityId]

	if var_30_0 then
		for iter_30_0, iter_30_1 in pairs(var_30_0) do
			for iter_30_2, iter_30_3 in pairs(iter_30_1) do
				if iter_30_3.episodeId == arg_30_1 then
					return iter_30_3
				end
			end
		end
	end
end

var_0_0.instance = var_0_0.New(VersionActivity2_6Enum.ActivityId.BossRush)

return var_0_0
