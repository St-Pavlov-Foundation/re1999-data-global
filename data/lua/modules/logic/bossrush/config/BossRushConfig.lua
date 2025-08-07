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
	arg_3_2 = arg_3_0:getDefaultLayer(arg_3_1) or 1

	local var_3_0 = arg_3_0:getFinalMonsterId(arg_3_1, arg_3_2)
	local var_3_1 = lua_monster.configDict[var_3_0].career

	return "lssx_" .. var_3_1
end

function var_0_0.getDefaultLayer(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getEpisodeStages(arg_4_1)

	if var_4_0 then
		for iter_4_0, iter_4_1 in pairs(var_4_0) do
			return iter_4_1.layer
		end
	end
end

function var_0_0.getAssessCo(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = "needPointBoss" .. tostring(arg_5_1)
	local var_5_1 = lua_activity128_assess.configList
	local var_5_2 = arg_5_3 and 1 or 0

	for iter_5_0 = #var_5_1, 1, -1 do
		local var_5_3 = var_5_1[iter_5_0]

		if var_5_3.layer4Assess == var_5_2 and arg_5_2 >= var_5_3[var_5_0] then
			return var_5_3
		end
	end
end

function var_0_0.getAssessSpriteName(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0:getAssessCo(arg_6_1, arg_6_2, arg_6_3)

	if var_6_0 then
		return var_6_0.spriteName, var_6_0.level, var_6_0.strLevel
	end

	return "", -1, ""
end

function var_0_0.getAssessBattleIconBgName(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0:getAssessCo(arg_7_1, arg_7_2, arg_7_3)

	if var_7_0 then
		return var_7_0.battleIconBg, var_7_0.level
	end

	return "v1a4_bossrush_ig_tipsbgempty", -1
end

function var_0_0.getAssessMainBossBgName(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_0:getAssessCo(arg_8_1, arg_8_2, arg_8_3)

	if var_8_0 then
		return var_8_0.mainBg, var_8_0.level
	end

	return "v1a6_bossrush_taskitembg1", -1
end

function var_0_0.getAssessPointByStrLevel(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = "needPointBoss" .. tostring(arg_9_1)
	local var_9_1 = lua_activity128_assess.configList

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		if iter_9_1.strLevel == arg_9_2 then
			return iter_9_1[var_9_0]
		end
	end

	return 0
end

function var_0_0.getScoreStr(arg_10_0, arg_10_1, arg_10_2)
	assert(arg_10_1 >= 0)

	local var_10_0 = math.modf(arg_10_1 / 10)
	local var_10_1 = math.fmod(arg_10_1, 10)
	local var_10_2 = 1
	local var_10_3 = tostring(var_10_1)

	arg_10_2 = arg_10_2 or ","

	while var_10_0 > 0 do
		local var_10_4 = math.fmod(var_10_0, 10)

		if var_10_2 >= 3 then
			var_10_3 = arg_10_2 .. var_10_3
			var_10_2 = 0
		end

		var_10_3 = tostring(var_10_4) .. var_10_3
		var_10_0 = math.modf(var_10_0 / 10)
		var_10_2 = var_10_2 + 1
	end

	return var_10_3
end

function var_0_0.getBossRushMainItemBossSprite(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getStageCO(arg_11_1).bossRushMainItemBossSprite

	return ResUrl.getV1a4BossRushIcon(var_11_0)
end

function var_0_0.getResultViewFullBgSImage(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getStageCO(arg_12_1).resultViewFullBgSImage

	return ResUrl.getV1a4BossRushSinglebg(var_12_0)
end

function var_0_0.getResultViewNameSImage(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getStageCO(arg_13_1).resultViewNameSImage

	return ResUrl.getV1a4BossRushLangPath(var_13_0)
end

function var_0_0.getBossRushLevelDetailFullBgSimage(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getStageCO(arg_14_1).bossRushLevelDetailFullBgSimage

	return ResUrl.getV1a4BossRushSinglebg(var_14_0)
end

function var_0_0.getMonsterSkinIdList(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getStageCO(arg_15_1).skinIds

	return string.splitToNumber(var_15_0, "#")
end

function var_0_0.getMonsterSkinScaleList(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getStageCO(arg_16_1).skinScales

	return string.splitToNumber(var_16_0, "#")
end

function var_0_0.getMonsterSkinOffsetXYs(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getStageCO(arg_17_1).skinOffsetXYs

	return GameUtil.splitString2(var_17_0, true)
end

function var_0_0.getQualityBgSpriteName(arg_18_0, arg_18_1)
	return "bg_pinjidi_" .. arg_18_1
end

function var_0_0.getQualityFrameSpriteName(arg_19_0, arg_19_1)
	return "bg_pinjidi_lanse_" .. arg_19_1
end

local var_0_1 = {
	[0] = "bg_xingjidian",
	"bg_xingjidian_1",
	"bg_xingjidian_dis",
	"bg_xingjidian_1_dis",
	"bg_xingjidian_layer4"
}

function var_0_0.getRewardStatusSpriteName(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = 0

	if arg_20_1 then
		var_20_0 = var_20_0 + 1
	end

	if not arg_20_2 then
		var_20_0 = var_20_0 + 2
	end

	return var_0_1[var_20_0]
end

function var_0_0.getSpriteRewardStatusSpriteName(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1 and 4 or 2

	return var_0_1[var_21_0]
end

function var_0_0.getStageRewardDisplayIndexesList(arg_22_0, arg_22_1)
	return arg_22_0:__getOrCreateStageRewardDisplayIndexesList(arg_22_1)
end

function var_0_0.__getOrCreateStageRewardDisplayIndexesList(arg_23_0, arg_23_1)
	arg_23_0.__cumulativeDisplayRewards = arg_23_0.__cumulativeDisplayRewards or {}

	if arg_23_0.__cumulativeDisplayRewards[arg_23_1] then
		return arg_23_0.__cumulativeDisplayRewards[arg_23_1]
	end

	local var_23_0 = {}
	local var_23_1 = arg_23_0:getStageRewardList(arg_23_1)

	for iter_23_0, iter_23_1 in ipairs(var_23_1) do
		if iter_23_1.display > 0 then
			var_23_0[#var_23_0 + 1] = iter_23_0
		end
	end

	arg_23_0.__cumulativeDisplayRewards[arg_23_1] = var_23_0

	return var_23_0
end

function var_0_0.calcStageRewardProgWidthByListScrollParam(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5, arg_24_6)
	local var_24_0 = arg_24_3.cellWidth
	local var_24_1 = arg_24_3.cellSpaceH
	local var_24_2 = var_24_0 + var_24_1

	arg_24_6 = arg_24_6 or arg_24_3.endSpace or 0

	return arg_24_0:calcStageRewardProgWidth(arg_24_1, arg_24_2, var_24_1, var_24_0, arg_24_4, var_24_2, arg_24_5, arg_24_6)
end

function var_0_0.calcStageRewardProgWidth(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5, arg_25_6, arg_25_7, arg_25_8)
	local var_25_0 = arg_25_0:getStageRewardList(arg_25_1)
	local var_25_1 = #var_25_0

	if var_25_1 == 0 then
		return 0, 0
	end

	arg_25_7 = arg_25_7 or 0
	arg_25_8 = arg_25_8 or 0
	arg_25_5 = arg_25_5 or arg_25_4 / 2
	arg_25_6 = arg_25_6 or arg_25_4 + arg_25_3

	local var_25_2 = arg_25_5 + (var_25_1 - 1) * arg_25_6 + arg_25_8
	local var_25_3 = 0
	local var_25_4 = 0

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		local var_25_5 = iter_25_1.rewardPointNum
		local var_25_6 = iter_25_0 == 1 and arg_25_5 or arg_25_6

		if var_25_5 <= arg_25_2 then
			var_25_3 = var_25_3 + var_25_6
			var_25_4 = var_25_5
		else
			var_25_3 = var_25_3 + GameUtil.remap(arg_25_2, var_25_4, var_25_5, 0, var_25_6)

			break
		end
	end

	return math.max(0, var_25_3 - arg_25_7), var_25_2
end

function var_0_0.getBgmViewNames(arg_26_0)
	if not arg_26_0._bgmViews then
		arg_26_0._bgmViews = {
			ViewName.V1a4_BossRushMainView,
			ViewName.V1a4_BossRushLevelDetail,
			ViewName.V1a4_BossRush_ScoreTaskAchievement,
			ViewName.V1a4_BossRush_ScheduleView
		}
	end

	return arg_26_0._bgmViews
end

function var_0_0.getMonsterResPathList(arg_27_0, arg_27_1)
	local var_27_0 = {}
	local var_27_1 = var_0_0.instance:getMonsterSkinIdList(arg_27_1)

	for iter_27_0, iter_27_1 in ipairs(var_27_1) do
		local var_27_2 = FightConfig.instance:getSkinCO(iter_27_1)

		if var_27_2 then
			local var_27_3 = ResUrl.getSpineUIPrefab(var_27_2.spine)

			table.insert(var_27_0, var_27_3)
		end
	end

	return var_27_0
end

function var_0_0.initEvaluateCo(arg_28_0)
	return
end

function var_0_0.getEvaluateInfo(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:getEvaluateConfig(arg_29_1)

	return var_29_0.name, var_29_0.desc
end

function var_0_0.getActRoleEnhanceCoById(arg_30_0, arg_30_1)
	return arg_30_0:getActRoleEnhance()[arg_30_1]
end

function var_0_0.getEpisodeCoByEpisodeId(arg_31_0, arg_31_1)
	local var_31_0 = lua_activity128_episode.configDict[arg_31_0.__activityId]

	if var_31_0 then
		for iter_31_0, iter_31_1 in pairs(var_31_0) do
			for iter_31_2, iter_31_3 in pairs(iter_31_1) do
				if iter_31_3.episodeId == arg_31_1 then
					return iter_31_3
				end
			end
		end
	end
end

function var_0_0.getAssassinStyleZongmaoCo(arg_32_0, arg_32_1)
	return lua_assassin_style_zongmao.configDict[arg_32_1]
end

var_0_0.instance = var_0_0.New(VersionActivity2_9Enum.ActivityId.BossRush)

return var_0_0
