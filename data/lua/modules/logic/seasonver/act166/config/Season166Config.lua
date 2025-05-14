local var_0_0 = class("Season166Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity166_const_global",
		"activity166_const",
		"activity166_score",
		"activity166_base",
		"activity166_base_level",
		"activity166_base_target",
		"activity166_train",
		"activity166_teach",
		"activity166_info_analy",
		"activity166_info_bonus",
		"activity166_info",
		"activity166_talent",
		"activity166_talent_style",
		"activity166_word_effect",
		"activity166_word_effect_pos"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity166_const" then
		arg_3_0._constConfig = arg_3_2
	elseif arg_3_1 == "activity166_const_global" then
		arg_3_0._constGlobalConfig = arg_3_2
	elseif arg_3_1 == "activity166_score" then
		arg_3_0._scoreConfig = arg_3_2
	elseif arg_3_1 == "activity166_base" then
		arg_3_0._baseSpotConfig = arg_3_2
		arg_3_0._actId2BaseSpotCoList = {}
	elseif arg_3_1 == "activity166_base_level" then
		arg_3_0._baseSpotLevelConfig = arg_3_2
		arg_3_0._baseLevelCoList = {}
	elseif arg_3_1 == "activity166_base_target" then
		arg_3_0._baseTargetConfig = arg_3_2
		arg_3_0._baseTargetCoList = {}
	elseif arg_3_1 == "activity166_train" then
		arg_3_0._trainConfig = arg_3_2
		arg_3_0._trainCoList = {}
	elseif arg_3_1 == "activity166_teach" then
		arg_3_0._teachConfig = arg_3_2
	elseif arg_3_1 == "activity166_info_analy" then
		arg_3_0._infoAnalyConfig = arg_3_2
	elseif arg_3_1 == "activity166_info_bonus" then
		arg_3_0._infoBonusConfig = arg_3_2
	elseif arg_3_1 == "activity166_info" then
		arg_3_0._infoConfig = arg_3_2
	elseif arg_3_1 == "activity166_word_effect" then
		arg_3_0._wordEffectConfig = arg_3_2

		arg_3_0:buildSeasonWordEffectConfig()
	elseif arg_3_1 == "activity166_word_effect_pos" then
		arg_3_0._wordEffectPosConfig = arg_3_2
	end

	arg_3_0._episodeId2Config = {}
end

function var_0_0.getSeasonConstGlobalCo(arg_4_0, arg_4_1)
	return arg_4_0._constGlobalConfig.configDict[arg_4_1]
end

function var_0_0.getSeasonConstCo(arg_5_0, arg_5_1)
	return arg_5_0._constConfig.configDict[arg_5_1]
end

function var_0_0.getSeasonConstNum(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0._constConfig.configDict[arg_6_1] or not arg_6_0._constConfig.configDict[arg_6_1][arg_6_2] then
		return nil
	end

	return arg_6_0._constConfig.configDict[arg_6_1][arg_6_2].value1
end

function var_0_0.getSeasonConstStr(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0._constConfig.configDict[arg_7_1] or not arg_7_0._constConfig.configDict[arg_7_1][arg_7_2] then
		return nil
	end

	return arg_7_0._constConfig.configDict[arg_7_1][arg_7_2].value2
end

function var_0_0.getSeasonBaseSpotCos(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._actId2BaseSpotCoList[arg_8_1]

	if not var_8_0 then
		var_8_0 = {}
		arg_8_0._actId2BaseSpotCoList[arg_8_1] = var_8_0

		local var_8_1 = arg_8_0._baseSpotConfig.configDict[arg_8_1]

		if var_8_1 then
			for iter_8_0, iter_8_1 in pairs(var_8_1) do
				table.insert(var_8_0, iter_8_1)
			end

			table.sort(var_8_0, function(arg_9_0, arg_9_1)
				return arg_9_0.baseId < arg_9_1.baseId
			end)
		end
	end

	return var_8_0
end

function var_0_0.getSeasonBaseSpotCo(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_0._baseSpotConfig.configDict[arg_10_1][arg_10_2]
end

function var_0_0.getSeasonBaseLevelCo(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_0._baseSpotLevelConfig.configDict[arg_11_1] and arg_11_0._baseSpotLevelConfig.configDict[arg_11_1][arg_11_2] then
		return arg_11_0._baseSpotLevelConfig.configDict[arg_11_1][arg_11_2][arg_11_3]
	end
end

function var_0_0.getSeasonBaseLevelCos(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._baseLevelCoList[arg_12_1]

	if not var_12_0 then
		var_12_0 = {}
		arg_12_0._baseLevelCoList[arg_12_1] = var_12_0
	end

	if not var_12_0[arg_12_2] then
		local var_12_1 = {}

		var_12_0[arg_12_2] = var_12_1

		local var_12_2 = arg_12_0._baseSpotLevelConfig.configDict[arg_12_1] and arg_12_0._baseSpotLevelConfig.configDict[arg_12_1][arg_12_2] or {}

		for iter_12_0, iter_12_1 in pairs(var_12_2) do
			table.insert(var_12_1, iter_12_1)
		end

		table.sort(var_12_1, function(arg_13_0, arg_13_1)
			return arg_13_0.level < arg_13_1.level
		end)
	end

	return arg_12_0._baseLevelCoList[arg_12_1][arg_12_2]
end

function var_0_0.getSeasonBaseTargetCo(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_0._baseTargetConfig.configDict[arg_14_1] and arg_14_0._baseTargetConfig.configDict[arg_14_1][arg_14_2] then
		return arg_14_0._baseTargetConfig.configDict[arg_14_1][arg_14_2][arg_14_3]
	end
end

function var_0_0.getSeasonBaseTargetCos(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0._baseTargetCoList[arg_15_1]

	if not var_15_0 then
		var_15_0 = {}
		arg_15_0._baseTargetCoList[arg_15_1] = var_15_0

		local var_15_1 = arg_15_0._baseTargetConfig.configDict[arg_15_1] and arg_15_0._baseTargetConfig.configDict[arg_15_1][arg_15_2] or {}

		for iter_15_0, iter_15_1 in pairs(var_15_1) do
			table.insert(var_15_0, iter_15_1)
		end

		table.sort(var_15_0, function(arg_16_0, arg_16_1)
			return arg_16_0.targetId < arg_16_1.targetId
		end)
	end

	return var_15_0
end

function var_0_0.getSeasonTrainCos(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._trainCoList[arg_17_1]

	if not var_17_0 then
		var_17_0 = {}
		arg_17_0._trainCoList[arg_17_1] = var_17_0

		local var_17_1 = arg_17_0._trainConfig.configDict[arg_17_1]

		if var_17_1 then
			for iter_17_0, iter_17_1 in pairs(var_17_1) do
				table.insert(var_17_0, iter_17_1)
			end

			table.sort(var_17_0, function(arg_18_0, arg_18_1)
				return arg_18_0.trainId < arg_18_1.trainId
			end)
		end
	end

	return var_17_0
end

function var_0_0.getSeasonTrainCo(arg_19_0, arg_19_1, arg_19_2)
	return arg_19_0._trainConfig.configDict[arg_19_1] and arg_19_0._trainConfig.configDict[arg_19_1][arg_19_2]
end

function var_0_0.getSeasonTeachCos(arg_20_0, arg_20_1)
	return arg_20_0._teachConfig.configDict[arg_20_1]
end

function var_0_0.getAllSeasonTeachCos(arg_21_0)
	return arg_21_0._teachConfig.configList
end

function var_0_0.getSeasonScoreCo(arg_22_0, arg_22_1, arg_22_2)
	return arg_22_0._scoreConfig.configDict[arg_22_1][arg_22_2]
end

function var_0_0.getSeasonScoreCos(arg_23_0, arg_23_1)
	return arg_23_0._scoreConfig.configDict[arg_23_1]
end

function var_0_0.getSeasonInfos(arg_24_0, arg_24_1)
	return arg_24_0._infoConfig.configDict[arg_24_1]
end

function var_0_0.getSeasonInfoConfig(arg_25_0, arg_25_1, arg_25_2)
	return arg_25_0._infoConfig.configDict[arg_25_1] and arg_25_0._infoConfig.configDict[arg_25_1][arg_25_2]
end

function var_0_0.getSeasonInfoAnalys(arg_26_0, arg_26_1, arg_26_2)
	return arg_26_0._infoAnalyConfig.configDict[arg_26_1] and arg_26_0._infoAnalyConfig.configDict[arg_26_1][arg_26_2]
end

function var_0_0.getSeasonInfoBonuss(arg_27_0, arg_27_1)
	return arg_27_0._infoBonusConfig.configDict[arg_27_1]
end

function var_0_0.buildSeasonWordEffectConfig(arg_28_0)
	arg_28_0.wordEffectConfigMap = arg_28_0.wordEffectConfigMap or {}

	local var_28_0 = arg_28_0._wordEffectConfig.configList

	for iter_28_0, iter_28_1 in ipairs(var_28_0) do
		local var_28_1 = arg_28_0.wordEffectConfigMap[iter_28_1.activityId]

		if not var_28_1 then
			var_28_1 = {}
			arg_28_0.wordEffectConfigMap[iter_28_1.activityId] = var_28_1
		end

		if not var_28_1[iter_28_1.type] then
			var_28_1[iter_28_1.type] = {}
		end

		table.insert(var_28_1[iter_28_1.type], iter_28_1)
	end
end

function var_0_0.getSeasonWordEffectConfigList(arg_29_0, arg_29_1, arg_29_2)
	return arg_29_0.wordEffectConfigMap[arg_29_1] and arg_29_0.wordEffectConfigMap[arg_29_1][arg_29_2]
end

function var_0_0.getSeasonWordEffectPosConfig(arg_30_0, arg_30_1, arg_30_2)
	return arg_30_0._wordEffectPosConfig.configDict[arg_30_1] and arg_30_0._wordEffectPosConfig.configDict[arg_30_1][arg_30_2]
end

function var_0_0.getSeasonConfigByEpisodeId(arg_31_0, arg_31_1)
	local var_31_0 = DungeonConfig.instance:getEpisodeCO(arg_31_1)
	local var_31_1 = var_31_0.type
	local var_31_2

	if var_31_1 and var_31_1 == DungeonEnum.EpisodeType.Season166Base then
		var_31_2 = arg_31_0._episodeId2Config[arg_31_1]

		if not var_31_2 then
			for iter_31_0, iter_31_1 in ipairs(lua_activity166_base.configList) do
				if iter_31_1.episodeId == arg_31_1 then
					var_31_2 = iter_31_1
					arg_31_0._episodeId2Config[arg_31_1] = var_31_2

					return iter_31_1
				end
			end
		end
	elseif var_31_1 and var_31_1 == DungeonEnum.EpisodeType.Season166Train then
		var_31_2 = arg_31_0._episodeId2Config[arg_31_1]

		if not var_31_2 then
			for iter_31_2, iter_31_3 in ipairs(lua_activity166_train.configList) do
				if iter_31_3.episodeId == arg_31_1 then
					var_31_2 = iter_31_3
					arg_31_0._episodeId2Config[arg_31_1] = var_31_2

					return iter_31_3
				end
			end
		end
	elseif var_31_1 and var_31_1 == DungeonEnum.EpisodeType.Season166Teach then
		var_31_2 = arg_31_0._episodeId2Config[arg_31_1]

		if not var_31_2 then
			for iter_31_4, iter_31_5 in ipairs(lua_activity166_teach.configList) do
				if iter_31_5.episodeId == arg_31_1 then
					var_31_2 = iter_31_5
					var_31_2.activityId = DungeonConfig.instance:getChapterCO(var_31_0.chapterId).actId
					arg_31_0._episodeId2Config[arg_31_1] = var_31_2

					return iter_31_5
				end
			end
		end
	end

	return var_31_2
end

function var_0_0.getBaseSpotByTalentId(arg_32_0, arg_32_1, arg_32_2)
	for iter_32_0, iter_32_1 in pairs(arg_32_0._baseSpotConfig.configDict[arg_32_1]) do
		if iter_32_1.talentId == arg_32_2 then
			return iter_32_1
		end
	end

	logError("talentId dont bind base" .. arg_32_2)
end

function var_0_0.getAdditionScoreByParam(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = string.splitToNumber(arg_33_1.targetParam, "|")

	return string.splitToNumber(arg_33_1.score, "|")[tabletool.indexOf(var_33_0, arg_33_2)] or 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
