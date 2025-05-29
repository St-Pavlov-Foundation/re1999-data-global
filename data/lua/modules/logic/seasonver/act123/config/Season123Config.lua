local var_0_0 = class("Season123Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity123_const",
		"activity123_stage",
		"activity123_episode",
		"task_activity123",
		"activity123_equip",
		"activity123_equip_attr",
		"activity123_equip_tag",
		"activity123_story",
		"activity123_retail",
		"activity123_trial"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity123_const" then
		arg_3_0._constConfig = arg_3_2
	elseif arg_3_1 == "activity123_stage" then
		arg_3_0._stageConfig = arg_3_2
		arg_3_0._actId2StageList = {}
	elseif arg_3_1 == "activity123_episode" then
		arg_3_0._episodeConfig = arg_3_2
	elseif arg_3_1 == "activity123_equip" then
		arg_3_0._equipConfig = arg_3_2

		arg_3_0:preprocessEquip()
	elseif arg_3_1 == "activity123_equip_attr" then
		arg_3_0._equipAttrConfig = arg_3_2
	elseif arg_3_1 == "activity123_equip_tag" then
		arg_3_0._equipTagConfig = arg_3_2
	elseif arg_3_1 == "activity123_story" then
		arg_3_0._storyConfig = arg_3_2
	elseif arg_3_1 == "task_activity123" then
		arg_3_0._taskConfig = arg_3_2
	elseif arg_3_1 == "activity123_retail" then
		arg_3_0._retailConfig = arg_3_2
	elseif arg_3_1 == "activity123_trial" then
		arg_3_0._trialConfig = arg_3_2
	end
end

function var_0_0.preprocessEquip(arg_4_0)
	arg_4_0._equipIsOptionalDict = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0._equipConfig.configList) do
		if iter_4_1.isOptional == 1 then
			arg_4_0._equipIsOptionalDict[iter_4_1.equipId] = true
		end
	end
end

