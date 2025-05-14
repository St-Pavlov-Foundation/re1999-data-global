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

function var_0_0.getMapGuidepost(arg_6_0, arg_6_1)
	return arg_6_0._mapGuidepostDict[arg_6_1]
end

function var_0_0.getElementEpisode(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._elementFightList[arg_7_1]

	if not var_7_0 then
		return nil
	end

	local var_7_1 = var_7_0.mapId

	return arg_7_0._chapterMapEpisodeDic[var_7_1]
end

function var_0_0.getEpisodeIdByMapId(arg_8_0, arg_8_1)
	return arg_8_0._chapterMapEpisodeDic[arg_8_1]
end

function var_0_0.getDispatchCfg(arg_9_0, arg_9_1)
	local var_9_0

	if arg_9_1 then
		var_9_0 = lua_chapter_map_element_dispatch.configDict[arg_9_1]
	end

	if not var_9_0 then
		logError(string.format("DungeonConfig:getDispatchCfg error, cfg is nil, dispatchId: %s", arg_9_1))
	end

	return var_9_0
end

function var_0_0._initDialog(arg_10_0)
	if arg_10_0._dialogList then
		return
	end

	arg_10_0._dialogList = {}

	local var_10_0
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in ipairs(lua_chapter_map_element_dialog.configList) do
		local var_10_2 = arg_10_0._dialogList[iter_10_1.id]

		if not var_10_2 then
			var_10_2 = {}
			var_10_0 = var_10_1
			arg_10_0._dialogList[iter_10_1.id] = var_10_2
		end

		if iter_10_1.type == "selector" then
			var_10_0 = iter_10_1.param
		elseif iter_10_1.type == "selectorend" then
			var_10_0 = var_10_1
		else
			var_10_2[var_10_0] = var_10_2[var_10_0] or {}

			table.insert(var_10_2[var_10_0], iter_10_1)
		end
	end
end

function var_0_0.getDialog(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0._dialogList[arg_11_1]

	return var_11_0 and var_11_0[arg_11_2]
end

function var_0_0._initChapterDivide(arg_12_0)
	arg_12_0._chapterDivide = {}

	for iter_12_0, iter_12_1 in ipairs(lua_chapter_divide.configList) do
		for iter_12_2, iter_12_3 in ipairs(iter_12_1.chapterId) do
			arg_12_0._chapterDivide[iter_12_3] = iter_12_1.sectionId
		end
	end
end

function var_0_0.getChapterDivideSectionId(arg_13_0, arg_13_1)
	return arg_13_0._chapterDivide[arg_13_1]
end

function var_0_0._initChapterPointReward(arg_14_0)
	if arg_14_0._chapterPointReward then
		return
	end

	arg_14_0._chapterPointReward = {}

	for iter_14_0, iter_14_1 in ipairs(lua_chapter_point_reward.configList) do
		arg_14_0._chapterPointReward[iter_14_1.chapterId] = arg_14_0._chapterPointReward[iter_14_1.chapterId] or {}

		table.insert(arg_14_0._chapterPointReward[iter_14_1.chapterId], iter_14_1)
	end
end

function var_0_0.getChapterPointReward(arg_15_0, arg_15_1)
	return arg_15_0._chapterPointReward[arg_15_1]
end

function var_0_0._initChapterMap(arg_16_0)
	if arg_16_0._chapterMapList then
		return
	end

	arg_16_0._chapterMapList = {}
	arg_16_0._chapterMapEpisodeDic = {}

	for iter_16_0, iter_16_1 in ipairs(lua_chapter_map.configList) do
		arg_16_0._chapterMapList[iter_16_1.chapterId] = arg_16_0._chapterMapList[iter_16_1.chapterId] or {}

		if string.nilorempty(iter_16_1.unlockCondition) then
			arg_16_0._chapterMapList[iter_16_1.chapterId][0] = iter_16_1
		else
			local var_16_0 = string.gsub(iter_16_1.unlockCondition, "EpisodeFinish=", "")
			local var_16_1 = tonumber(var_16_0)

			arg_16_0._chapterMapList[iter_16_1.chapterId][var_16_1] = iter_16_1
		end
	end
end

function var_0_0._mapConnectEpisode(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._chapterMapList[arg_17_1.chapterId]

	if not var_17_0 then
		return
	end

	local var_17_1 = arg_17_1.preEpisode <= 0

	var_17_1 = var_17_1 or arg_17_0:getEpisodeCO(arg_17_1.preEpisode).chapterId ~= arg_17_1.chapterId

	local var_17_2 = var_17_0[var_17_1 and 0 or arg_17_1.preEpisode2]

	if not var_17_2 then
		return
	end

	arg_17_0._chapterMapEpisodeDic[var_17_2.id] = arg_17_1.id
end

function var_0_0.getChapterMapCfg(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0._chapterMapList[arg_18_1]
	local var_18_1 = var_18_0 and var_18_0[arg_18_2]

	if var_18_1 then
		return var_18_1
	end

	arg_18_2 = arg_18_0._backwardChainDict[arg_18_2]

	return var_18_0 and var_18_0[arg_18_2]
end

function var_0_0.getEpisodeIdByMapCo(arg_19_0, arg_19_1)
	if not arg_19_0._chapterMapList then
		return
	end

	local var_19_0 = arg_19_1.chapterId
	local var_19_1 = arg_19_0._chapterMapList[var_19_0]

	if not var_19_1 then
		return
	end

	for iter_19_0, iter_19_1 in pairs(var_19_1) do
		local var_19_2 = arg_19_0:getChapterMapCfg(var_19_0, iter_19_0)

		if var_19_2 and var_19_2.id == arg_19_1.id then
			local var_19_3 = arg_19_0:getChapterEpisodeCOList(var_19_0)

			for iter_19_2, iter_19_3 in ipairs(var_19_3) do
				if iter_19_3.preEpisode == iter_19_0 then
					return iter_19_3.id
				end
			end
		end
	end
end

function var_0_0.getChapterMapElement(arg_20_0, arg_20_1)
	return lua_chapter_map_element.configDict[arg_20_1]
end

function var_0_0.isDispatchElement(arg_21_0, arg_21_1)
	local var_21_0 = false
	local var_21_1 = arg_21_1 and arg_21_0:getChapterMapElement(arg_21_1)

	if var_21_1 then
		var_21_0 = var_21_1.type == DungeonEnum.ElementType.Dispatch
	end

	return var_21_0
end

function var_0_0.getElementDispatchId(arg_22_0, arg_22_1)
	local var_22_0

	if arg_22_0:isDispatchElement(arg_22_1) then
		local var_22_1 = arg_22_0:getChapterMapElement(arg_22_1)

		var_22_0 = var_22_1 and var_22_1.param or nil
	end

	return tonumber(var_22_0)
end

function var_0_0.getHardEpisode(arg_23_0, arg_23_1)
	if not arg_23_0._normalHardMap then
		arg_23_0._normalHardMap = {}

		for iter_23_0, iter_23_1 in ipairs(lua_episode.configList) do
			local var_23_0 = arg_23_0:getChapterCO(iter_23_1.chapterId)

			if var_23_0 and var_23_0.type == DungeonEnum.ChapterType.Hard then
				arg_23_0._normalHardMap[iter_23_1.preEpisode] = iter_23_1
			end
		end
	end

	return arg_23_0._normalHardMap[arg_23_1]
end

function var_0_0.getNormalEpisodeId(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:getEpisodeCO(arg_24_1)

	if arg_24_0:getChapterCO(var_24_0.chapterId).type == DungeonEnum.ChapterType.Simple then
		return var_24_0.normalEpisodeId
	else
		arg_24_0:getHardEpisode(arg_24_1)

		for iter_24_0, iter_24_1 in pairs(arg_24_0._normalHardMap) do
			if iter_24_1.id == arg_24_1 then
				return iter_24_0
			end
		end
	end

	return arg_24_1
end

function var_0_0.getChapterCOList(arg_25_0)
	return arg_25_0._chapterConfig.configList
end

function var_0_0.getFirstChapterCO(arg_26_0)
	return arg_26_0:getChapterCOList()[1]
end

function var_0_0.getChapterCOListByType(arg_27_0, arg_27_1)
	if arg_27_0._chapterListByType[arg_27_1] then
		return arg_27_0._chapterListByType[arg_27_1]
	end

	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(arg_27_0:getChapterCOList()) do
		if iter_27_1.type == arg_27_1 then
			table.insert(var_27_0, iter_27_1)
		end
	end

	arg_27_0._chapterListByType[arg_27_1] = var_27_0

	return var_27_0
end

function var_0_0.getChapterIndex(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0:getChapterCOListByType(arg_28_1)

	if var_28_0 then
		for iter_28_0, iter_28_1 in ipairs(var_28_0) do
			if iter_28_1.id == arg_28_2 then
				if arg_28_1 == DungeonEnum.ChapterType.Simple then
					return iter_28_0 + 3, #var_28_0
				end

				return iter_28_0, #var_28_0
			end
		end
	end

	return nil, nil
end

function var_0_0.episodeSortFunction(arg_29_0, arg_29_1)
	if not arg_29_0 and arg_29_1 then
		return true
	end

	if not arg_29_1 then
		return false
	end

	local var_29_0 = var_0_0.instance:getEpisodeCO(arg_29_0)
	local var_29_1 = var_0_0.instance:getEpisodeCO(arg_29_1)

	if not var_29_0 or not var_29_1 then
		return false
	end

	local var_29_2 = var_29_0.chapterId
	local var_29_3 = var_29_1.chapterId
	local var_29_4 = var_0_0.instance:getChapterCO(var_29_2)
	local var_29_5 = var_0_0.instance:getChapterCO(var_29_3)
	local var_29_6 = var_29_4.type
	local var_29_7 = var_29_5.type

	if (var_29_6 == DungeonEnum.ChapterType.Normal or var_29_6 == DungeonEnum.ChapterType.Hard) and (var_29_6 == DungeonEnum.ChapterType.Normal or var_29_6 == DungeonEnum.ChapterType.Hard) then
		local var_29_8 = var_0_0.instance:getChapterIndex(var_29_6, var_29_2)
		local var_29_9 = var_0_0.instance:getChapterIndex(var_29_7, var_29_3)

		if var_29_8 ~= var_29_9 then
			return var_29_8 < var_29_9
		elseif var_29_6 ~= var_29_7 then
			return var_29_6 == DungeonEnum.ChapterType.Normal
		else
			local var_29_10, var_29_11 = var_0_0.instance:getChapterEpisodeIndexWithSP(var_29_2, arg_29_0)
			local var_29_12, var_29_13 = var_0_0.instance:getChapterEpisodeIndexWithSP(var_29_3, arg_29_1)

			if var_29_11 ~= DungeonEnum.EpisodeType.Sp and var_29_13 == DungeonEnum.EpisodeType.Sp then
				return true
			else
				return var_29_10 < var_29_12
			end
		end
	elseif var_29_6 ~= var_29_7 then
		return var_29_6 < var_29_7
	else
		local var_29_14, var_29_15 = var_0_0.instance:getChapterEpisodeIndexWithSP(var_29_2, arg_29_0)
		local var_29_16, var_29_17 = var_0_0.instance:getChapterEpisodeIndexWithSP(var_29_3, arg_29_1)

		if var_29_15 ~= DungeonEnum.EpisodeType.Sp and var_29_17 == DungeonEnum.EpisodeType.Sp then
			return true
		else
			return var_29_14 < var_29_16
		end
	end
end

function var_0_0.getChapterFrontSpNum(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:getChapterCO(arg_30_1)
	local var_30_1 = 0

	if var_30_0 and var_30_0.preChapter > 0 then
		var_30_1 = var_30_1 + arg_30_0:getChapterFrontSpNum(var_30_0.preChapter)
		var_30_1 = var_30_1 + arg_30_0:getChapterSpNum(var_30_0.preChapter)
	end

	return var_30_1
end

function var_0_0.getChapterEpisodeIndexWithSP(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0:getChapterEpisodeCOList(arg_31_1)
	local var_31_1 = 0
	local var_31_2 = 0
	local var_31_3
	local var_31_4

	for iter_31_0, iter_31_1 in ipairs(var_31_0) do
		local var_31_5 = iter_31_1.type == DungeonEnum.EpisodeType.Sp

		var_31_4 = iter_31_1.type

		if var_31_5 then
			var_31_1 = var_31_1 + 1
			var_31_3 = var_31_1
		else
			var_31_2 = var_31_2 + 1
			var_31_3 = var_31_2
		end

		if iter_31_1.id == arg_31_2 then
			break
		end
	end

	if var_31_4 == DungeonEnum.EpisodeType.Sp then
		var_31_3 = var_31_3 + arg_31_0:getChapterFrontSpNum(arg_31_1)
	end

	return var_31_3, var_31_4
end

function var_0_0.getEpisodeIndex(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0:getEpisodeCO(arg_32_1)
	local var_32_1 = arg_32_0:getChapterEpisodeCOList(var_32_0.chapterId)
	local var_32_2 = 0

	for iter_32_0, iter_32_1 in ipairs(var_32_1) do
		var_32_2 = var_32_2 + 1

		if iter_32_1.id == arg_32_1 then
			break
		end
	end

	return var_32_2
end

function var_0_0.getEpisodeDisplay(arg_33_0, arg_33_1)
	if not arg_33_1 or arg_33_1 == 0 then
		return nil
	end

	local var_33_0 = arg_33_0:getEpisodeCO(arg_33_1)
	local var_33_1 = var_33_0 and arg_33_0:getChapterCO(var_33_0.chapterId)

	if not var_33_0 or not var_33_1 then
		return nil
	end

	local var_33_2 = var_33_1.chapterIndex
	local var_33_3, var_33_4 = arg_33_0:getChapterEpisodeIndexWithSP(var_33_1.id, var_33_0.id)

	if var_33_4 == DungeonEnum.EpisodeType.Sp then
		var_33_2 = "SP"
	end

	return string.format("%s-%s", var_33_2, var_33_3)
end

function var_0_0.getChapterCO(arg_34_0, arg_34_1)
	return arg_34_0._chapterConfig.configDict[arg_34_1]
end

function var_0_0.getEpisodeCO(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0._episodeConfig.configDict[arg_35_1]

	if not var_35_0 then
		logNormal("dungeon no episode:" .. tostring(arg_35_1))
	end

	return var_35_0
end

function var_0_0.getEpisodeAdditionRule(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0:getEpisodeBattleId(arg_36_1)
	local var_36_1 = var_36_0 and lua_battle.configDict[var_36_0]

	return var_36_1 and var_36_1.additionRule
end

function var_0_0.getBattleAdditionRule(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_1 and lua_battle.configDict[arg_37_1]

	return var_37_0 and var_37_0.additionRule
end

function var_0_0.getEpisodeAdvancedCondition(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_2 or arg_38_0:getEpisodeBattleId(arg_38_1)
	local var_38_1 = var_38_0 and lua_battle.configDict[var_38_0]

	return var_38_1 and var_38_1.advancedCondition
end

function var_0_0.getEpisodeAdvancedCondition2(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	local var_39_0 = arg_39_3 or arg_39_0:getEpisodeBattleId(arg_39_1)
	local var_39_1 = var_39_0 and lua_battle.configDict[var_39_0]
	local var_39_2 = var_39_1 and var_39_1.advancedCondition

	if not var_39_2 then
		return var_39_2
	end

	return string.splitToNumber(var_39_2, "|")[arg_39_2]
end

function var_0_0.getEpisodeCondition(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_2 or arg_40_0:getEpisodeBattleId(arg_40_1)
	local var_40_1 = lua_battle.configDict[var_40_0]

	if not var_40_1 then
		return ""
	else
		return var_40_1.winCondition
	end
end

function var_0_0.getBattleCo(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_2 or arg_41_0:getEpisodeBattleId(arg_41_1)

	return lua_battle.configDict[var_41_0]
end

function var_0_0.getEpisodeBattleId(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0:getEpisodeCO(arg_42_1)

	if not var_42_0 then
		return nil
	end

	local var_42_1 = var_42_0.firstBattleId

	if var_42_1 and var_42_1 > 0 then
		local var_42_2 = DungeonModel.instance:getEpisodeInfo(arg_42_1)

		if var_42_2 and var_42_2.star <= DungeonEnum.StarType.None then
			return var_42_1
		end

		if HeroGroupBalanceHelper.isClickBalance() then
			local var_42_3 = FightModel.instance:getFightParam()

			if var_42_3 and var_42_3.battleId == var_42_1 then
				return var_42_1
			end
		end
	end

	if FightModel.instance:getFightParam() then
		if var_42_0.type == DungeonEnum.EpisodeType.WeekWalk then
			return FightModel.instance:getFightParam().battleId
		elseif var_42_0.type == DungeonEnum.EpisodeType.Meilanni then
			return FightModel.instance:getFightParam().battleId
		elseif var_42_0.type == DungeonEnum.EpisodeType.Dog then
			return FightModel.instance:getFightParam().battleId
		elseif var_42_0.type == DungeonEnum.EpisodeType.Jiexika then
			return FightModel.instance:getFightParam().battleId
		elseif var_42_0.type == DungeonEnum.EpisodeType.YaXian then
			return FightModel.instance:getFightParam().battleId
		elseif var_42_0.type == DungeonEnum.EpisodeType.Explore then
			return FightModel.instance:getFightParam().battleId
		elseif var_42_0.type == DungeonEnum.EpisodeType.Act1_3Role2Chess then
			return FightModel.instance:getFightParam().battleId
		end
	end

	return var_42_0.battleId
end

function var_0_0.getBonusCO(arg_43_0, arg_43_1)
	return arg_43_0._bonusConfig.configDict[arg_43_1]
end

function var_0_0.isNewReward(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = lua_episode.configDict[arg_44_1]

	if not var_44_0 then
		return
	end

	if not lua_reward.configDict[var_44_0[arg_44_2]] then
		return
	end

	return true
end

function var_0_0.getRewardItems(arg_45_0, arg_45_1)
	local var_45_0 = lua_reward.configDict[arg_45_1]

	if not var_45_0 then
		return {}
	end

	arg_45_0._cacheRewardResults = arg_45_0._cacheRewardResults or {}

	if arg_45_0._cacheRewardResults[arg_45_1] then
		return arg_45_0._cacheRewardResults[arg_45_1]
	end

	local var_45_1 = {}
	local var_45_2 = {}

	for iter_45_0 = 1, math.huge do
		local var_45_3 = var_45_0["rewardGroup" .. iter_45_0]

		if not var_45_3 then
			break
		end

		local var_45_4 = string.match(var_45_3, "^(.+):")

		if var_45_4 then
			local var_45_5 = arg_45_0._rewardConfigDict[var_45_4]

			if var_45_5 then
				for iter_45_1, iter_45_2 in ipairs(var_45_5) do
					if iter_45_2.label ~= "none" then
						var_45_2[iter_45_2.materialType] = var_45_2[iter_45_2.materialType] or {}

						if not var_45_2[iter_45_2.materialType][iter_45_2.materialId] then
							var_45_2[iter_45_2.materialType][iter_45_2.materialId] = true

							table.insert(var_45_1, {
								iter_45_2.materialType,
								iter_45_2.materialId,
								iter_45_2.shownum == 1 and tonumber(iter_45_2.count) or 0,
								tagType = DungeonEnum.RewardProbability[iter_45_2.label]
							})
						end
					end
				end
			end
		end
	end

	table.sort(var_45_1, var_0_0._rewardSort)

	arg_45_0._cacheRewardResults[arg_45_1] = var_45_1

	return var_45_1
end

function var_0_0._rewardSort(arg_46_0, arg_46_1)
	local var_46_0 = ItemModel.instance:getItemConfig(arg_46_0[1], arg_46_0[2])
	local var_46_1 = ItemModel.instance:getItemConfig(arg_46_1[1], arg_46_1[2])

	if var_46_0.rare ~= var_46_1.rare then
		return var_46_0.rare > var_46_1.rare
	else
		return var_46_0.id > var_46_1.id
	end
end

function var_0_0.getMaterialSource(arg_47_0, arg_47_1, arg_47_2)
	if not arg_47_0._materialSourceDict then
		arg_47_0._materialSourceDict = {}

		for iter_47_0, iter_47_1 in ipairs(lua_episode.configList) do
			local var_47_0 = lua_chapter.configDict[iter_47_1.chapterId]

			if var_47_0 and (var_47_0.type == DungeonEnum.ChapterType.Normal or var_47_0.type == DungeonEnum.ChapterType.Hard or var_47_0.type == DungeonEnum.ChapterType.Simple) then
				local var_47_1 = iter_47_1.reward
				local var_47_2 = lua_reward.configDict[var_47_1]

				if var_47_2 then
					for iter_47_2 = 1, math.huge do
						local var_47_3 = var_47_2["rewardGroup" .. iter_47_2]

						if not var_47_3 then
							break
						end

						local var_47_4 = string.match(var_47_3, "^(.+):")

						if var_47_4 then
							local var_47_5 = arg_47_0._rewardConfigDict[var_47_4]

							if var_47_5 then
								for iter_47_3, iter_47_4 in ipairs(var_47_5) do
									if iter_47_4.label ~= "none" then
										if not arg_47_0._materialSourceDict[iter_47_4.materialType] then
											arg_47_0._materialSourceDict[iter_47_4.materialType] = {}
										end

										if not arg_47_0._materialSourceDict[iter_47_4.materialType][iter_47_4.materialId] then
											arg_47_0._materialSourceDict[iter_47_4.materialType][iter_47_4.materialId] = {}
										end

										if not tabletool.indexOf(arg_47_0._materialSourceDict[iter_47_4.materialType][iter_47_4.materialId], iter_47_1.id) then
											table.insert(arg_47_0._materialSourceDict[iter_47_4.materialType][iter_47_4.materialId], {
												episodeId = iter_47_1.id,
												probability = DungeonEnum.RewardProbabilityToMaterialProbability[iter_47_4.label]
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

	if not arg_47_0._materialSourceDict[arg_47_1] then
		return
	end

	return arg_47_0._materialSourceDict[arg_47_1][arg_47_2]
end

function var_0_0._initChapterList(arg_48_0)
	arg_48_0._normalChapterList = {}
	arg_48_0._exploreChapterList = {}
	arg_48_0._chapterUnlockMap = {}

	local var_48_0 = arg_48_0._chapterConfig.configList

	for iter_48_0, iter_48_1 in ipairs(var_48_0) do
		if iter_48_1.type == DungeonEnum.ChapterType.Normal then
			table.insert(arg_48_0._normalChapterList, iter_48_1)

			arg_48_0._chapterUnlockMap[iter_48_1.preChapter] = iter_48_1
		elseif iter_48_1.type == DungeonEnum.ChapterType.Explore then
			table.insert(arg_48_0._exploreChapterList, iter_48_1)
		end
	end
end

function var_0_0.getUnlockChapterConfig(arg_49_0, arg_49_1)
	return arg_49_0._chapterUnlockMap[arg_49_1]
end

function var_0_0.getNormalChapterList(arg_50_0)
	return arg_50_0._normalChapterList
end

function var_0_0.getExploreChapterList(arg_51_0)
	return arg_51_0._exploreChapterList
end

function var_0_0._rebuildEpisodeConfigs(arg_52_0)
	local var_52_0 = {
		preEpisode2 = "preEpisode",
		normalEpisodeId = "id"
	}
	local var_52_1 = {
		"beforeStory",
		"story",
		"afterStory"
	}
	local var_52_2 = {}
	local var_52_3 = {}
	local var_52_4 = getmetatable(lua_episode.configList[1])
	local var_52_5 = {
		__index = function(arg_53_0, arg_53_1)
			local var_53_0 = var_52_0[arg_53_1] or arg_53_1
			local var_53_1 = var_52_4.__index(arg_53_0, var_53_0)

			if arg_53_1 == "preEpisode" and var_53_1 > 0 or arg_53_1 == "normalEpisodeId" then
				return var_52_2[var_53_1] or var_53_1
			end

			if tabletool.indexOf(var_52_1, arg_53_1) then
				local var_53_2 = var_52_4.__index(arg_53_0, "chainEpisode")

				if var_53_2 > 0 and lua_episode.configDict[var_53_2] then
					return lua_episode.configDict[var_53_2][arg_53_1]
				end
			end

			return var_53_1
		end,
		__newindex = var_52_4.__newindex
	}

	for iter_52_0, iter_52_1 in ipairs(lua_episode.configList) do
		setmetatable(iter_52_1, var_52_5)

		if iter_52_1.chainEpisode > 0 then
			var_52_2[iter_52_1.chainEpisode] = iter_52_1.id
			var_52_3[iter_52_1.id] = iter_52_1.chainEpisode
		end
	end

	arg_52_0._chainEpisodeDict = var_52_2
	arg_52_0._backwardChainDict = var_52_3
end

function var_0_0._initEpisodeList(arg_54_0)
	arg_54_0._unlockEpisodeList = {}
	arg_54_0._chapterSpStats = {}
	arg_54_0._chapterEpisodeDict = {}
	arg_54_0._chpaterNonSpEpisodeDict = {}
	arg_54_0._episodeElementListDict = {}
	arg_54_0._episodeUnlockDict = {}

	local var_54_0 = arg_54_0._episodeConfig.configList

	for iter_54_0, iter_54_1 in ipairs(var_54_0) do
		local var_54_1 = arg_54_0._chapterEpisodeDict[iter_54_1.chapterId]

		if not var_54_1 then
			var_54_1 = {}
			arg_54_0._chapterEpisodeDict[iter_54_1.chapterId] = var_54_1
		end

		table.insert(var_54_1, iter_54_1)
		arg_54_0:_setEpisodeIndex(iter_54_1)

		if iter_54_1.preEpisode > 0 then
			if not string.nilorempty(iter_54_1.elementList) then
				arg_54_0._episodeElementListDict[iter_54_1.preEpisode] = iter_54_1.elementList
			end

			local var_54_2 = arg_54_0:getChapterCO(iter_54_1.chapterId)

			if var_54_2 and var_54_2.type ~= DungeonEnum.ChapterType.Hard then
				arg_54_0._episodeUnlockDict[iter_54_1.preEpisode] = iter_54_1.id
			end
		end

		if iter_54_1.unlockEpisode > 0 then
			local var_54_3 = arg_54_0._unlockEpisodeList[iter_54_1.unlockEpisode] or {}

			arg_54_0._unlockEpisodeList[iter_54_1.unlockEpisode] = var_54_3

			table.insert(var_54_3, iter_54_1.id)
		end

		if iter_54_1.type == DungeonEnum.EpisodeType.Sp then
			local var_54_4 = (arg_54_0._chapterSpStats[iter_54_1.chapterId] or 0) + 1

			arg_54_0._chapterSpStats[iter_54_1.chapterId] = var_54_4
		end

		arg_54_0:_mapConnectEpisode(iter_54_1)
	end
end

function var_0_0._initVersionActivityEpisodeList(arg_55_0)
	arg_55_0.versionActivityPreEpisodeDict = {}

	local var_55_0 = {
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
		VersionActivity2_5DungeonEnum.DungeonChapterId.Story3
	}
	local var_55_1

	for iter_55_0, iter_55_1 in ipairs(var_55_0) do
		local var_55_2 = arg_55_0._chapterEpisodeDict[iter_55_1]

		for iter_55_2, iter_55_3 in ipairs(var_55_2) do
			arg_55_0.versionActivityPreEpisodeDict[iter_55_3.preEpisode] = iter_55_3
		end
	end
end

function var_0_0.getVersionActivityEpisodeCoByPreEpisodeId(arg_56_0, arg_56_1)
	if not arg_56_0.versionActivityPreEpisodeDict then
		arg_56_0:_initVersionActivityEpisodeList()
	end

	return arg_56_0.versionActivityPreEpisodeDict[arg_56_1]
end

function var_0_0.getVersionActivityBrotherEpisodeByEpisodeCo(arg_57_0, arg_57_1)
	local var_57_0 = ActivityConfig.instance:getActIdByChapterId(arg_57_1.chapterId)

	if not var_57_0 then
		return {
			arg_57_1
		}
	end

	local var_57_1 = {}
	local var_57_2 = ActivityConfig.instance:getActivityDungeonConfig(var_57_0)

	while arg_57_1.chapterId ~= var_57_2.story1ChapterId do
		arg_57_1 = arg_57_0:getEpisodeCO(arg_57_1.preEpisode)
	end

	while arg_57_1 do
		table.insert(var_57_1, arg_57_1)

		arg_57_1 = arg_57_0:getVersionActivityEpisodeCoByPreEpisodeId(arg_57_1.id)
	end

	return var_57_1
end

function var_0_0._initVersionActivityEpisodeLevelList(arg_58_0, arg_58_1, arg_58_2)
	if not arg_58_0._versionActivityEpisodeLevelList then
		arg_58_0._versionActivityEpisodeLevelList = {}
	end

	local var_58_0 = {}

	while arg_58_2 ~= arg_58_1 do
		local var_58_1 = arg_58_0:getChapterEpisodeCOList(arg_58_2)

		for iter_58_0, iter_58_1 in ipairs(var_58_1) do
			var_58_0[iter_58_1.preEpisode] = iter_58_1.id
			arg_58_2 = arg_58_0:getEpisodeCO(iter_58_1.preEpisode).chapterId
		end
	end

	local var_58_2 = arg_58_0:getChapterEpisodeCOList(arg_58_1)

	for iter_58_2, iter_58_3 in ipairs(var_58_2) do
		arg_58_0._versionActivityEpisodeLevelList[iter_58_3.id] = {
			iter_58_3.id
		}

		if var_58_0[iter_58_3.id] then
			local var_58_3 = iter_58_3.id

			while var_58_0[var_58_3] do
				table.insert(arg_58_0._versionActivityEpisodeLevelList[iter_58_3.id], var_58_0[var_58_3])

				var_58_3 = var_58_0[var_58_3]
			end
		end
	end

	for iter_58_4, iter_58_5 in pairs(arg_58_0._versionActivityEpisodeLevelList) do
		if #iter_58_5 > 0 then
			for iter_58_6, iter_58_7 in ipairs(iter_58_5) do
				if iter_58_7 ~= iter_58_4 then
					arg_58_0._versionActivityEpisodeLevelList[iter_58_7] = iter_58_5
				end
			end
		end
	end
end

function var_0_0.get1_2VersionActivityEpisodeCoList(arg_59_0, arg_59_1)
	if arg_59_0._versionActivityEpisodeLevelList and arg_59_0._versionActivityEpisodeLevelList[arg_59_1] then
		return arg_59_0._versionActivityEpisodeLevelList[arg_59_1]
	end

	local var_59_0 = arg_59_0:getEpisodeCO(arg_59_1)
	local var_59_1 = VersionActivity1_2DungeonEnum.DungeonChapterId2StartChapterId[var_59_0.chapterId] or var_59_0.chapterId
	local var_59_2 = VersionActivity1_2DungeonEnum.DungeonChapterId2EndChapterId[var_59_0.chapterId] or var_59_0.chapterId

	arg_59_0:_initVersionActivityEpisodeLevelList(var_59_1, var_59_2)

	return arg_59_0._versionActivityEpisodeLevelList[arg_59_1]
end

function var_0_0.get1_2VersionActivityFirstLevelEpisodeId(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_0:getEpisodeCO(arg_60_1)
	local var_60_1 = var_60_0.chapterId

	if VersionActivity1_2DungeonEnum.DungeonChapterId2ViewShowId[var_60_1] then
		while VersionActivity1_2DungeonEnum.DungeonChapterId2ViewShowId[var_60_1] ~= var_60_1 do
			var_60_0 = var_0_0.instance:getEpisodeCO(var_60_0.preEpisode)
			var_60_1 = var_60_0.chapterId
		end
	end

	return var_60_0.id
end

function var_0_0.getElementList(arg_61_0, arg_61_1)
	return arg_61_0._episodeElementListDict[arg_61_1] or ""
end

function var_0_0.getUnlockEpisodeId(arg_62_0, arg_62_1)
	return arg_62_0._episodeUnlockDict[arg_62_1]
end

function var_0_0.getChapterSpNum(arg_63_0, arg_63_1)
	return arg_63_0._chapterSpStats[arg_63_1] or 0
end

function var_0_0.getUnlockEpisodeList(arg_64_0, arg_64_1)
	return arg_64_0._unlockEpisodeList[arg_64_1]
end

function var_0_0.getChapterEpisodeCOList(arg_65_0, arg_65_1)
	local var_65_0 = arg_65_0._chapterEpisodeDict[arg_65_1]

	if var_65_0 and not var_65_0._sort then
		var_65_0._sort = true

		table.sort(var_65_0, function(arg_66_0, arg_66_1)
			local var_66_0 = SLFramework.FrameworkSettings.IsEditor and {}
			local var_66_1 = SLFramework.FrameworkSettings.IsEditor and {}

			return arg_65_0:_getEpisodeIndex(arg_66_0, var_66_0) < arg_65_0:_getEpisodeIndex(arg_66_1, var_66_1)
		end)
	end

	return var_65_0
end

function var_0_0.getChapterNonSpEpisodeCOList(arg_67_0, arg_67_1)
	local var_67_0 = arg_67_0._chpaterNonSpEpisodeDict[arg_67_1]

	if not var_67_0 then
		var_67_0 = {}
		arg_67_0._chpaterNonSpEpisodeDict[arg_67_1] = var_67_0

		local var_67_1 = arg_67_0:getChapterEpisodeCOList(arg_67_1)

		for iter_67_0, iter_67_1 in ipairs(var_67_1) do
			if iter_67_1.type ~= DungeonEnum.EpisodeType.Sp then
				table.insert(var_67_0, iter_67_1)
			end
		end
	end

	return var_67_0
end

function var_0_0.getChapterLastNonSpEpisode(arg_68_0, arg_68_1)
	local var_68_0 = arg_68_0:getChapterNonSpEpisodeCOList(arg_68_1)

	return var_68_0 and var_68_0[#var_68_0]
end

function var_0_0._setEpisodeIndex(arg_69_0, arg_69_1)
	if arg_69_1.preEpisode > 0 then
		local var_69_0 = arg_69_0._episodeIndex[arg_69_1.preEpisode]

		if var_69_0 then
			arg_69_0._episodeIndex[arg_69_1.id] = var_69_0 + 1
		end
	else
		arg_69_0._episodeIndex[arg_69_1.id] = 0
	end
end

function var_0_0._getEpisodeIndex(arg_70_0, arg_70_1, arg_70_2)
	if arg_70_2 then
		arg_70_2[arg_70_1] = true
	end

	local var_70_0 = arg_70_0._episodeIndex[arg_70_1.id]

	if var_70_0 then
		return var_70_0
	end

	local var_70_1 = arg_70_0:getEpisodeCO(arg_70_1.preEpisode)

	if arg_70_2 and arg_70_2[var_70_1] then
		logError(string.format("_getEpisodeIndex: %s前置互相依赖了", var_70_1.id))

		return 0
	end

	local var_70_2 = arg_70_0:_getEpisodeIndex(var_70_1, arg_70_2) + 1

	arg_70_0._episodeIndex[arg_70_1.id] = var_70_2

	return var_70_2
end

function var_0_0.isPreChapterList(arg_71_0, arg_71_1, arg_71_2)
	if arg_71_1 == arg_71_2 then
		return false
	end

	local var_71_0 = arg_71_0:getChapterCO(arg_71_2)
	local var_71_1 = {}

	while var_71_0 and var_71_0.preChapter ~= 0 do
		if var_71_0.preChapter == arg_71_1 then
			return true
		end

		if var_71_1[var_71_0.preChapter] then
			break
		end

		var_71_1[var_71_0.preChapter] = true
		var_71_0 = arg_71_0:getChapterCO(var_71_0.preChapter)
	end

	return false
end

function var_0_0.isPreEpisodeList(arg_72_0, arg_72_1, arg_72_2)
	if arg_72_1 == arg_72_2 then
		return false
	end

	if arg_72_1 == 0 or arg_72_2 == 0 then
		return false
	end

	local var_72_0 = arg_72_0:getEpisodeCO(arg_72_1)
	local var_72_1 = arg_72_0:getEpisodeCO(arg_72_2)

	if not var_72_0 or not var_72_1 then
		return false
	end

	if arg_72_0:isPreChapterList(var_72_0.chapterId, var_72_1.chapterId) then
		return true
	end

	local var_72_2 = var_72_1
	local var_72_3 = {}

	while var_72_2 and var_72_2.preEpisode ~= 0 do
		if var_72_2.preEpisode == arg_72_1 then
			return true
		end

		if var_72_3[var_72_2.preEpisode] then
			break
		end

		var_72_3[var_72_2.preEpisode] = true
		var_72_2 = arg_72_0:getEpisodeCO(var_72_2.preEpisode)
	end

	return false
end

function var_0_0.getMonsterListFromGroupID(arg_73_0, arg_73_1)
	local var_73_0 = {}
	local var_73_1 = {}
	local var_73_2 = {}
	local var_73_3 = string.splitToNumber(arg_73_1, "#")

	for iter_73_0, iter_73_1 in ipairs(var_73_3) do
		local var_73_4 = lua_monster_group.configDict[iter_73_1]
		local var_73_5 = string.splitToNumber(var_73_4.monster, "#")
		local var_73_6 = var_73_4.bossId

		for iter_73_2, iter_73_3 in ipairs(var_73_5) do
			if iter_73_3 and lua_monster.configDict[iter_73_3] then
				local var_73_7 = lua_monster.configDict[iter_73_3]

				if var_73_7 then
					table.insert(var_73_0, var_73_7)

					if FightHelper.isBossId(var_73_6, iter_73_3) then
						table.insert(var_73_2, var_73_7)
					else
						table.insert(var_73_1, var_73_7)
					end
				end
			end
		end
	end

	return var_73_0, var_73_1, var_73_2
end

function var_0_0.getCareersFromBattle(arg_74_0, arg_74_1)
	local var_74_0 = {}
	local var_74_1 = 0
	local var_74_2 = lua_battle.configDict[arg_74_1]

	if var_74_2 then
		local var_74_3 = {}
		local var_74_4, var_74_5, var_74_6 = arg_74_0:getMonsterListFromGroupID(var_74_2.monsterGroupIds)

		table.sort(var_74_5, function(arg_75_0, arg_75_1)
			return arg_75_0.level < arg_75_1.level
		end)
		table.sort(var_74_6, function(arg_76_0, arg_76_1)
			return arg_76_0.level < arg_76_1.level
		end)

		for iter_74_0, iter_74_1 in ipairs(var_74_5) do
			var_74_1 = var_74_1 + 1

			if not var_74_3[iter_74_1.career] then
				var_74_3[iter_74_1.career] = {}
			end

			var_74_3[iter_74_1.career].score = var_74_1
			var_74_3[iter_74_1.career].isBoss = false
		end

		for iter_74_2, iter_74_3 in ipairs(var_74_6) do
			var_74_1 = var_74_1 + 1

			if not var_74_3[iter_74_3.career] then
				var_74_3[iter_74_3.career] = {}
			end

			var_74_3[iter_74_3.career].score = var_74_1
			var_74_3[iter_74_3.career].isBoss = true
		end

		for iter_74_4, iter_74_5 in pairs(var_74_3) do
			local var_74_7 = {
				career = iter_74_4,
				score = iter_74_5.score,
				isBoss = iter_74_5.isBoss
			}

			table.insert(var_74_0, var_74_7)
		end

		table.sort(var_74_0, function(arg_77_0, arg_77_1)
			return arg_77_0.score < arg_77_1.score
		end)
	end

	return var_74_0
end

function var_0_0.getBossMonsterIdDict(arg_78_0, arg_78_1)
	local var_78_0 = {}

	if arg_78_1 then
		local var_78_1, var_78_2, var_78_3 = arg_78_0:getMonsterListFromGroupID(arg_78_1.monsterGroupIds)

		if var_78_3 then
			for iter_78_0 = 1, #var_78_3 do
				var_78_0[var_78_3[iter_78_0].id] = true
			end
		end
	end

	return var_78_0
end

function var_0_0.getBattleDisplayMonsterIds(arg_79_0, arg_79_1)
	local var_79_0 = {}
	local var_79_1 = {}
	local var_79_2 = string.splitToNumber(arg_79_1.monsterGroupIds, "#")

	for iter_79_0 = #var_79_2, 1, -1 do
		local var_79_3 = var_79_2[iter_79_0]
		local var_79_4 = lua_monster_group.configDict[var_79_3]
		local var_79_5 = string.splitToNumber(var_79_4.monster, "#")
		local var_79_6 = var_79_4.bossId
		local var_79_7 = 100
		local var_79_8 = {}

		for iter_79_1, iter_79_2 in ipairs(var_79_5) do
			if FightHelper.isBossId(var_79_6, iter_79_2) then
				var_79_7 = iter_79_1
			end
		end

		for iter_79_3, iter_79_4 in ipairs(var_79_5) do
			if iter_79_4 and lua_monster.configDict[iter_79_4] then
				local var_79_9 = {
					id = iter_79_4,
					distance = math.abs(iter_79_3 - var_79_7)
				}

				table.insert(var_79_8, var_79_9)
			end
		end

		table.sort(var_79_8, function(arg_80_0, arg_80_1)
			return arg_80_0.distance < arg_80_1.distance
		end)

		for iter_79_5, iter_79_6 in ipairs(var_79_8) do
			if not var_79_1[iter_79_6.id] then
				var_79_1[iter_79_6.id] = true

				table.insert(var_79_0, iter_79_6.id)
			end
		end
	end

	for iter_79_7, iter_79_8 in ipairs(var_79_2) do
		local var_79_10 = lua_monster_group.configDict[iter_79_8]
		local var_79_11 = string.nilorempty(var_79_10.spMonster) and {} or string.split(var_79_10.spMonster, "#")

		for iter_79_9, iter_79_10 in ipairs(var_79_11) do
			if not var_79_1[iter_79_10] then
				var_79_1[iter_79_10] = true

				table.insert(var_79_0, tonumber(iter_79_10))
			end
		end
	end

	return var_79_0
end

function var_0_0.getNormalChapterId(arg_81_0, arg_81_1)
	local var_81_0 = arg_81_0:getEpisodeCO(arg_81_1)
	local var_81_1 = arg_81_0:getChapterCO(var_81_0.chapterId)

	if var_81_1.type == DungeonEnum.ChapterType.Hard then
		local var_81_2 = arg_81_0:getEpisodeCO(var_81_0.preEpisode)

		var_81_1 = arg_81_0:getChapterCO(var_81_2.chapterId)
	end

	return var_81_1.id
end

function var_0_0.getChapterTypeByEpisodeId(arg_82_0, arg_82_1)
	local var_82_0 = arg_82_0:getEpisodeCO(arg_82_1)

	return arg_82_0:getChapterCO(var_82_0.chapterId).type
end

function var_0_0.getFirstEpisodeWinConditionText(arg_83_0, arg_83_1, arg_83_2)
	local var_83_0 = arg_83_0:getEpisodeCondition(arg_83_1, arg_83_2)

	if string.nilorempty(var_83_0) then
		return ""
	end

	local var_83_1 = GameUtil.splitString2(var_83_0, false, "|", "#")

	return arg_83_0:getWinConditionText(var_83_1[1]) or "winCondition error:" .. var_83_0
end

function var_0_0.getEpisodeWinConditionTextList(arg_84_0, arg_84_1)
	local var_84_0 = arg_84_0:getEpisodeCondition(arg_84_1)

	if string.nilorempty(var_84_0) then
		return {
			""
		}
	end

	local var_84_1 = {}
	local var_84_2 = GameUtil.splitString2(var_84_0, false, "|", "#")

	for iter_84_0, iter_84_1 in ipairs(var_84_2) do
		table.insert(var_84_1, arg_84_0:getWinConditionText(iter_84_1) or "winCondition error:" .. var_84_0)
	end

	return var_84_1
end

function var_0_0.getWinConditionText(arg_85_0, arg_85_1)
	if not arg_85_1 then
		return nil
	end

	local var_85_0 = tonumber(arg_85_1[1])

	if var_85_0 == 1 or var_85_0 == 10 then
		return luaLang("dungeon_beat_all")
	elseif var_85_0 == 2 then
		local var_85_1 = tonumber(arg_85_1[2])
		local var_85_2 = lua_monster.configDict[var_85_1]

		if var_85_2 then
			return formatLuaLang("dungeon_win_protect", string.format("<color=#ff0000>%s</color>", var_85_2.name))
		end
	elseif var_85_0 == 3 or var_85_0 == 9 then
		local var_85_3 = string.split(arg_85_1[2], "&")
		local var_85_4 = {}

		for iter_85_0, iter_85_1 in ipairs(var_85_3) do
			local var_85_5 = tonumber(iter_85_1)
			local var_85_6 = lua_monster.configDict[var_85_5]

			if var_85_6 then
				local var_85_7 = FightConfig.instance:getNewMonsterConfig(var_85_6) and var_85_6.highPriorityName or var_85_6.name

				table.insert(var_85_4, string.format("<color=#ff0000>%s</color>", var_85_7))
			end
		end

		if #var_85_4 > 0 then
			return formatLuaLang("dungeon_win_3", table.concat(var_85_4, luaLang("else")))
		end
	elseif var_85_0 == 4 then
		-- block empty
	elseif var_85_0 == 5 then
		local var_85_8 = tonumber(arg_85_1[2])
		local var_85_9 = lua_monster.configDict[var_85_8]

		if var_85_9 then
			local var_85_10 = {
				string.format("<color=#ff0000>%s</color>", var_85_9.name),
				tonumber(arg_85_1[3]) / 10 .. "%"
			}

			return (GameUtil.getSubPlaceholderLuaLang(luaLang("dungeon_win_5"), var_85_10))
		end
	elseif var_85_0 == 6 then
		return formatLuaLang("dungeon_win_6", arg_85_1[2])
	elseif var_85_0 == 7 then
		return luaLang("dungeon_beat_all_without_die")
	elseif var_85_0 == 8 then
		return formatLuaLang("dungeon_win_8", arg_85_1[3])
	elseif var_85_0 == 13 then
		local var_85_11 = tonumber(arg_85_1[2])
		local var_85_12 = lua_monster.configDict[var_85_11]

		if var_85_12 then
			return formatLuaLang("fight_charge_monster_energy", var_85_12.name)
		end
	end

	return nil
end

function var_0_0.getEpisodeAdvancedConditionText(arg_86_0, arg_86_1, arg_86_2)
	local var_86_0 = arg_86_0:getEpisodeAdvancedCondition(arg_86_1, arg_86_2)

	if LuaUtil.isEmptyStr(var_86_0) == false then
		local var_86_1 = string.splitToNumber(var_86_0, "|")[1]

		return lua_condition.configDict[var_86_1].desc
	else
		return ""
	end
end

function var_0_0.getEpisodeAdvancedCondition2Text(arg_87_0, arg_87_1, arg_87_2)
	local var_87_0 = arg_87_0:getEpisodeAdvancedCondition(arg_87_1, arg_87_2)

	if LuaUtil.isEmptyStr(var_87_0) == false then
		local var_87_1 = string.splitToNumber(var_87_0, "|")[2]

		if not var_87_1 then
			return ""
		end

		return lua_condition.configDict[var_87_1].desc
	else
		return ""
	end
end

function var_0_0.getEpisodeFailedReturnCost(arg_88_0, arg_88_1, arg_88_2)
	arg_88_2 = arg_88_2 or 1

	local var_88_0 = arg_88_0:getEpisodeCO(arg_88_1)

	if not var_88_0 then
		return 0
	end

	local var_88_1 = string.split(var_88_0.cost, "#")
	local var_88_2 = string.split(var_88_0.failCost, "#")

	if var_88_1[2] == var_88_2[2] and var_88_1[3] and var_88_2[3] then
		return arg_88_2 * var_88_1[3] - var_88_2[3]
	else
		return 0
	end
end

function var_0_0.getEndBattleCost(arg_89_0, arg_89_1, arg_89_2)
	local var_89_0 = arg_89_0:getEpisodeCO(arg_89_1)

	if not var_89_0 then
		return 0
	end

	if arg_89_2 then
		return string.split(var_89_0.failCost, "#")[3]
	else
		return string.split(var_89_0.cost, "#")[3]
	end
end

function var_0_0.getDungeonEveryDayCount(arg_90_0, arg_90_1)
	local var_90_0 = CommonConfig.instance:getConstStr(ConstEnum.DungeonMaxCount)
	local var_90_1 = GameUtil.splitString2(var_90_0, true, "|", "#")
	local var_90_2 = 0

	for iter_90_0, iter_90_1 in ipairs(var_90_1) do
		local var_90_3 = iter_90_1[1]
		local var_90_4 = iter_90_1[2]

		if var_90_3 == arg_90_1 then
			var_90_2 = var_90_4

			break
		end
	end

	return var_90_2
end

function var_0_0.getDungeonEveryDayItem(arg_91_0, arg_91_1)
	local var_91_0 = CommonConfig.instance:getConstStr(ConstEnum.DungeonItem)
	local var_91_1 = GameUtil.splitString2(var_91_0, true, "|", "#")
	local var_91_2 = 0

	for iter_91_0, iter_91_1 in ipairs(var_91_1) do
		local var_91_3 = iter_91_1[1]
		local var_91_4 = iter_91_1[2]

		if var_91_3 == arg_91_1 then
			var_91_2 = var_91_4

			break
		end
	end

	return var_91_2
end

function var_0_0.getPuzzleQuestionCo(arg_92_0, arg_92_1)
	return lua_chapter_puzzle_question.configDict[arg_92_1]
end

function var_0_0._initPuzzleSquare(arg_93_0, arg_93_1)
	arg_93_0._puzzle_square_data = {}

	for iter_93_0, iter_93_1 in pairs(arg_93_1.configDict) do
		if not arg_93_0._puzzle_square_data[iter_93_1.group] then
			arg_93_0._puzzle_square_data[iter_93_1.group] = {}
		end

		table.insert(arg_93_0._puzzle_square_data[iter_93_1.group], iter_93_1)
	end
end

function var_0_0.getPuzzleSquareDebrisGroupList(arg_94_0, arg_94_1)
	return arg_94_0._puzzle_square_data[arg_94_1]
end

function var_0_0.getPuzzleSquareData(arg_95_0, arg_95_1)
	return lua_chapter_puzzle_square.configDict[arg_95_1]
end

function var_0_0.getDecryptCo(arg_96_0, arg_96_1)
	return arg_96_0._decryptConfig.configDict[arg_96_1]
end

function var_0_0.getDecryptChangeColorCo(arg_97_0, arg_97_1)
	return arg_97_0._lvConfig.configDict[arg_97_1]
end

function var_0_0.getDecryptChangeColorInteractCos(arg_98_0)
	return arg_98_0._interactConfig.configDict
end

function var_0_0.getDecryptChangeColorInteractCo(arg_99_0, arg_99_1)
	return arg_99_0._interactConfig.configDict[arg_99_1]
end

function var_0_0.getDecryptChangeColorColorCos(arg_100_0)
	return arg_100_0._colorConfig.configDict
end

function var_0_0.getDecryptChangeColorColorCo(arg_101_0, arg_101_1)
	return arg_101_0._colorConfig.configDict[arg_101_1]
end

function var_0_0.isLeiMiTeBeiChapterType(arg_102_0, arg_102_1)
	if not arg_102_1 then
		return false
	end

	return arg_102_1.chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBei or arg_102_1.chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBeiHard or arg_102_1.chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBei3 or arg_102_1.chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBei4 or arg_102_1.chapterId == VersionActivityEnum.DungeonChapterId.ElementFight
end

function var_0_0.getElementFightEpisodeToNormalEpisodeId(arg_103_0, arg_103_1)
	for iter_103_0, iter_103_1 in ipairs(lua_chapter_map_element.configList) do
		if iter_103_1.type == 2 and iter_103_1.param == tostring(arg_103_1.id) then
			local var_103_0 = iter_103_1.mapId
			local var_103_1 = arg_103_0._chapterMapList[VersionActivityEnum.DungeonChapterId.LeiMiTeBei]

			for iter_103_2, iter_103_3 in pairs(var_103_1) do
				if iter_103_3.id == var_103_0 then
					local var_103_2 = var_0_0.instance:getChapterEpisodeCOList(VersionActivityEnum.DungeonChapterId.LeiMiTeBei)

					for iter_103_4, iter_103_5 in ipairs(var_103_2) do
						if iter_103_5.preEpisode == iter_103_2 then
							return iter_103_5.id
						end
					end
				end
			end
		end
	end

	return nil
end

function var_0_0.getActivityElementFightEpisodeToNormalEpisodeId(arg_104_0, arg_104_1, arg_104_2)
	for iter_104_0, iter_104_1 in ipairs(lua_chapter_map_element.configList) do
		if iter_104_1.type == 2 and tonumber(iter_104_1.param) == arg_104_1.id then
			local var_104_0 = iter_104_1.mapId
			local var_104_1 = arg_104_0._chapterMapList[arg_104_2]

			for iter_104_2, iter_104_3 in pairs(var_104_1) do
				if iter_104_3.id == var_104_0 then
					local var_104_2 = var_0_0.instance:getChapterEpisodeCOList(arg_104_2)

					for iter_104_4, iter_104_5 in ipairs(var_104_2) do
						if iter_104_5.preEpisode == iter_104_2 then
							return iter_104_5.id
						end
					end
				end
			end
		end
	end

	return nil
end

function var_0_0.isActivity1_2Map(arg_105_0, arg_105_1)
	local var_105_0 = var_0_0.instance:getEpisodeCO(arg_105_1)

	if var_105_0 then
		local var_105_1 = var_105_0.chapterId
		local var_105_2 = lua_chapter.configDict[var_105_1]

		if var_105_2 and (var_105_2.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal1 or var_105_2.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal2 or var_105_2.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal3 or var_105_2.type == DungeonEnum.ChapterType.Activity1_2DungeonHard) then
			return true
		end
	end
end

function var_0_0.getEpisodeLevelIndex(arg_106_0, arg_106_1)
	if not arg_106_1 then
		return 0
	end

	return arg_106_0:getEpisodeLevelIndexByEpisodeId(arg_106_1.id)
end

function var_0_0.getEpisodeLevelIndexByEpisodeId(arg_107_0, arg_107_1)
	if not arg_107_1 or type(arg_107_1) ~= "number" then
		return 0
	end

	return arg_107_1 % 100
end

function var_0_0.getExtendStory(arg_108_0, arg_108_1)
	if not arg_108_0._episodeExtendStoryDict then
		arg_108_0._episodeExtendStoryDict = {}

		local var_108_0 = lua_const.configDict[ConstEnum.EpisodeExtendStory]

		if var_108_0 and not string.nilorempty(var_108_0.value) then
			local var_108_1 = GameUtil.splitString2(var_108_0.value, true)

			for iter_108_0, iter_108_1 in ipairs(var_108_1) do
				arg_108_0._episodeExtendStoryDict[iter_108_1[1]] = {
					iter_108_1[2],
					iter_108_1[3]
				}
			end
		end
	end

	if not arg_108_0._episodeExtendStoryDict[arg_108_1] then
		return nil
	end

	local var_108_2, var_108_3 = unpack(arg_108_0._episodeExtendStoryDict[arg_108_1])

	if not var_108_2 or not DungeonMapModel.instance:elementIsFinished(var_108_2) then
		return nil
	end

	return var_108_3
end

function var_0_0.getSimpleEpisode(arg_109_0, arg_109_1)
	local var_109_0 = arg_109_1.chainEpisode

	if var_109_0 ~= 0 then
		return arg_109_0:getEpisodeCO(var_109_0)
	end
end

function var_0_0.getVersionActivityDungeonNormalEpisode(arg_110_0, arg_110_1, arg_110_2, arg_110_3)
	local var_110_0 = arg_110_0:getEpisodeCO(arg_110_1)

	if var_110_0.chapterId == arg_110_2 then
		arg_110_1 = arg_110_1 - 10000
		var_110_0 = arg_110_0:getEpisodeCO(arg_110_1)
	else
		while var_110_0.chapterId ~= arg_110_3 do
			var_110_0 = arg_110_0:getEpisodeCO(var_110_0.preEpisode)
		end
	end

	return var_110_0
end

function var_0_0.getEpisodeByElement(arg_111_0, arg_111_1)
	local var_111_0 = lua_chapter_map_element.configDict[arg_111_1]

	if not var_111_0 then
		return
	end

	local var_111_1 = var_111_0.mapId
	local var_111_2 = lua_chapter_map.configDict[var_111_1]

	return (arg_111_0:getEpisodeIdByMapCo(var_111_2))
end

function var_0_0.getRewardGroupCOList(arg_112_0, arg_112_1)
	return arg_112_0._rewardConfigDict[arg_112_1]
end

function var_0_0.calcRewardGroupRateInfoList(arg_113_0, arg_113_1)
	local var_113_0 = {}

	arg_113_0:_calcRewardGroupRateInfoList(var_113_0, arg_113_1)

	return var_113_0
end

function var_0_0._calcRewardGroupRateInfoList(arg_114_0, arg_114_1, arg_114_2)
	local var_114_0 = arg_114_0:getRewardGroupCOList(arg_114_2)

	if not var_114_0 or #var_114_0 == 0 then
		return
	end

	local var_114_1 = 0
	local var_114_2 = #arg_114_1

	for iter_114_0, iter_114_1 in ipairs(var_114_0) do
		local var_114_3 = tonumber(iter_114_1.count) or 0

		var_114_1 = var_114_1 + var_114_3

		table.insert(arg_114_1, {
			weight = var_114_3,
			materialType = iter_114_1.materialType,
			materialId = iter_114_1.materialId
		})
	end

	local var_114_4 = #arg_114_1

	for iter_114_2 = var_114_2 + 1, var_114_4 do
		local var_114_5 = arg_114_1[iter_114_2]

		var_114_5.rate = var_114_1 == 0 and 0 or var_114_5.weight / var_114_1
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
