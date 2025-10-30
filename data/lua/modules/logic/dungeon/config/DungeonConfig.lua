module("modules.logic.dungeon.config.DungeonConfig", package.seeall)

local var_0_0 = class("DungeonConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._chapterConfig = nil
	arg_1_0._episodeConfig = nil
	arg_1_0._bonusConfig = nil
	arg_1_0._chapterEpisodeDict = nil
	arg_1_0._chpaterNonSpEpisodeDict = nil
	arg_1_0._episodeIndex = {}
	arg_1_0._chapterListByType = {}
	arg_1_0._lvConfig = nil
	arg_1_0._interactConfig = nil
	arg_1_0._colorConfig = nil
	arg_1_0._dispatchConfig = nil
	arg_1_0._rewardConfigDict = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"chapter_map_element",
		"chapter_map",
		"chapter",
		"episode",
		"bonus",
		"battle",
		"condition",
		"rule",
		"chapter_divide",
		"chapter_point_reward",
		"chapter_map_fragment",
		"chapter_map_element_dispatch",
		"chapter_map_element_dialog",
		"equip_chapter",
		"chapter_puzzle_question",
		"chapter_puzzle_square",
		"chapter_map_hole",
		"reward",
		"reward_group",
		"chapter_puzzle_changecolor",
		"chapter_puzzle_changecolor_interact",
		"chapter_puzzle_changecolor_color"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "chapter" then
		arg_3_0._chapterConfig = arg_3_2

		arg_3_0:_initChapterList()
	elseif arg_3_1 == "episode" then
		arg_3_0._episodeConfig = arg_3_2

		arg_3_0:_rebuildEpisodeConfigs()
		arg_3_0:_initEpisodeList()
	elseif arg_3_1 == "bonus" then
		arg_3_0._bonusConfig = arg_3_2
	elseif arg_3_1 == "reward_group" then
		arg_3_0._rewardConfigDict = {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_2.configList) do
			if not arg_3_0._rewardConfigDict[iter_3_1.group] then
				arg_3_0._rewardConfigDict[iter_3_1.group] = {}
			end

			table.insert(arg_3_0._rewardConfigDict[iter_3_1.group], iter_3_1)
		end
	elseif arg_3_1 == "chapter_divide" then
		arg_3_0:_initChapterDivide()
	elseif arg_3_1 == "chapter_point_reward" then
		arg_3_0:_initChapterPointReward()
	elseif arg_3_1 == "chapter_map_element" then
		arg_3_0:_initElement()
	elseif arg_3_1 == "chapter_map_element_dialog" then
		arg_3_0:_initDialog()
	elseif arg_3_1 == "chapter_map" then
		arg_3_0:_initChapterMap()
	elseif arg_3_1 == "chapter_puzzle_square" then
		arg_3_0:_initPuzzleSquare(arg_3_2)
	elseif arg_3_1 == "chapter_puzzle_changecolor" then
		arg_3_0._lvConfig = arg_3_2
	elseif arg_3_1 == "chapter_puzzle_changecolor_interact" then
		arg_3_0._interactConfig = arg_3_2
	elseif arg_3_1 == "chapter_puzzle_changecolor_color" then
		arg_3_0._colorConfig = arg_3_2
	end
end

function var_0_0._initElement(arg_4_0)
	if arg_4_0._elementFightList then
		return
	end

	arg_4_0._elementFightList = {}
	arg_4_0._mapGuidepostDict = {}
	arg_4_0._mapIdToElements = {}

	for iter_4_0, iter_4_1 in ipairs(lua_chapter_map_element.configList) do
		if iter_4_1.type == DungeonEnum.ElementType.Fight then
			local var_4_0 = tonumber(iter_4_1.param)

			if arg_4_0._elementFightList[var_4_0] then
				logError(string.format("chapter_map_element.json element fight id:%s 参数：%s 重复配置了", iter_4_1.id, var_4_0))
			end

			if var_4_0 then
				arg_4_0._elementFightList[var_4_0] = iter_4_1
			else
				logError(string.format("战斗元件id：%s,没有配参数：%s", iter_4_1.id, iter_4_1.param))
			end
		elseif iter_4_1.type == DungeonEnum.ElementType.Guidepost then
			arg_4_0._mapGuidepostDict[iter_4_1.mapId] = iter_4_1.id
		end

		local var_4_1 = arg_4_0._mapIdToElements[iter_4_1.mapId]

		if not var_4_1 then
			var_4_1 = {}
			arg_4_0._mapIdToElements[iter_4_1.mapId] = var_4_1
		end

		table.insert(var_4_1, iter_4_1)
	end
end

function var_0_0.getMapElements(arg_5_0, arg_5_1)
	return arg_5_0._mapIdToElements and arg_5_0._mapIdToElements[arg_5_1]
end

function var_0_0.getMapElementByFragmentId(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(lua_chapter_map_element.configList) do
		if iter_6_1.fragment == arg_6_1 then
			return iter_6_1
		end
	end
end

function var_0_0.getMapGuidepost(arg_7_0, arg_7_1)
	return arg_7_0._mapGuidepostDict[arg_7_1]
end

function var_0_0.getElementEpisode(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._elementFightList[arg_8_1]

	if not var_8_0 then
		return nil
	end

	local var_8_1 = var_8_0.mapId

	return arg_8_0._chapterMapEpisodeDic[var_8_1]
end

function var_0_0.getEpisodeIdByMapId(arg_9_0, arg_9_1)
	return arg_9_0._chapterMapEpisodeDic[arg_9_1]
end

function var_0_0.getDispatchCfg(arg_10_0, arg_10_1)
	local var_10_0

	if arg_10_1 then
		var_10_0 = lua_chapter_map_element_dispatch.configDict[arg_10_1]
	end

	if not var_10_0 then
		logError(string.format("DungeonConfig:getDispatchCfg error, cfg is nil, dispatchId: %s", arg_10_1))
	end

	return var_10_0
end

function var_0_0._initDialog(arg_11_0)
	if arg_11_0._dialogList then
		return
	end

	arg_11_0._dialogList = {}

	local var_11_0
	local var_11_1 = 0

	for iter_11_0, iter_11_1 in ipairs(lua_chapter_map_element_dialog.configList) do
		local var_11_2 = arg_11_0._dialogList[iter_11_1.id]

		if not var_11_2 then
			var_11_2 = {}
			var_11_0 = var_11_1
			arg_11_0._dialogList[iter_11_1.id] = var_11_2
		end

		if iter_11_1.type == "selector" then
			var_11_0 = iter_11_1.param
		elseif iter_11_1.type == "selectorend" then
			var_11_0 = var_11_1
		else
			var_11_2[var_11_0] = var_11_2[var_11_0] or {}

			table.insert(var_11_2[var_11_0], iter_11_1)
		end
	end
end

function var_0_0.getDialog(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._dialogList[arg_12_1]

	return var_12_0 and var_12_0[arg_12_2]
end

function var_0_0._initChapterDivide(arg_13_0)
	arg_13_0._chapterDivide = {}

	for iter_13_0, iter_13_1 in ipairs(lua_chapter_divide.configList) do
		for iter_13_2, iter_13_3 in ipairs(iter_13_1.chapterId) do
			arg_13_0._chapterDivide[iter_13_3] = iter_13_1.sectionId
		end
	end
end

function var_0_0.getChapterDivideSectionId(arg_14_0, arg_14_1)
	return arg_14_0._chapterDivide[arg_14_1]
end

function var_0_0._initChapterPointReward(arg_15_0)
	if arg_15_0._chapterPointReward then
		return
	end

	arg_15_0._chapterPointReward = {}

	for iter_15_0, iter_15_1 in ipairs(lua_chapter_point_reward.configList) do
		arg_15_0._chapterPointReward[iter_15_1.chapterId] = arg_15_0._chapterPointReward[iter_15_1.chapterId] or {}

		table.insert(arg_15_0._chapterPointReward[iter_15_1.chapterId], iter_15_1)
	end
end

function var_0_0.getChapterPointReward(arg_16_0, arg_16_1)
	return arg_16_0._chapterPointReward[arg_16_1]
end

function var_0_0._initChapterMap(arg_17_0)
	if arg_17_0._chapterMapList then
		return
	end

	arg_17_0._chapterMapList = {}
	arg_17_0._chapterMapEpisodeDic = {}

	for iter_17_0, iter_17_1 in ipairs(lua_chapter_map.configList) do
		arg_17_0._chapterMapList[iter_17_1.chapterId] = arg_17_0._chapterMapList[iter_17_1.chapterId] or {}

		if string.nilorempty(iter_17_1.unlockCondition) then
			arg_17_0._chapterMapList[iter_17_1.chapterId][0] = iter_17_1
		else
			local var_17_0 = string.gsub(iter_17_1.unlockCondition, "EpisodeFinish=", "")
			local var_17_1 = tonumber(var_17_0)

			arg_17_0._chapterMapList[iter_17_1.chapterId][var_17_1] = iter_17_1
		end
	end
end

function var_0_0._mapConnectEpisode(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._chapterMapList[arg_18_1.chapterId]

	if not var_18_0 then
		return
	end

	local var_18_1 = arg_18_1.preEpisode <= 0

	var_18_1 = var_18_1 or arg_18_0:getEpisodeCO(arg_18_1.preEpisode).chapterId ~= arg_18_1.chapterId

	local var_18_2 = var_18_0[var_18_1 and 0 or arg_18_1.preEpisode2]

	if not var_18_2 then
		return
	end

	arg_18_0._chapterMapEpisodeDic[var_18_2.id] = arg_18_1.id
end

function var_0_0.getChapterMapCfg(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0._chapterMapList[arg_19_1]
	local var_19_1 = var_19_0 and var_19_0[arg_19_2]

	if var_19_1 then
		return var_19_1
	end

	arg_19_2 = arg_19_0._backwardChainDict[arg_19_2]

	return var_19_0 and var_19_0[arg_19_2]
end

function var_0_0.getEpisodeIdByMapCo(arg_20_0, arg_20_1)
	if not arg_20_0._chapterMapList then
		return
	end

	local var_20_0 = arg_20_1.chapterId
	local var_20_1 = arg_20_0._chapterMapList[var_20_0]

	if not var_20_1 then
		return
	end

	for iter_20_0, iter_20_1 in pairs(var_20_1) do
		local var_20_2 = arg_20_0:getChapterMapCfg(var_20_0, iter_20_0)

		if var_20_2 and var_20_2.id == arg_20_1.id then
			local var_20_3 = arg_20_0:getChapterEpisodeCOList(var_20_0)

			for iter_20_2, iter_20_3 in ipairs(var_20_3) do
				if iter_20_3.preEpisode == iter_20_0 then
					return iter_20_3.id
				end
			end
		end
	end
end

function var_0_0.getChapterMapElement(arg_21_0, arg_21_1)
	return lua_chapter_map_element.configDict[arg_21_1]
end

function var_0_0.isDispatchElement(arg_22_0, arg_22_1)
	local var_22_0 = false
	local var_22_1 = arg_22_1 and arg_22_0:getChapterMapElement(arg_22_1)

	if var_22_1 then
		var_22_0 = var_22_1.type == DungeonEnum.ElementType.Dispatch
	end

	return var_22_0
end

function var_0_0.getElementDispatchId(arg_23_0, arg_23_1)
	local var_23_0

	if arg_23_0:isDispatchElement(arg_23_1) then
		local var_23_1 = arg_23_0:getChapterMapElement(arg_23_1)

		var_23_0 = var_23_1 and var_23_1.param or nil
	end

	return tonumber(var_23_0)
end

function var_0_0.getHardEpisode(arg_24_0, arg_24_1)
	if not arg_24_0._normalHardMap then
		arg_24_0._normalHardMap = {}

		for iter_24_0, iter_24_1 in ipairs(lua_episode.configList) do
			local var_24_0 = arg_24_0:getChapterCO(iter_24_1.chapterId)

			if var_24_0 and var_24_0.type == DungeonEnum.ChapterType.Hard then
				arg_24_0._normalHardMap[iter_24_1.preEpisode] = iter_24_1
			end
		end
	end

	return arg_24_0._normalHardMap[arg_24_1]
end

function var_0_0.getNormalEpisodeId(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getEpisodeCO(arg_25_1)

	if arg_25_0:getChapterCO(var_25_0.chapterId).type == DungeonEnum.ChapterType.Simple then
		return var_25_0.normalEpisodeId
	else
		arg_25_0:getHardEpisode(arg_25_1)

		for iter_25_0, iter_25_1 in pairs(arg_25_0._normalHardMap) do
			if iter_25_1.id == arg_25_1 then
				return iter_25_0
			end
		end
	end

	return arg_25_1
end

function var_0_0.getChapterCOList(arg_26_0)
	return arg_26_0._chapterConfig.configList
end

function var_0_0.getFirstChapterCO(arg_27_0)
	return arg_27_0:getChapterCOList()[1]
end

function var_0_0.getChapterCOListByType(arg_28_0, arg_28_1)
	if arg_28_0._chapterListByType[arg_28_1] then
		return arg_28_0._chapterListByType[arg_28_1]
	end

	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs(arg_28_0:getChapterCOList()) do
		if iter_28_1.type == arg_28_1 then
			table.insert(var_28_0, iter_28_1)
		end
	end

	arg_28_0._chapterListByType[arg_28_1] = var_28_0

	return var_28_0
end

function var_0_0.getChapterIndex(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0:getChapterCOListByType(arg_29_1)

	if var_29_0 then
		for iter_29_0, iter_29_1 in ipairs(var_29_0) do
			if iter_29_1.id == arg_29_2 then
				if arg_29_1 == DungeonEnum.ChapterType.Simple then
					return iter_29_0 + 3, #var_29_0
				end

				return iter_29_0, #var_29_0
			end
		end
	end

	return nil, nil
end

function var_0_0.episodeSortFunction(arg_30_0, arg_30_1)
	if not arg_30_0 and arg_30_1 then
		return true
	end

	if not arg_30_1 then
		return false
	end

	local var_30_0 = var_0_0.instance:getEpisodeCO(arg_30_0)
	local var_30_1 = var_0_0.instance:getEpisodeCO(arg_30_1)

	if not var_30_0 or not var_30_1 then
		return false
	end

	local var_30_2 = var_30_0.chapterId
	local var_30_3 = var_30_1.chapterId
	local var_30_4 = var_0_0.instance:getChapterCO(var_30_2)
	local var_30_5 = var_0_0.instance:getChapterCO(var_30_3)
	local var_30_6 = var_30_4.type
	local var_30_7 = var_30_5.type

	if (var_30_6 == DungeonEnum.ChapterType.Normal or var_30_6 == DungeonEnum.ChapterType.Hard) and (var_30_6 == DungeonEnum.ChapterType.Normal or var_30_6 == DungeonEnum.ChapterType.Hard) then
		local var_30_8 = var_0_0.instance:getChapterIndex(var_30_6, var_30_2)
		local var_30_9 = var_0_0.instance:getChapterIndex(var_30_7, var_30_3)

		if var_30_8 ~= var_30_9 then
			return var_30_8 < var_30_9
		elseif var_30_6 ~= var_30_7 then
			return var_30_6 == DungeonEnum.ChapterType.Normal
		else
			local var_30_10, var_30_11 = var_0_0.instance:getChapterEpisodeIndexWithSP(var_30_2, arg_30_0)
			local var_30_12, var_30_13 = var_0_0.instance:getChapterEpisodeIndexWithSP(var_30_3, arg_30_1)

			if var_30_11 ~= DungeonEnum.EpisodeType.Sp and var_30_13 == DungeonEnum.EpisodeType.Sp then
				return true
			else
				return var_30_10 < var_30_12
			end
		end
	elseif var_30_6 ~= var_30_7 then
		return var_30_6 < var_30_7
	else
		local var_30_14, var_30_15 = var_0_0.instance:getChapterEpisodeIndexWithSP(var_30_2, arg_30_0)
		local var_30_16, var_30_17 = var_0_0.instance:getChapterEpisodeIndexWithSP(var_30_3, arg_30_1)

		if var_30_15 ~= DungeonEnum.EpisodeType.Sp and var_30_17 == DungeonEnum.EpisodeType.Sp then
			return true
		else
			return var_30_14 < var_30_16
		end
	end
end

function var_0_0.getChapterFrontSpNum(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0:getChapterCO(arg_31_1)
	local var_31_1 = 0

	if var_31_0 and var_31_0.preChapter > 0 then
		var_31_1 = var_31_1 + arg_31_0:getChapterFrontSpNum(var_31_0.preChapter)
		var_31_1 = var_31_1 + arg_31_0:getChapterSpNum(var_31_0.preChapter)
	end

	return var_31_1
end

function var_0_0.getChapterEpisodeIndexWithSP(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0:getChapterEpisodeCOList(arg_32_1)
	local var_32_1 = 0
	local var_32_2 = 0
	local var_32_3
	local var_32_4

	for iter_32_0, iter_32_1 in ipairs(var_32_0) do
		local var_32_5 = iter_32_1.type == DungeonEnum.EpisodeType.Sp

		var_32_4 = iter_32_1.type

		if var_32_5 then
			var_32_1 = var_32_1 + 1
			var_32_3 = var_32_1
		else
			var_32_2 = var_32_2 + 1
			var_32_3 = var_32_2
		end

		if iter_32_1.id == arg_32_2 then
			break
		end
	end

	if var_32_4 == DungeonEnum.EpisodeType.Sp then
		var_32_3 = var_32_3 + arg_32_0:getChapterFrontSpNum(arg_32_1)
	end

	return var_32_3, var_32_4
end

function var_0_0.getEpisodeIndex(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:getEpisodeCO(arg_33_1)
	local var_33_1 = arg_33_0:getChapterEpisodeCOList(var_33_0.chapterId)
	local var_33_2 = 0

	for iter_33_0, iter_33_1 in ipairs(var_33_1) do
		var_33_2 = var_33_2 + 1

		if iter_33_1.id == arg_33_1 then
			break
		end
	end

	return var_33_2
end

function var_0_0.getEpisodeDisplay(arg_34_0, arg_34_1)
	if not arg_34_1 or arg_34_1 == 0 then
		return nil
	end

	local var_34_0 = arg_34_0:getEpisodeCO(arg_34_1)
	local var_34_1 = var_34_0 and arg_34_0:getChapterCO(var_34_0.chapterId)

	if not var_34_0 or not var_34_1 then
		return nil
	end

	local var_34_2 = var_34_1.chapterIndex
	local var_34_3, var_34_4 = arg_34_0:getChapterEpisodeIndexWithSP(var_34_1.id, var_34_0.id)

	if var_34_4 == DungeonEnum.EpisodeType.Sp then
		var_34_2 = "SP"
	end

	return string.format("%s-%s", var_34_2, var_34_3)
end

function var_0_0.getChapterCO(arg_35_0, arg_35_1)
	return arg_35_0._chapterConfig.configDict[arg_35_1]
end

function var_0_0.getEpisodeCO(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0._episodeConfig.configDict[arg_36_1]

	if not var_36_0 then
		logNormal("dungeon no episode:" .. tostring(arg_36_1))
	end

	return var_36_0
end

function var_0_0.getEpisodeAdditionRule(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:getEpisodeBattleId(arg_37_1)
	local var_37_1 = var_37_0 and lua_battle.configDict[var_37_0]

	return var_37_1 and var_37_1.additionRule
end

function var_0_0.getBattleAdditionRule(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_1 and lua_battle.configDict[arg_38_1]

	return var_38_0 and var_38_0.additionRule
end

function var_0_0.getEpisodeAdvancedCondition(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_2 or arg_39_0:getEpisodeBattleId(arg_39_1)
	local var_39_1 = var_39_0 and lua_battle.configDict[var_39_0]

	return var_39_1 and var_39_1.advancedCondition
end

function var_0_0.getEpisodeAdvancedCondition2(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	local var_40_0 = arg_40_3 or arg_40_0:getEpisodeBattleId(arg_40_1)
	local var_40_1 = var_40_0 and lua_battle.configDict[var_40_0]
	local var_40_2 = var_40_1 and var_40_1.advancedCondition

	if not var_40_2 then
		return var_40_2
	end

	return string.splitToNumber(var_40_2, "|")[arg_40_2]
end

function var_0_0.getEpisodeCondition(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_2 or arg_41_0:getEpisodeBattleId(arg_41_1)
	local var_41_1 = lua_battle.configDict[var_41_0]

	if not var_41_1 then
		return ""
	else
		return var_41_1.winCondition
	end
end

function var_0_0.getBattleCo(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_2 or arg_42_0:getEpisodeBattleId(arg_42_1)

	return lua_battle.configDict[var_42_0]
end

function var_0_0.getEpisodeBattleId(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0:getEpisodeCO(arg_43_1)

	if not var_43_0 then
		return nil
	end

	local var_43_1 = var_43_0.firstBattleId

	if var_43_1 and var_43_1 > 0 then
		local var_43_2 = DungeonModel.instance:getEpisodeInfo(arg_43_1)

		if var_43_2 and var_43_2.star <= DungeonEnum.StarType.None then
			return var_43_1
		end

		if HeroGroupBalanceHelper.isClickBalance() then
			local var_43_3 = FightModel.instance:getFightParam()

			if var_43_3 and var_43_3.battleId == var_43_1 then
				return var_43_1
			end
		end
	end

	if FightModel.instance:getFightParam() and var_43_0.type ~= DungeonEnum.EpisodeType.Story and var_43_0.battleId == 0 then
		return FightModel.instance:getFightParam().battleId
	end

	return var_43_0.battleId
end

function var_0_0.getBonusCO(arg_44_0, arg_44_1)
	return arg_44_0._bonusConfig.configDict[arg_44_1]
end

function var_0_0.isNewReward(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = lua_episode.configDict[arg_45_1]

	if not var_45_0 then
		return
	end

	if not lua_reward.configDict[var_45_0[arg_45_2]] then
		return
	end

	return true
end

function var_0_0.getRewardItems(arg_46_0, arg_46_1)
	local var_46_0 = lua_reward.configDict[arg_46_1]

	if not var_46_0 then
		return {}
	end

	arg_46_0._cacheRewardResults = arg_46_0._cacheRewardResults or {}

	if arg_46_0._cacheRewardResults[arg_46_1] then
		return arg_46_0._cacheRewardResults[arg_46_1]
	end

	local var_46_1 = {}
	local var_46_2 = {}

	for iter_46_0 = 1, math.huge do
		local var_46_3 = var_46_0["rewardGroup" .. iter_46_0]

		if not var_46_3 then
			break
		end

		local var_46_4 = string.match(var_46_3, "^(.+):")

		if var_46_4 then
			local var_46_5 = arg_46_0._rewardConfigDict[var_46_4]

			if var_46_5 then
				for iter_46_1, iter_46_2 in ipairs(var_46_5) do
					if iter_46_2.label ~= "none" then
						var_46_2[iter_46_2.materialType] = var_46_2[iter_46_2.materialType] or {}

						if not var_46_2[iter_46_2.materialType][iter_46_2.materialId] then
							var_46_2[iter_46_2.materialType][iter_46_2.materialId] = true

							table.insert(var_46_1, {
								iter_46_2.materialType,
								iter_46_2.materialId,
								iter_46_2.shownum == 1 and tonumber(iter_46_2.count) or 0,
								tagType = DungeonEnum.RewardProbability[iter_46_2.label]
							})
						end
					end
				end
			end
		end
	end

	table.sort(var_46_1, var_0_0._rewardSort)

	arg_46_0._cacheRewardResults[arg_46_1] = var_46_1

	return var_46_1
end

function var_0_0._rewardSort(arg_47_0, arg_47_1)
	local var_47_0 = ItemModel.instance:getItemConfig(arg_47_0[1], arg_47_0[2])
	local var_47_1 = ItemModel.instance:getItemConfig(arg_47_1[1], arg_47_1[2])

	if var_47_0.rare ~= var_47_1.rare then
		return var_47_0.rare > var_47_1.rare
	else
		return var_47_0.id > var_47_1.id
	end
end

function var_0_0.getMaterialSource(arg_48_0, arg_48_1, arg_48_2)
	if not arg_48_0._materialSourceDict then
		arg_48_0._materialSourceDict = {}

		for iter_48_0, iter_48_1 in ipairs(lua_episode.configList) do
			local var_48_0 = lua_chapter.configDict[iter_48_1.chapterId]

			if var_48_0 and (var_48_0.type == DungeonEnum.ChapterType.Normal or var_48_0.type == DungeonEnum.ChapterType.Hard or var_48_0.type == DungeonEnum.ChapterType.Simple) then
				local var_48_1 = iter_48_1.reward
				local var_48_2 = lua_reward.configDict[var_48_1]

				if var_48_2 then
					for iter_48_2 = 1, math.huge do
						local var_48_3 = var_48_2["rewardGroup" .. iter_48_2]

						if not var_48_3 then
							break
						end

						local var_48_4 = string.match(var_48_3, "^(.+):")

						if var_48_4 then
							local var_48_5 = arg_48_0._rewardConfigDict[var_48_4]

							if var_48_5 then
								for iter_48_3, iter_48_4 in ipairs(var_48_5) do
									if iter_48_4.label ~= "none" then
										if not arg_48_0._materialSourceDict[iter_48_4.materialType] then
											arg_48_0._materialSourceDict[iter_48_4.materialType] = {}
										end

										if not arg_48_0._materialSourceDict[iter_48_4.materialType][iter_48_4.materialId] then
											arg_48_0._materialSourceDict[iter_48_4.materialType][iter_48_4.materialId] = {}
										end

										if not tabletool.indexOf(arg_48_0._materialSourceDict[iter_48_4.materialType][iter_48_4.materialId], iter_48_1.id) then
											table.insert(arg_48_0._materialSourceDict[iter_48_4.materialType][iter_48_4.materialId], {
												episodeId = iter_48_1.id,
												probability = DungeonEnum.RewardProbabilityToMaterialProbability[iter_48_4.label]
											})
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	if not arg_48_0._materialSourceDict[arg_48_1] then
		return
	end

	return arg_48_0._materialSourceDict[arg_48_1][arg_48_2]
end

function var_0_0._initChapterList(arg_49_0)
	arg_49_0._normalChapterList = {}
	arg_49_0._exploreChapterList = {}
	arg_49_0._chapterUnlockMap = {}
	arg_49_0._previewChapterList = {}

	local var_49_0 = arg_49_0._chapterConfig.configList

	arg_49_0._lastEarlyAccessChapterId = 0

	for iter_49_0, iter_49_1 in ipairs(var_49_0) do
		if iter_49_1.type == DungeonEnum.ChapterType.Normal then
			table.insert(arg_49_0._normalChapterList, iter_49_1)

			arg_49_0._chapterUnlockMap[iter_49_1.preChapter] = iter_49_1
		elseif iter_49_1.type == DungeonEnum.ChapterType.Explore then
			table.insert(arg_49_0._exploreChapterList, iter_49_1)
		end

		if iter_49_1.dramaModeToMainChapterld > 0 then
			local var_49_1 = {
				iter_49_1,
				lua_chapter.configDict[iter_49_1.dramaModeToMainChapterld]
			}

			arg_49_0._previewChapterList[iter_49_1.dramaModeToMainChapterld] = var_49_1
			arg_49_0._previewChapterList[iter_49_1.id] = var_49_1

			if iter_49_1.dramaModeToMainChapterld > arg_49_0._lastEarlyAccessChapterId then
				arg_49_0._lastEarlyAccessChapterId = iter_49_1.dramaModeToMainChapterld
			end
		end
	end

	if arg_49_0._lastEarlyAccessChapterId == 0 then
		logError("DungeonConfig _initChapterList _lastEarlyAccessChapterId == 0")
	end
end

function var_0_0.getLastEarlyAccessChapterId(arg_50_0)
	return arg_50_0._lastEarlyAccessChapterId
end

function var_0_0.getPreviewChapterList(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_0._previewChapterList[arg_51_1]

	if not var_51_0 or #var_51_0 ~= 2 then
		logError(string.format("DungeonConfig getPreviewChapterList chapterId = %d, chapter list size = %s error", arg_51_1, var_51_0 and #var_51_0))
	end

	return var_51_0
end

function var_0_0.getUnlockChapterConfig(arg_52_0, arg_52_1)
	return arg_52_0._chapterUnlockMap[arg_52_1]
end

function var_0_0.getNormalChapterList(arg_53_0)
	return arg_53_0._normalChapterList
end

function var_0_0.getExploreChapterList(arg_54_0)
	return arg_54_0._exploreChapterList
end

function var_0_0._rebuildEpisodeConfigs(arg_55_0)
	local var_55_0 = {
		preEpisode2 = "preEpisode",
		normalEpisodeId = "id"
	}
	local var_55_1 = {
		"beforeStory",
		"story",
		"afterStory"
	}
	local var_55_2 = {}
	local var_55_3 = {}
	local var_55_4 = getmetatable(lua_episode.configList[1])
	local var_55_5 = {
		__index = function(arg_56_0, arg_56_1)
			local var_56_0 = var_55_0[arg_56_1] or arg_56_1
			local var_56_1 = var_55_4.__index(arg_56_0, var_56_0)
			local var_56_2 = arg_56_1 == "preEpisode"

			if var_56_2 and var_56_1 > 0 or arg_56_1 == "normalEpisodeId" then
				if var_56_2 then
					local var_56_3 = var_55_4.__index(arg_56_0, "preEpisodeId")

					if var_56_3 and var_56_3 > 0 then
						return var_56_3
					end
				end

				return var_55_2[var_56_1] or var_56_1
			end

			if tabletool.indexOf(var_55_1, arg_56_1) then
				local var_56_4 = var_55_4.__index(arg_56_0, "chainEpisode")

				if var_56_4 > 0 and lua_episode.configDict[var_56_4] then
					return lua_episode.configDict[var_56_4][arg_56_1]
				end
			end

			return var_56_1
		end,
		__newindex = var_55_4.__newindex
	}

	for iter_55_0, iter_55_1 in ipairs(lua_episode.configList) do
		setmetatable(iter_55_1, var_55_5)

		if iter_55_1.chainEpisode > 0 then
			var_55_2[iter_55_1.chainEpisode] = iter_55_1.id
			var_55_3[iter_55_1.id] = iter_55_1.chainEpisode
		end
	end

	arg_55_0._chainEpisodeDict = var_55_2
	arg_55_0._backwardChainDict = var_55_3
end

function var_0_0.getChainEpisodeDict(arg_57_0)
	return arg_57_0._chainEpisodeDict
end

function var_0_0._initEpisodeList(arg_58_0)
	arg_58_0._unlockEpisodeList = {}
	arg_58_0._chapterSpStats = {}
	arg_58_0._chapterEpisodeDict = {}
	arg_58_0._chpaterNonSpEpisodeDict = {}
	arg_58_0._episodeElementListDict = {}
	arg_58_0._episodeUnlockDict = {}

	local var_58_0 = arg_58_0._episodeConfig.configList

	for iter_58_0, iter_58_1 in ipairs(var_58_0) do
		local var_58_1 = arg_58_0._chapterEpisodeDict[iter_58_1.chapterId]

		if not var_58_1 then
			var_58_1 = {}
			arg_58_0._chapterEpisodeDict[iter_58_1.chapterId] = var_58_1
		end

		table.insert(var_58_1, iter_58_1)
		arg_58_0:_setEpisodeIndex(iter_58_1)

		if iter_58_1.preEpisode > 0 then
			if not string.nilorempty(iter_58_1.elementList) then
				arg_58_0._episodeElementListDict[iter_58_1.preEpisode] = iter_58_1.elementList
			end

			local var_58_2 = arg_58_0:getChapterCO(iter_58_1.chapterId)

			if var_58_2 and var_58_2.type ~= DungeonEnum.ChapterType.Hard then
				arg_58_0._episodeUnlockDict[iter_58_1.preEpisode] = iter_58_1.id
			end
		end

		if iter_58_1.unlockEpisode > 0 then
			local var_58_3 = arg_58_0._unlockEpisodeList[iter_58_1.unlockEpisode] or {}

			arg_58_0._unlockEpisodeList[iter_58_1.unlockEpisode] = var_58_3

			table.insert(var_58_3, iter_58_1.id)
		end

		if iter_58_1.type == DungeonEnum.EpisodeType.Sp then
			local var_58_4 = (arg_58_0._chapterSpStats[iter_58_1.chapterId] or 0) + 1

			arg_58_0._chapterSpStats[iter_58_1.chapterId] = var_58_4
		end

		arg_58_0:_mapConnectEpisode(iter_58_1)
	end
end

function var_0_0._initVersionActivityEpisodeList(arg_59_0)
	arg_59_0.versionActivityPreEpisodeDict = {}

	local var_59_0 = {
		VersionActivityEnum.DungeonChapterId.LeiMiTeBei3,
		VersionActivityEnum.DungeonChapterId.LeiMiTeBei4,
		VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal2,
		VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal3,
		VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei3,
		VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei4,
		VersionActivity1_5DungeonEnum.DungeonChapterId.Story2,
		VersionActivity1_5DungeonEnum.DungeonChapterId.Story3,
		VersionActivity1_6DungeonEnum.DungeonChapterId.Story2,
		VersionActivity1_6DungeonEnum.DungeonChapterId.Story3,
		VersionActivity1_8DungeonEnum.DungeonChapterId.Story2,
		VersionActivity1_8DungeonEnum.DungeonChapterId.Story3,
		VersionActivity2_0DungeonEnum.DungeonChapterId.Story2,
		VersionActivity2_0DungeonEnum.DungeonChapterId.Story3,
		VersionActivity2_1DungeonEnum.DungeonChapterId.Story2,
		VersionActivity2_1DungeonEnum.DungeonChapterId.Story3,
		VersionActivity2_3DungeonEnum.DungeonChapterId.Story2,
		VersionActivity2_3DungeonEnum.DungeonChapterId.Story3,
		VersionActivity2_4DungeonEnum.DungeonChapterId.Story2,
		VersionActivity2_4DungeonEnum.DungeonChapterId.Story3,
		VersionActivity2_5DungeonEnum.DungeonChapterId.Story2,
		VersionActivity2_5DungeonEnum.DungeonChapterId.Story3,
		VersionActivity2_7DungeonEnum.DungeonChapterId.Story2,
		VersionActivity2_7DungeonEnum.DungeonChapterId.Story3,
		VersionActivity2_9DungeonEnum.DungeonChapterId.Story2,
		VersionActivity2_9DungeonEnum.DungeonChapterId.Story3
	}
	local var_59_1

	for iter_59_0, iter_59_1 in ipairs(var_59_0) do
		local var_59_2 = arg_59_0._chapterEpisodeDict[iter_59_1]

		for iter_59_2, iter_59_3 in ipairs(var_59_2) do
			arg_59_0.versionActivityPreEpisodeDict[iter_59_3.preEpisode] = iter_59_3
		end
	end
end

function var_0_0.getVersionActivityEpisodeCoByPreEpisodeId(arg_60_0, arg_60_1)
	if not arg_60_0.versionActivityPreEpisodeDict then
		arg_60_0:_initVersionActivityEpisodeList()
	end

	return arg_60_0.versionActivityPreEpisodeDict[arg_60_1]
end

function var_0_0.getVersionActivityBrotherEpisodeByEpisodeCo(arg_61_0, arg_61_1)
	local var_61_0 = ActivityConfig.instance:getActIdByChapterId(arg_61_1.chapterId)

	if not var_61_0 then
		return {
			arg_61_1
		}
	end

	local var_61_1 = {}
	local var_61_2 = ActivityConfig.instance:getActivityDungeonConfig(var_61_0)

	while arg_61_1.chapterId ~= var_61_2.story1ChapterId do
		arg_61_1 = arg_61_0:getEpisodeCO(arg_61_1.preEpisode)
	end

	while arg_61_1 do
		table.insert(var_61_1, arg_61_1)

		arg_61_1 = arg_61_0:getVersionActivityEpisodeCoByPreEpisodeId(arg_61_1.id)
	end

	return var_61_1
end

function var_0_0._initVersionActivityEpisodeLevelList(arg_62_0, arg_62_1, arg_62_2)
	if not arg_62_0._versionActivityEpisodeLevelList then
		arg_62_0._versionActivityEpisodeLevelList = {}
	end

	local var_62_0 = {}

	while arg_62_2 ~= arg_62_1 do
		local var_62_1 = arg_62_0:getChapterEpisodeCOList(arg_62_2)

		for iter_62_0, iter_62_1 in ipairs(var_62_1) do
			var_62_0[iter_62_1.preEpisode] = iter_62_1.id
			arg_62_2 = arg_62_0:getEpisodeCO(iter_62_1.preEpisode).chapterId
		end
	end

	local var_62_2 = arg_62_0:getChapterEpisodeCOList(arg_62_1)

	for iter_62_2, iter_62_3 in ipairs(var_62_2) do
		arg_62_0._versionActivityEpisodeLevelList[iter_62_3.id] = {
			iter_62_3.id
		}

		if var_62_0[iter_62_3.id] then
			local var_62_3 = iter_62_3.id

			while var_62_0[var_62_3] do
				table.insert(arg_62_0._versionActivityEpisodeLevelList[iter_62_3.id], var_62_0[var_62_3])

				var_62_3 = var_62_0[var_62_3]
			end
		end
	end

	for iter_62_4, iter_62_5 in pairs(arg_62_0._versionActivityEpisodeLevelList) do
		if #iter_62_5 > 0 then
			for iter_62_6, iter_62_7 in ipairs(iter_62_5) do
				if iter_62_7 ~= iter_62_4 then
					arg_62_0._versionActivityEpisodeLevelList[iter_62_7] = iter_62_5
				end
			end
		end
	end
end

function var_0_0.get1_2VersionActivityEpisodeCoList(arg_63_0, arg_63_1)
	if arg_63_0._versionActivityEpisodeLevelList and arg_63_0._versionActivityEpisodeLevelList[arg_63_1] then
		return arg_63_0._versionActivityEpisodeLevelList[arg_63_1]
	end

	local var_63_0 = arg_63_0:getEpisodeCO(arg_63_1)
	local var_63_1 = VersionActivity1_2DungeonEnum.DungeonChapterId2StartChapterId[var_63_0.chapterId] or var_63_0.chapterId
	local var_63_2 = VersionActivity1_2DungeonEnum.DungeonChapterId2EndChapterId[var_63_0.chapterId] or var_63_0.chapterId

	arg_63_0:_initVersionActivityEpisodeLevelList(var_63_1, var_63_2)

	return arg_63_0._versionActivityEpisodeLevelList[arg_63_1]
end

function var_0_0.get1_2VersionActivityFirstLevelEpisodeId(arg_64_0, arg_64_1)
	local var_64_0 = arg_64_0:getEpisodeCO(arg_64_1)
	local var_64_1 = var_64_0.chapterId

	if VersionActivity1_2DungeonEnum.DungeonChapterId2ViewShowId[var_64_1] then
		while VersionActivity1_2DungeonEnum.DungeonChapterId2ViewShowId[var_64_1] ~= var_64_1 do
			var_64_0 = var_0_0.instance:getEpisodeCO(var_64_0.preEpisode)
			var_64_1 = var_64_0.chapterId
		end
	end

	return var_64_0.id
end

function var_0_0.getElementList(arg_65_0, arg_65_1)
	return arg_65_0._episodeElementListDict[arg_65_1] or ""
end

function var_0_0.getUnlockEpisodeId(arg_66_0, arg_66_1)
	return arg_66_0._episodeUnlockDict[arg_66_1]
end

function var_0_0.getChapterSpNum(arg_67_0, arg_67_1)
	return arg_67_0._chapterSpStats[arg_67_1] or 0
end

function var_0_0.getUnlockEpisodeList(arg_68_0, arg_68_1)
	return arg_68_0._unlockEpisodeList[arg_68_1]
end

function var_0_0.getChapterEpisodeCOList(arg_69_0, arg_69_1)
	local var_69_0 = arg_69_0._chapterEpisodeDict[arg_69_1]

	if var_69_0 and not var_69_0._sort then
		var_69_0._sort = true

		table.sort(var_69_0, function(arg_70_0, arg_70_1)
			local var_70_0 = SLFramework.FrameworkSettings.IsEditor and {}
			local var_70_1 = SLFramework.FrameworkSettings.IsEditor and {}

			return arg_69_0:_getEpisodeIndex(arg_70_0, var_70_0) < arg_69_0:_getEpisodeIndex(arg_70_1, var_70_1)
		end)
	end

	return var_69_0
end

function var_0_0.getChapterNonSpEpisodeCOList(arg_71_0, arg_71_1)
	local var_71_0 = arg_71_0._chpaterNonSpEpisodeDict[arg_71_1]

	if not var_71_0 then
		var_71_0 = {}
		arg_71_0._chpaterNonSpEpisodeDict[arg_71_1] = var_71_0

		local var_71_1 = arg_71_0:getChapterEpisodeCOList(arg_71_1)

		for iter_71_0, iter_71_1 in ipairs(var_71_1) do
			if iter_71_1.type ~= DungeonEnum.EpisodeType.Sp then
				table.insert(var_71_0, iter_71_1)
			end
		end
	end

	return var_71_0
end

function var_0_0.getChapterLastNonSpEpisode(arg_72_0, arg_72_1)
	local var_72_0 = arg_72_0:getChapterNonSpEpisodeCOList(arg_72_1)

	return var_72_0 and var_72_0[#var_72_0]
end

function var_0_0._setEpisodeIndex(arg_73_0, arg_73_1)
	if arg_73_1.preEpisode > 0 then
		local var_73_0 = arg_73_0._episodeIndex[arg_73_1.preEpisode]

		if var_73_0 then
			arg_73_0._episodeIndex[arg_73_1.id] = var_73_0 + 1
		end
	else
		arg_73_0._episodeIndex[arg_73_1.id] = 0
	end
end

function var_0_0._getEpisodeIndex(arg_74_0, arg_74_1, arg_74_2)
	if arg_74_2 then
		arg_74_2[arg_74_1] = true
	end

	local var_74_0 = arg_74_0._episodeIndex[arg_74_1.id]

	if var_74_0 then
		return var_74_0
	end

	local var_74_1 = arg_74_0:getEpisodeCO(arg_74_1.preEpisode)

	if arg_74_2 and arg_74_2[var_74_1] then
		logError(string.format("_getEpisodeIndex: %s前置互相依赖了", var_74_1.id))

		return 0
	end

	local var_74_2 = arg_74_0:_getEpisodeIndex(var_74_1, arg_74_2) + 1

	arg_74_0._episodeIndex[arg_74_1.id] = var_74_2

	return var_74_2
end

function var_0_0.isPreChapterList(arg_75_0, arg_75_1, arg_75_2)
	if arg_75_1 == arg_75_2 then
		return false
	end

	local var_75_0 = arg_75_0:getChapterCO(arg_75_2)
	local var_75_1 = {}

	while var_75_0 and var_75_0.preChapter ~= 0 do
		if var_75_0.preChapter == arg_75_1 then
			return true
		end

		if var_75_1[var_75_0.preChapter] then
			break
		end

		var_75_1[var_75_0.preChapter] = true
		var_75_0 = arg_75_0:getChapterCO(var_75_0.preChapter)
	end

	return false
end

function var_0_0.isPreEpisodeList(arg_76_0, arg_76_1, arg_76_2)
	if arg_76_1 == arg_76_2 then
		return false
	end

	if arg_76_1 == 0 or arg_76_2 == 0 then
		return false
	end

	local var_76_0 = arg_76_0:getEpisodeCO(arg_76_1)
	local var_76_1 = arg_76_0:getEpisodeCO(arg_76_2)

	if not var_76_0 or not var_76_1 then
		return false
	end

	if arg_76_0:isPreChapterList(var_76_0.chapterId, var_76_1.chapterId) then
		return true
	end

	local var_76_2 = var_76_1
	local var_76_3 = {}

	while var_76_2 and var_76_2.preEpisode ~= 0 do
		if var_76_2.preEpisode == arg_76_1 then
			return true
		end

		if var_76_3[var_76_2.preEpisode] then
			break
		end

		var_76_3[var_76_2.preEpisode] = true
		var_76_2 = arg_76_0:getEpisodeCO(var_76_2.preEpisode)
	end

	return false
end

function var_0_0.getMonsterListFromGroupID(arg_77_0, arg_77_1)
	local var_77_0 = {}
	local var_77_1 = {}
	local var_77_2 = {}
	local var_77_3 = string.splitToNumber(arg_77_1, "#")

	for iter_77_0, iter_77_1 in ipairs(var_77_3) do
		local var_77_4 = lua_monster_group.configDict[iter_77_1]
		local var_77_5 = string.splitToNumber(var_77_4.monster, "#")
		local var_77_6 = var_77_4.bossId

		for iter_77_2, iter_77_3 in ipairs(var_77_5) do
			if iter_77_3 and lua_monster.configDict[iter_77_3] then
				local var_77_7 = lua_monster.configDict[iter_77_3]

				if var_77_7 then
					table.insert(var_77_0, var_77_7)

					if FightHelper.isBossId(var_77_6, iter_77_3) then
						table.insert(var_77_2, var_77_7)
					else
						table.insert(var_77_1, var_77_7)
					end
				end
			end
		end
	end

	return var_77_0, var_77_1, var_77_2
end

function var_0_0.getCareersFromBattle(arg_78_0, arg_78_1)
	local var_78_0 = {}
	local var_78_1 = 0
	local var_78_2 = lua_battle.configDict[arg_78_1]

	if var_78_2 then
		local var_78_3 = {}
		local var_78_4, var_78_5, var_78_6 = arg_78_0:getMonsterListFromGroupID(var_78_2.monsterGroupIds)

		table.sort(var_78_5, function(arg_79_0, arg_79_1)
			return arg_79_0.level < arg_79_1.level
		end)
		table.sort(var_78_6, function(arg_80_0, arg_80_1)
			return arg_80_0.level < arg_80_1.level
		end)

		for iter_78_0, iter_78_1 in ipairs(var_78_5) do
			var_78_1 = var_78_1 + 1

			if not var_78_3[iter_78_1.career] then
				var_78_3[iter_78_1.career] = {}
			end

			var_78_3[iter_78_1.career].score = var_78_1
			var_78_3[iter_78_1.career].isBoss = false
		end

		for iter_78_2, iter_78_3 in ipairs(var_78_6) do
			var_78_1 = var_78_1 + 1

			if not var_78_3[iter_78_3.career] then
				var_78_3[iter_78_3.career] = {}
			end

			var_78_3[iter_78_3.career].score = var_78_1
			var_78_3[iter_78_3.career].isBoss = true
		end

		for iter_78_4, iter_78_5 in pairs(var_78_3) do
			local var_78_7 = {
				career = iter_78_4,
				score = iter_78_5.score,
				isBoss = iter_78_5.isBoss
			}

			table.insert(var_78_0, var_78_7)
		end

		table.sort(var_78_0, function(arg_81_0, arg_81_1)
			return arg_81_0.score < arg_81_1.score
		end)
	end

	return var_78_0
end

function var_0_0.getBossMonsterIdDict(arg_82_0, arg_82_1)
	local var_82_0 = {}

	if arg_82_1 then
		local var_82_1, var_82_2, var_82_3 = arg_82_0:getMonsterListFromGroupID(arg_82_1.monsterGroupIds)

		if var_82_3 then
			for iter_82_0 = 1, #var_82_3 do
				var_82_0[var_82_3[iter_82_0].id] = true
			end
		end
	end

	return var_82_0
end

function var_0_0.getBattleDisplayMonsterIds(arg_83_0, arg_83_1)
	local var_83_0 = {}
	local var_83_1 = {}
	local var_83_2 = string.splitToNumber(arg_83_1.monsterGroupIds, "#")

	for iter_83_0 = #var_83_2, 1, -1 do
		local var_83_3 = var_83_2[iter_83_0]
		local var_83_4 = lua_monster_group.configDict[var_83_3]
		local var_83_5 = string.splitToNumber(var_83_4.monster, "#")
		local var_83_6 = var_83_4.bossId
		local var_83_7 = 100
		local var_83_8 = {}

		for iter_83_1, iter_83_2 in ipairs(var_83_5) do
			if FightHelper.isBossId(var_83_6, iter_83_2) then
				var_83_7 = iter_83_1
			end
		end

		for iter_83_3, iter_83_4 in ipairs(var_83_5) do
			if iter_83_4 and lua_monster.configDict[iter_83_4] then
				local var_83_9 = {
					id = iter_83_4,
					distance = math.abs(iter_83_3 - var_83_7)
				}

				table.insert(var_83_8, var_83_9)
			end
		end

		table.sort(var_83_8, function(arg_84_0, arg_84_1)
			return arg_84_0.distance < arg_84_1.distance
		end)

		for iter_83_5, iter_83_6 in ipairs(var_83_8) do
			if not var_83_1[iter_83_6.id] then
				var_83_1[iter_83_6.id] = true

				table.insert(var_83_0, iter_83_6.id)
			end
		end
	end

	for iter_83_7, iter_83_8 in ipairs(var_83_2) do
		local var_83_10 = lua_monster_group.configDict[iter_83_8]
		local var_83_11 = string.nilorempty(var_83_10.spMonster) and {} or string.split(var_83_10.spMonster, "#")

		for iter_83_9, iter_83_10 in ipairs(var_83_11) do
			if not var_83_1[iter_83_10] then
				var_83_1[iter_83_10] = true

				table.insert(var_83_0, tonumber(iter_83_10))
			end
		end
	end

	return var_83_0
end

function var_0_0.getNormalChapterId(arg_85_0, arg_85_1)
	local var_85_0 = arg_85_0:getEpisodeCO(arg_85_1)
	local var_85_1 = arg_85_0:getChapterCO(var_85_0.chapterId)

	if var_85_1.type == DungeonEnum.ChapterType.Hard then
		local var_85_2 = arg_85_0:getEpisodeCO(var_85_0.preEpisode)

		var_85_1 = arg_85_0:getChapterCO(var_85_2.chapterId)
	end

	return var_85_1.id
end

function var_0_0.getChapterTypeByEpisodeId(arg_86_0, arg_86_1)
	local var_86_0 = arg_86_0:getEpisodeCO(arg_86_1)

	return arg_86_0:getChapterCO(var_86_0.chapterId).type
end

function var_0_0.getFirstEpisodeWinConditionText(arg_87_0, arg_87_1, arg_87_2)
	local var_87_0 = arg_87_0:getEpisodeCondition(arg_87_1, arg_87_2)

	if string.nilorempty(var_87_0) then
		return ""
	end

	local var_87_1 = GameUtil.splitString2(var_87_0, false, "|", "#")

	return arg_87_0:getWinConditionText(var_87_1[1]) or "winCondition error:" .. var_87_0
end

function var_0_0.getEpisodeWinConditionTextList(arg_88_0, arg_88_1)
	local var_88_0 = arg_88_0:getEpisodeCondition(arg_88_1)

	if string.nilorempty(var_88_0) then
		return {
			""
		}
	end

	local var_88_1 = {}
	local var_88_2 = GameUtil.splitString2(var_88_0, false, "|", "#")

	for iter_88_0, iter_88_1 in ipairs(var_88_2) do
		table.insert(var_88_1, arg_88_0:getWinConditionText(iter_88_1) or "winCondition error:" .. var_88_0)
	end

	return var_88_1
end

function var_0_0.getWinConditionText(arg_89_0, arg_89_1)
	if not arg_89_1 then
		return nil
	end

	local var_89_0 = tonumber(arg_89_1[1])

	if var_89_0 == 1 or var_89_0 == 10 then
		return luaLang("dungeon_beat_all")
	elseif var_89_0 == 2 then
		local var_89_1 = tonumber(arg_89_1[2])
		local var_89_2 = lua_monster.configDict[var_89_1]

		if var_89_2 then
			return formatLuaLang("dungeon_win_protect", string.format("<color=#ff0000>%s</color>", var_89_2.name))
		end
	elseif var_89_0 == 3 or var_89_0 == 9 then
		local var_89_3 = string.split(arg_89_1[2], "&")
		local var_89_4 = {}

		for iter_89_0, iter_89_1 in ipairs(var_89_3) do
			local var_89_5 = tonumber(iter_89_1)
			local var_89_6 = lua_monster.configDict[var_89_5]

			if var_89_6 then
				local var_89_7 = FightConfig.instance:getNewMonsterConfig(var_89_6) and var_89_6.highPriorityName or var_89_6.name

				table.insert(var_89_4, string.format("<color=#ff0000>%s</color>", var_89_7))
			end
		end

		if #var_89_4 > 0 then
			return formatLuaLang("dungeon_win_3", table.concat(var_89_4, luaLang("else")))
		end
	elseif var_89_0 == 4 then
		-- block empty
	elseif var_89_0 == 5 then
		local var_89_8 = tonumber(arg_89_1[2])
		local var_89_9 = lua_monster.configDict[var_89_8]

		if var_89_9 then
			local var_89_10 = {
				string.format("<color=#ff0000>%s</color>", var_89_9.name),
				tonumber(arg_89_1[3]) / 10 .. "%"
			}

			return (GameUtil.getSubPlaceholderLuaLang(luaLang("dungeon_win_5"), var_89_10))
		end
	elseif var_89_0 == 6 then
		return formatLuaLang("dungeon_win_6", arg_89_1[2])
	elseif var_89_0 == 7 then
		return luaLang("dungeon_beat_all_without_die")
	elseif var_89_0 == 8 then
		return formatLuaLang("dungeon_win_8", arg_89_1[3])
	elseif var_89_0 == 13 then
		local var_89_11 = tonumber(arg_89_1[2])
		local var_89_12 = lua_monster.configDict[var_89_11]

		if var_89_12 then
			return formatLuaLang("fight_charge_monster_energy", var_89_12.name)
		end
	end

	return nil
end

function var_0_0.getEpisodeAdvancedConditionText(arg_90_0, arg_90_1, arg_90_2)
	local var_90_0 = arg_90_0:getEpisodeAdvancedCondition(arg_90_1, arg_90_2)

	if LuaUtil.isEmptyStr(var_90_0) == false then
		local var_90_1 = string.splitToNumber(var_90_0, "|")[1]

		return lua_condition.configDict[var_90_1].desc
	else
		return ""
	end
end

function var_0_0.getEpisodeAdvancedCondition2Text(arg_91_0, arg_91_1, arg_91_2)
	local var_91_0 = arg_91_0:getEpisodeAdvancedCondition(arg_91_1, arg_91_2)

	if LuaUtil.isEmptyStr(var_91_0) == false then
		local var_91_1 = string.splitToNumber(var_91_0, "|")[2]

		if not var_91_1 then
			return ""
		end

		return lua_condition.configDict[var_91_1].desc
	else
		return ""
	end
end

function var_0_0.getEpisodeFailedReturnCost(arg_92_0, arg_92_1, arg_92_2)
	arg_92_2 = arg_92_2 or 1

	local var_92_0 = arg_92_0:getEpisodeCO(arg_92_1)

	if not var_92_0 then
		return 0
	end

	local var_92_1 = string.split(var_92_0.cost, "#")
	local var_92_2 = string.split(var_92_0.failCost, "#")

	if var_92_1[2] == var_92_2[2] and var_92_1[3] and var_92_2[3] then
		return arg_92_2 * var_92_1[3] - var_92_2[3]
	else
		return 0
	end
end

function var_0_0.getEndBattleCost(arg_93_0, arg_93_1, arg_93_2)
	local var_93_0 = arg_93_0:getEpisodeCO(arg_93_1)

	if not var_93_0 then
		return 0
	end

	if arg_93_2 then
		return string.split(var_93_0.failCost, "#")[3]
	else
		return string.split(var_93_0.cost, "#")[3]
	end
end

function var_0_0.getDungeonEveryDayCount(arg_94_0, arg_94_1)
	local var_94_0 = CommonConfig.instance:getConstStr(ConstEnum.DungeonMaxCount)
	local var_94_1 = GameUtil.splitString2(var_94_0, true, "|", "#")
	local var_94_2 = 0

	for iter_94_0, iter_94_1 in ipairs(var_94_1) do
		local var_94_3 = iter_94_1[1]
		local var_94_4 = iter_94_1[2]

		if var_94_3 == arg_94_1 then
			var_94_2 = var_94_4

			break
		end
	end

	return var_94_2
end

function var_0_0.getDungeonEveryDayItem(arg_95_0, arg_95_1)
	local var_95_0 = CommonConfig.instance:getConstStr(ConstEnum.DungeonItem)
	local var_95_1 = GameUtil.splitString2(var_95_0, true, "|", "#")
	local var_95_2 = 0

	for iter_95_0, iter_95_1 in ipairs(var_95_1) do
		local var_95_3 = iter_95_1[1]
		local var_95_4 = iter_95_1[2]

		if var_95_3 == arg_95_1 then
			var_95_2 = var_95_4

			break
		end
	end

	return var_95_2
end

function var_0_0.getPuzzleQuestionCo(arg_96_0, arg_96_1)
	return lua_chapter_puzzle_question.configDict[arg_96_1]
end

function var_0_0._initPuzzleSquare(arg_97_0, arg_97_1)
	arg_97_0._puzzle_square_data = {}

	for iter_97_0, iter_97_1 in pairs(arg_97_1.configDict) do
		if not arg_97_0._puzzle_square_data[iter_97_1.group] then
			arg_97_0._puzzle_square_data[iter_97_1.group] = {}
		end

		table.insert(arg_97_0._puzzle_square_data[iter_97_1.group], iter_97_1)
	end
end

function var_0_0.getPuzzleSquareDebrisGroupList(arg_98_0, arg_98_1)
	return arg_98_0._puzzle_square_data[arg_98_1]
end

function var_0_0.getPuzzleSquareData(arg_99_0, arg_99_1)
	return lua_chapter_puzzle_square.configDict[arg_99_1]
end

function var_0_0.getDecryptCo(arg_100_0, arg_100_1)
	return arg_100_0._decryptConfig.configDict[arg_100_1]
end

function var_0_0.getDecryptChangeColorCo(arg_101_0, arg_101_1)
	return arg_101_0._lvConfig.configDict[arg_101_1]
end

function var_0_0.getDecryptChangeColorInteractCos(arg_102_0)
	return arg_102_0._interactConfig.configDict
end

function var_0_0.getDecryptChangeColorInteractCo(arg_103_0, arg_103_1)
	return arg_103_0._interactConfig.configDict[arg_103_1]
end

function var_0_0.getDecryptChangeColorColorCos(arg_104_0)
	return arg_104_0._colorConfig.configDict
end

function var_0_0.getDecryptChangeColorColorCo(arg_105_0, arg_105_1)
	return arg_105_0._colorConfig.configDict[arg_105_1]
end

function var_0_0.isLeiMiTeBeiChapterType(arg_106_0, arg_106_1)
	if not arg_106_1 then
		return false
	end

	return arg_106_1.chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBei or arg_106_1.chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBeiHard or arg_106_1.chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBei3 or arg_106_1.chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBei4 or arg_106_1.chapterId == VersionActivityEnum.DungeonChapterId.ElementFight
end

function var_0_0.getElementFightEpisodeToNormalEpisodeId(arg_107_0, arg_107_1)
	for iter_107_0, iter_107_1 in ipairs(lua_chapter_map_element.configList) do
		if iter_107_1.type == 2 and iter_107_1.param == tostring(arg_107_1.id) then
			local var_107_0 = iter_107_1.mapId
			local var_107_1 = arg_107_0._chapterMapList[VersionActivityEnum.DungeonChapterId.LeiMiTeBei]

			for iter_107_2, iter_107_3 in pairs(var_107_1) do
				if iter_107_3.id == var_107_0 then
					local var_107_2 = var_0_0.instance:getChapterEpisodeCOList(VersionActivityEnum.DungeonChapterId.LeiMiTeBei)

					for iter_107_4, iter_107_5 in ipairs(var_107_2) do
						if iter_107_5.preEpisode == iter_107_2 then
							return iter_107_5.id
						end
					end
				end
			end
		end
	end

	return nil
end

function var_0_0.getActivityElementFightEpisodeToNormalEpisodeId(arg_108_0, arg_108_1, arg_108_2)
	for iter_108_0, iter_108_1 in ipairs(lua_chapter_map_element.configList) do
		if iter_108_1.type == 2 and tonumber(iter_108_1.param) == arg_108_1.id then
			local var_108_0 = iter_108_1.mapId
			local var_108_1 = arg_108_0._chapterMapList[arg_108_2]

			for iter_108_2, iter_108_3 in pairs(var_108_1) do
				if iter_108_3.id == var_108_0 then
					local var_108_2 = var_0_0.instance:getChapterEpisodeCOList(arg_108_2)

					for iter_108_4, iter_108_5 in ipairs(var_108_2) do
						if iter_108_5.preEpisode == iter_108_2 then
							return iter_108_5.id
						end
					end
				end
			end
		end
	end

	return nil
end

function var_0_0.isActivity1_2Map(arg_109_0, arg_109_1)
	local var_109_0 = var_0_0.instance:getEpisodeCO(arg_109_1)

	if var_109_0 then
		local var_109_1 = var_109_0.chapterId
		local var_109_2 = lua_chapter.configDict[var_109_1]

		if var_109_2 and (var_109_2.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal1 or var_109_2.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal2 or var_109_2.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal3 or var_109_2.type == DungeonEnum.ChapterType.Activity1_2DungeonHard) then
			return true
		end
	end
end

function var_0_0.getEpisodeLevelIndex(arg_110_0, arg_110_1)
	if not arg_110_1 then
		return 0
	end

	return arg_110_0:getEpisodeLevelIndexByEpisodeId(arg_110_1.id)
end

function var_0_0.getEpisodeLevelIndexByEpisodeId(arg_111_0, arg_111_1)
	if not arg_111_1 or type(arg_111_1) ~= "number" then
		return 0
	end

	return arg_111_1 % 100
end

function var_0_0.getExtendStory(arg_112_0, arg_112_1)
	if not arg_112_0._episodeExtendStoryDict then
		arg_112_0._episodeExtendStoryDict = {}

		local var_112_0 = lua_const.configDict[ConstEnum.EpisodeExtendStory]

		if var_112_0 and not string.nilorempty(var_112_0.value) then
			local var_112_1 = GameUtil.splitString2(var_112_0.value, true)

			for iter_112_0, iter_112_1 in ipairs(var_112_1) do
				arg_112_0._episodeExtendStoryDict[iter_112_1[1]] = {
					iter_112_1[2],
					iter_112_1[3]
				}
			end
		end
	end

	if not arg_112_0._episodeExtendStoryDict[arg_112_1] then
		return nil
	end

	local var_112_2, var_112_3 = unpack(arg_112_0._episodeExtendStoryDict[arg_112_1])

	if not var_112_2 or not DungeonMapModel.instance:elementIsFinished(var_112_2) then
		return nil
	end

	return var_112_3
end

function var_0_0.getSimpleEpisode(arg_113_0, arg_113_1)
	local var_113_0 = arg_113_1.chainEpisode

	if var_113_0 ~= 0 then
		return arg_113_0:getEpisodeCO(var_113_0)
	end
end

function var_0_0.getVersionActivityDungeonNormalEpisode(arg_114_0, arg_114_1, arg_114_2, arg_114_3)
	local var_114_0 = arg_114_0:getEpisodeCO(arg_114_1)

	if var_114_0.chapterId == arg_114_2 then
		arg_114_1 = arg_114_1 - 10000
		var_114_0 = arg_114_0:getEpisodeCO(arg_114_1)
	else
		while var_114_0.chapterId ~= arg_114_3 do
			var_114_0 = arg_114_0:getEpisodeCO(var_114_0.preEpisode)
		end
	end

	return var_114_0
end

function var_0_0.getEpisodeByElement(arg_115_0, arg_115_1)
	local var_115_0 = lua_chapter_map_element.configDict[arg_115_1]

	if not var_115_0 then
		return
	end

	local var_115_1 = var_115_0.mapId
	local var_115_2 = lua_chapter_map.configDict[var_115_1]

	return (arg_115_0:getEpisodeIdByMapCo(var_115_2))
end

function var_0_0.getRewardGroupCOList(arg_116_0, arg_116_1)
	return arg_116_0._rewardConfigDict[arg_116_1]
end

function var_0_0.calcRewardGroupRateInfoList(arg_117_0, arg_117_1)
	local var_117_0 = {}

	arg_117_0:_calcRewardGroupRateInfoList(var_117_0, arg_117_1)

	return var_117_0
end

function var_0_0._calcRewardGroupRateInfoList(arg_118_0, arg_118_1, arg_118_2)
	local var_118_0 = arg_118_0:getRewardGroupCOList(arg_118_2)

	if not var_118_0 or #var_118_0 == 0 then
		return
	end

	local var_118_1 = 0
	local var_118_2 = #arg_118_1

	for iter_118_0, iter_118_1 in ipairs(var_118_0) do
		local var_118_3 = tonumber(iter_118_1.count) or 0

		var_118_1 = var_118_1 + var_118_3

		table.insert(arg_118_1, {
			weight = var_118_3,
			materialType = iter_118_1.materialType,
			materialId = iter_118_1.materialId
		})
	end

	local var_118_4 = #arg_118_1

	for iter_118_2 = var_118_2 + 1, var_118_4 do
		local var_118_5 = arg_118_1[iter_118_2]

		var_118_5.rate = var_118_1 == 0 and 0 or var_118_5.weight / var_118_1
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