function var_0_0.getStageCos(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._actId2StageList[arg_5_1]

	if not var_5_0 then
		var_5_0 = {}
		arg_5_0._actId2StageList[arg_5_1] = var_5_0

		local var_5_1 = arg_5_0._stageConfig.configDict[arg_5_1]

		if var_5_1 then
			for iter_5_0, iter_5_1 in pairs(var_5_1) do
				table.insert(var_5_0, iter_5_1)
			end

			table.sort(var_5_0, function(arg_6_0, arg_6_1)
				return arg_6_0.stage < arg_6_1.stage
			end)
		end
	end

	return var_5_0
end

function var_0_0.getStageCo(arg_7_0, arg_7_1, arg_7_2)
	return arg_7_0._stageConfig.configDict[arg_7_1] and arg_7_0._stageConfig.configDict[arg_7_1][arg_7_2]
end

function var_0_0.getSeasonEpisodeStageCos(arg_8_0, arg_8_1, arg_8_2)
	return arg_8_0._episodeConfig.configDict[arg_8_1] and arg_8_0._episodeConfig.configDict[arg_8_1][arg_8_2]
end

function var_0_0.getSeasonEpisodeCo(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_0._episodeConfig.configDict[arg_9_1] and arg_9_0._episodeConfig.configDict[arg_9_1][arg_9_2] then
		return arg_9_0._episodeConfig.configDict[arg_9_1][arg_9_2][arg_9_3]
	end
end

function var_0_0.getAllSeasonEpisodeCO(arg_10_0, arg_10_1)
	if not arg_10_0._allEpisodeCOList or not arg_10_0._allEpisodeCOList[arg_10_1] then
		arg_10_0._allEpisodeCOList = arg_10_0._allEpisodeCOList or {}

		local var_10_0 = {}

		if arg_10_0._episodeConfig.configDict[arg_10_1] then
			for iter_10_0, iter_10_1 in pairs(arg_10_0._episodeConfig.configDict[arg_10_1]) do
				for iter_10_2, iter_10_3 in pairs(iter_10_1) do
					table.insert(var_10_0, iter_10_3)
				end
			end

			table.sort(var_10_0, function(arg_11_0, arg_11_1)
				if arg_11_0.stage ~= arg_11_1.stage then
					return arg_11_0.stage < arg_11_1.stage
				else
					return arg_11_0.layer < arg_11_1.layer
				end
			end)
		end

		arg_10_0._allEpisodeCOList[arg_10_1] = var_10_0
	end

	return arg_10_0._allEpisodeCOList[arg_10_1]
end

function var_0_0.getSeasonEpisodeByStage(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = {}
	local var_12_1 = arg_12_0:getSeasonEpisodeStageCos(arg_12_1, arg_12_2)

	if var_12_1 then
		for iter_12_0, iter_12_1 in pairs(var_12_1) do
			if arg_12_2 == iter_12_1.stage then
				table.insert(var_12_0, iter_12_1)
			end
		end

		table.sort(var_12_0, function(arg_13_0, arg_13_1)
			return arg_13_0.layer < arg_13_1.layer
		end)
	else
		logNormal(string.format("cfgList is nil, actId = %s, stage = %s", arg_12_1, arg_12_2))
	end

	return var_12_0
end

function var_0_0.getSeasonConstCo(arg_14_0, arg_14_1)
	return arg_14_0._constConfig.configDict[arg_14_1]
end

function var_0_0.getSeasonEquipCos(arg_15_0)
	return arg_15_0._equipConfig.configDict
end

function var_0_0.getSeasonEquipCo(arg_16_0, arg_16_1)
	return arg_16_0._equipConfig.configDict[arg_16_1]
end

function var_0_0.getSeasonOptionalEquipCos(arg_17_0)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in pairs(arg_17_0._equipConfig.configDict) do
		if iter_17_1.isOptional == 1 then
			table.insert(var_17_0, iter_17_1)
		end
	end

	return var_17_0
end

function var_0_0.getSeasonTagList(arg_18_0)
	return arg_18_0._equipTagConfig.configList
end

function var_0_0.getSeasonTagDesc(arg_19_0, arg_19_1)
	return arg_19_0._equipTagConfig.configDict[arg_19_1]
end

function var_0_0.getEquipIsOptional(arg_20_0, arg_20_1)
	return arg_20_0._equipIsOptionalDict[arg_20_1]
end

function var_0_0.getEquipCoByCondition(arg_21_0, arg_21_1)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_0._equipConfig.configList) do
		if arg_21_1(iter_21_1) then
			table.insert(var_21_0, iter_21_1)
		end
	end

	return var_21_0
end

function var_0_0.getSeasonEquipAttrCo(arg_22_0, arg_22_1)
	return arg_22_0._equipAttrConfig.configDict[arg_22_1]
end

function var_0_0.getConfigByEpisodeId(arg_23_0, arg_23_1)
	arg_23_0:_initEpisodeId2Config()

	return arg_23_0._episodeId2Config and arg_23_0._episodeId2Config[arg_23_1]
end

function var_0_0.getRetailCOByEpisodeId(arg_24_0, arg_24_1)
	arg_24_0:_initEpisodeId2RetailCO()

	return arg_24_0._episodeId2RetailCO and arg_24_0._episodeId2RetailCO[arg_24_1]
end

function var_0_0.getTrailCOByEpisodeId(arg_25_0, arg_25_1)
	arg_25_0:_initEpisodeId2TrailCO()

	return arg_25_0._episodeId2TrailCO and arg_25_0._episodeId2TrailCO[arg_25_1]
end

function var_0_0._initEpisodeId2Config(arg_26_0)
	if arg_26_0._episodeId2Config then
		return
	end

	arg_26_0._episodeId2Config = {}

	for iter_26_0, iter_26_1 in pairs(arg_26_0._episodeConfig.configDict) do
		for iter_26_2, iter_26_3 in pairs(iter_26_1) do
			for iter_26_4, iter_26_5 in pairs(iter_26_3) do
				arg_26_0._episodeId2Config[iter_26_5.episodeId] = iter_26_5
			end
		end
	end
end

function var_0_0._initEpisodeId2RetailCO(arg_27_0)
	if arg_27_0._episodeId2RetailCO then
		return
	end

	arg_27_0._episodeId2RetailCO = {}

	for iter_27_0, iter_27_1 in pairs(arg_27_0._retailConfig.configDict) do
		for iter_27_2, iter_27_3 in pairs(iter_27_1) do
			arg_27_0._episodeId2RetailCO[iter_27_3.episodeId] = iter_27_3
		end
	end
end

function var_0_0._initEpisodeId2TrailCO(arg_28_0)
	if arg_28_0._episodeId2TrailCO then
		return
	end

	arg_28_0._episodeId2TrailCO = {}

	for iter_28_0, iter_28_1 in pairs(arg_28_0._trialConfig.configDict) do
		for iter_28_2, iter_28_3 in pairs(iter_28_1) do
			arg_28_0._episodeId2TrailCO[iter_28_3.episodeId] = iter_28_3
		end
	end
end

function var_0_0.getEquipItemCoin(arg_29_0, arg_29_1, arg_29_2)
	return arg_29_0:getSeasonConstNum(arg_29_1, arg_29_2)
end

function var_0_0.getSeasonConstNum(arg_30_0, arg_30_1, arg_30_2)
	if not arg_30_0._constConfig.configDict[arg_30_1] or not arg_30_0._constConfig.configDict[arg_30_1][arg_30_2] then
		return nil
	end

	return arg_30_0._constConfig.configDict[arg_30_1][arg_30_2].value1
end

function var_0_0.getSeasonConstStr(arg_31_0, arg_31_1, arg_31_2)
	if not arg_31_0._constConfig.configDict[arg_31_1] or not arg_31_0._constConfig.configDict[arg_31_1][arg_31_2] then
		return nil
	end

	return arg_31_0._constConfig.configDict[arg_31_1][arg_31_2].value2
end

function var_0_0.getSeasonConstLangStr(arg_32_0, arg_32_1, arg_32_2)
	if not arg_32_0._constConfig.configDict[arg_32_1] or not arg_32_0._constConfig.configDict[arg_32_1][arg_32_2] then
		return nil
	end

	return arg_32_0._constConfig.configDict[arg_32_1][arg_32_2].value3
end

function var_0_0.getAllStoryCo(arg_33_0, arg_33_1)
	return arg_33_0._storyConfig.configDict[arg_33_1]
end

function var_0_0.getStoryConfig(arg_34_0, arg_34_1, arg_34_2)
	return arg_34_0._storyConfig.configDict[arg_34_1][arg_34_2]
end

function var_0_0.getSeason123TaskCo(arg_35_0, arg_35_1)
	return arg_35_0._taskConfig.configDict[arg_35_1]
end

function var_0_0.getSeason123AllTaskList(arg_36_0)
	return arg_36_0._taskConfig.configList
end

function var_0_0.getRetailCO(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_0._retailConfig.configDict[arg_37_1] then
		return arg_37_0._retailConfig.configDict[arg_37_1][arg_37_2]
	end
end

function var_0_0.getRecommendCareers(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_0:getStageCo(arg_38_1, arg_38_2)

	if var_38_0 and not string.nilorempty(var_38_0.recommend) then
		return string.split(var_38_0.recommend, "#")
	end
end

function var_0_0.getRecommendTagCoList(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_0:getStageCo(arg_39_1, arg_39_2)
	local var_39_1 = {}

	if var_39_0 and not string.nilorempty(var_39_0.recommendSchool) then
		local var_39_2 = string.splitToNumber(var_39_0.recommendSchool, "#")
		local var_39_3 = arg_39_0:getSeasonTagDesc(arg_39_1)

		for iter_39_0, iter_39_1 in ipairs(var_39_2) do
			if var_39_3[iter_39_1] then
				table.insert(var_39_1, var_39_3[iter_39_1])
			end
		end
	end

	return var_39_1
end

function var_0_0.filterRule(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = {}

	if arg_40_1 then
		local var_40_1 = Season123Model.instance:getCurSeasonId()

		if not var_40_1 then
			return
		end

		for iter_40_0, iter_40_1 in pairs(arg_40_1) do
			if not arg_40_0:isExistInRuleTips(var_40_1, arg_40_2, iter_40_1[2]) then
				table.insert(var_40_0, iter_40_1)
			end
		end
	end

	return var_40_0
end

function var_0_0.isExistInRuleTips(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	if not arg_41_0.ruleDict then
		arg_41_0.ruleDict = {}
	end

	arg_41_0.ruleDict[arg_41_1] = arg_41_0.ruleDict[arg_41_1] or {}

	if not arg_41_0.ruleDict[arg_41_1][arg_41_2] then
		local var_41_0 = arg_41_0:getRuleTips(arg_41_1, arg_41_2)

		arg_41_0.ruleDict[arg_41_1][arg_41_2] = var_41_0
	end

	return arg_41_0.ruleDict[arg_41_1][arg_41_2][arg_41_3] ~= nil
end

function var_0_0.getRuleTips(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_0:getStageCos(arg_42_1)[arg_42_2]
	local var_42_1 = {}

	if arg_42_2 then
		if not var_42_0 then
			arg_42_0.emptyTips = arg_42_0.emptyTips or {}

			return arg_42_0.emptyTips
		end

		var_42_1 = string.splitToNumber(var_42_0.stageCondition, "#")
	else
		local var_42_2 = arg_42_0:getSeasonConstStr(arg_42_1, Activity123Enum.Const.HideRule)

		var_42_1 = string.splitToNumber(var_42_2, "#")
	end

	local var_42_3 = {}

	for iter_42_0, iter_42_1 in ipairs(var_42_1) do
		var_42_3[iter_42_1] = true
	end

	return var_42_3
end

function var_0_0.getTrialCO(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0._trialConfig.configDict[arg_43_1]

	if var_43_0 then
		return var_43_0[arg_43_2]
	end

	return nil
end

function var_0_0.getTaskListenerParamCache(arg_44_0, arg_44_1)
	arg_44_0.taskListenerParamCache = arg_44_0.taskListenerParamCache or {}

	local var_44_0 = arg_44_0.taskListenerParamCache[arg_44_1]

	if not var_44_0 then
		var_44_0 = string.split(arg_44_1.listenerParam, "#")
		arg_44_0.taskListenerParamCache[arg_44_1] = var_44_0
	end

	return var_44_0
end

function var_0_0.getRewardTaskCount(arg_45_0, arg_45_1, arg_45_2)
	arg_45_0:checkInitRewardTaskCount()

	if arg_45_0._taskCountDict[arg_45_1] then
		return arg_45_0._taskCountDict[arg_45_1][arg_45_2] or 0
	end

	return 0
end

function var_0_0.checkInitRewardTaskCount(arg_46_0)
	if not arg_46_0._taskCountDict then
		arg_46_0._taskCountDict = {}

		local var_46_0 = arg_46_0:getSeason123AllTaskList()

		for iter_46_0, iter_46_1 in ipairs(var_46_0) do
			if iter_46_1.isRewardView == 1 then
				arg_46_0._taskCountDict[iter_46_1.seasonId] = arg_46_0._taskCountDict[iter_46_1.seasonId] or {}

				local var_46_1 = arg_46_0:getTaskListenerParamCache(iter_46_1)

				if #var_46_1 > 0 then
					local var_46_2 = tonumber(var_46_1[1])
					local var_46_3 = (arg_46_0._taskCountDict[iter_46_1.seasonId][var_46_2] or 0) + 1

					arg_46_0._taskCountDict[iter_46_1.seasonId][var_46_2] = var_46_3
				end
			end
		end
	end
end

function var_0_0.getCardLimitPosDict(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_0:getSeasonEquipCo(arg_47_1)

	if not var_47_0 or string.nilorempty(var_47_0.indexLimit) then
		return nil
	else
		arg_47_0._indexLimitDict = arg_47_0._indexLimitDict or {}
		arg_47_0._indexLimitStrDict = arg_47_0._indexLimitStrDict or {}

		local var_47_1 = arg_47_0._indexLimitDict[arg_47_1]
		local var_47_2 = arg_47_0._indexLimitStrDict[arg_47_1]

		if not var_47_1 then
			var_47_1 = {}

			local var_47_3 = string.splitToNumber(var_47_0.indexLimit, "#")

			var_47_2 = ""

			for iter_47_0, iter_47_1 in ipairs(var_47_3) do
				var_47_1[iter_47_1] = true

				if not string.nilorempty(var_47_2) then
					var_47_2 = var_47_2 .. "," .. tostring(iter_47_1)
				else
					var_47_2 = tostring(iter_47_1)
				end
			end

			arg_47_0._indexLimitDict[arg_47_1] = var_47_1
			arg_47_0._indexLimitStrDict[arg_47_1] = var_47_2
		end

		return var_47_1, var_47_2
	end
end

function var_0_0.isLastStage(arg_48_0, arg_48_1, arg_48_2)
	return arg_48_2 == tabletool.len(arg_48_0._stageConfig.configDict[arg_48_1])
end

function var_0_0.getCardSpecialEffectCache(arg_49_0, arg_49_1)
	arg_49_0.cardEffectCache = arg_49_0.cardEffectCache or {}

	local var_49_0 = arg_49_0.cardEffectCache[arg_49_1]

	if not var_49_0 then
		var_49_0 = {}

		local var_49_1 = arg_49_0:getSeasonEquipCo(arg_49_1)
		local var_49_2 = GameUtil.splitString2(var_49_1.specialEffect, true) or {}
		local var_49_3 = {}

		for iter_49_0, iter_49_1 in ipairs(var_49_2) do
			local var_49_4 = iter_49_1[1]

			for iter_49_2 = 2, #iter_49_1 do
				table.insert(var_49_3, iter_49_1[iter_49_2])
			end

			var_49_0[var_49_4] = var_49_3
		end

		arg_49_0.cardEffectCache[arg_49_1] = var_49_0
	end

	return var_49_0
end

function var_0_0.getCardSpecialEffectMap(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_0:getSeasonEquipCo(arg_50_1)
	local var_50_1 = {}

	if var_50_0 then
		return arg_50_0:getCardSpecialEffectCache(var_50_0.equipId) or {}
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
