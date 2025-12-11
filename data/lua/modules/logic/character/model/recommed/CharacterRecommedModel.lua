module("modules.logic.character.model.recommed.CharacterRecommedModel", package.seeall)

local var_0_0 = class("CharacterRecommedModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.initMO(arg_3_0, arg_3_1)
	arg_3_0._heroRecommendMos = {}

	if not arg_3_1 then
		return
	end

	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		local var_3_0 = CharacterRecommedMO.New()

		var_3_0:init(iter_3_1)

		arg_3_0._heroRecommendMos[iter_3_0] = var_3_0
	end
end

function var_0_0.getAllHeroRecommendMos(arg_4_0)
	return arg_4_0._heroRecommendMos
end

function var_0_0.isShowRecommedView(arg_5_0, arg_5_1)
	return arg_5_0:getHeroRecommendMo(arg_5_1) ~= nil
end

function var_0_0.getHeroRecommendMo(arg_6_0, arg_6_1)
	if not arg_6_0._heroRecommendMos then
		return
	end

	return arg_6_0._heroRecommendMos[arg_6_1]
end

function var_0_0.initTracedHeroDevelopGoalsMO(arg_7_0)
	local var_7_0 = GameUtil.playerPrefsGetStringByUserId(CharacterRecommedEnum.TraceHeroPref, "")

	if string.nilorempty(var_7_0) then
		arg_7_0._heroDevelopGoalsMO = nil
	else
		local var_7_1 = string.splitToNumber(var_7_0, "_")
		local var_7_2 = var_7_1[1]
		local var_7_3 = var_7_1[2]
		local var_7_4 = arg_7_0:getHeroRecommendMo(var_7_2)
		local var_7_5 = var_7_4 and var_7_4:getDevelopGoalsMO(var_7_3)

		if var_7_5 then
			var_7_5:setTraced(true)
		end

		arg_7_0._heroDevelopGoalsMO = var_7_5
	end
end

function var_0_0.getTracedHeroDevelopGoalsMO(arg_8_0)
	return arg_8_0._heroDevelopGoalsMO
end

function var_0_0.setTracedHeroDevelopGoalsMO(arg_9_0, arg_9_1)
	if arg_9_0._heroDevelopGoalsMO == arg_9_1 then
		return
	end

	if arg_9_0._heroDevelopGoalsMO then
		arg_9_0._heroDevelopGoalsMO:setTraced(false)
	end

	arg_9_0._heroDevelopGoalsMO = arg_9_1

	local var_9_0 = arg_9_1 and string.format("%s_%s", arg_9_1._heroId, arg_9_1._developGoalsType) or ""

	GameUtil.playerPrefsSetStringByUserId(CharacterRecommedEnum.TraceHeroPref, var_9_0)
	CharacterRecommedController.instance:dispatchEvent(CharacterRecommedEvent.OnRefreshTraced)
end

function var_0_0.isTradeChapter(arg_10_0, arg_10_1)
	if arg_10_0:getChapterTracedItem(arg_10_1) then
		return true
	end

	return arg_10_0:getChapterTradeEpisodeId(arg_10_1) ~= nil
end

function var_0_0.isTradeEpisode(arg_11_0, arg_11_1)
	if arg_11_0:getEpisodeTracedItem(arg_11_1) then
		return true
	end

	local var_11_0 = DungeonConfig.instance:getHardEpisode(arg_11_1)

	if var_11_0 and arg_11_0:getEpisodeTracedItem(var_11_0.id) then
		return true
	end

	return false
end

function var_0_0.getEpisodeOrChapterTracedItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getEpisodeTracedItem(arg_12_1)

	if not var_12_0 then
		local var_12_1 = DungeonConfig.instance:getEpisodeCO(arg_12_1)

		var_12_0 = arg_12_0:getChapterTracedItem(var_12_1.chapterId)
	end

	return var_12_0
end

function var_0_0.getChapterTracedItem(arg_13_0, arg_13_1)
	if not arg_13_0._heroDevelopGoalsMO then
		return
	end

	local var_13_0 = arg_13_0._heroDevelopGoalsMO:getTracedItems()

	if not var_13_0 or #var_13_0 == 0 then
		return
	end

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_1 = arg_13_0:getBestSource(iter_13_1.materilType, iter_13_1.materilId)

		if var_13_1 and var_13_1.chapterId == arg_13_1 then
			return iter_13_1
		end
	end
end

function var_0_0.getEpisodeTracedItem(arg_14_0, arg_14_1)
	if not arg_14_0._heroDevelopGoalsMO then
		return
	end

	local var_14_0 = arg_14_0._heroDevelopGoalsMO:getTracedItems()

	if not var_14_0 or #var_14_0 == 0 then
		return
	end

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_1 = arg_14_0:getBestSource(iter_14_1.materilType, iter_14_1.materilId)

		if var_14_1 and var_14_1.episodeId == arg_14_1 then
			return iter_14_1
		end
	end
end

function var_0_0.getChapterTradeEpisodeId(arg_15_0, arg_15_1)
	local var_15_0 = DungeonConfig.instance:getChapterEpisodeCOList(arg_15_1)

	if var_15_0 then
		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			if arg_15_0:isTradeEpisode(iter_15_1.id) then
				return iter_15_1.id
			end
		end
	end
end

function var_0_0._getItemSourceList(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0._itemSourceDict then
		arg_16_0._itemSourceDict = {}
	end

	if not arg_16_0._itemSourceDict[arg_16_1] then
		arg_16_0._itemSourceDict[arg_16_1] = {}
	end

	local var_16_0 = arg_16_0._itemSourceDict[arg_16_1][arg_16_2]

	if not var_16_0 then
		var_16_0 = DungeonConfig.instance:getMaterialSource(arg_16_1, arg_16_2) or {}

		local var_16_1 = ItemConfig.instance:getItemConfig(arg_16_1, arg_16_2)

		if not string.nilorempty(var_16_1.sources) then
			local var_16_2 = string.split(var_16_1.sources, "|")

			for iter_16_0, iter_16_1 in ipairs(var_16_2) do
				local var_16_3 = string.splitToNumber(iter_16_1, "#")
				local var_16_4 = {}
				local var_16_5 = var_16_3[1]

				if var_16_5 then
					local var_16_6 = JumpConfig.instance:getJumpConfig(var_16_5)
					local var_16_7 = string.splitToNumber(var_16_6.param, "#")

					if var_16_7[1] == JumpEnum.JumpView.DungeonViewWithChapter then
						var_16_4.chapterId = var_16_7[2]
						var_16_4.probability = var_16_3[2] or 0
					elseif var_16_7[1] == JumpEnum.JumpView.DungeonViewWithEpisode then
						var_16_4.episodeId = var_16_7[2]
						var_16_4.probability = var_16_3[2] or 0
					end

					table.insert(var_16_0, var_16_4)
				end
			end
		end

		arg_16_0._itemSourceDict[arg_16_1][arg_16_2] = var_16_0
	end

	return var_16_0
end

function var_0_0.getBestSource(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0:_getItemSourceList(arg_17_1, arg_17_2)
	local var_17_1

	if var_17_0 then
		for iter_17_0, iter_17_1 in ipairs(var_17_0) do
			if iter_17_1.chapterId and DungeonController.instance:canJumpDungeonChapter(iter_17_1.chapterId) then
				if var_17_1 then
					if var_17_1.probability > iter_17_1.probability then
						var_17_1 = iter_17_1
					elseif var_17_1.probability == iter_17_1.probability and var_17_1.chapterId < iter_17_1.chapterId then
						var_17_1 = iter_17_1
					end
				else
					var_17_1 = iter_17_1
				end
			end

			if iter_17_1.episodeId and DungeonModel.instance:hasPassLevel(iter_17_1.episodeId) then
				if var_17_1 then
					if var_17_1.probability > iter_17_1.probability then
						var_17_1 = iter_17_1
					elseif var_17_1.probability == iter_17_1.probability and var_17_1.episodeId < iter_17_1.episodeId then
						var_17_1 = iter_17_1
					end
				else
					var_17_1 = iter_17_1
				end
			end
		end
	end

	return var_17_1
end

function var_0_0.isTradeStory(arg_18_0)
	if not arg_18_0._heroDevelopGoalsMO then
		return
	end

	for iter_18_0, iter_18_1 in ipairs(lua_chapter_divide.configList) do
		if var_0_0.instance:isTradeSection(iter_18_1.sectionId) then
			return true
		end
	end
end

function var_0_0.isTradeSection(arg_19_0, arg_19_1)
	if not arg_19_0._heroDevelopGoalsMO then
		return
	end

	local var_19_0 = DungeonMainStoryModel.instance:getChapterList(arg_19_1)

	if var_19_0 then
		for iter_19_0, iter_19_1 in ipairs(var_19_0) do
			if arg_19_0:isTradeChapter(iter_19_1.id) then
				return true
			end
		end
	end
end

function var_0_0.isTradeResDungeon(arg_20_0)
	if not arg_20_0._heroDevelopGoalsMO then
		return
	end

	for iter_20_0, iter_20_1 in pairs(CharacterRecommedEnum.ResDungeon) do
		if OpenModel.instance:isFuncBtnShow(iter_20_1.UnlockFunc) then
			local var_20_0 = DungeonConfig.instance:getChapterCO(iter_20_0)

			if arg_20_0:isTradeChapter(var_20_0.id) then
				return true
			end
		end
	end
end

function var_0_0.isTradeRankResDungeon(arg_21_0)
	if not arg_21_0._heroDevelopGoalsMO then
		return
	end

	for iter_21_0, iter_21_1 in pairs(CharacterRecommedEnum.RankResDungeon) do
		if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ResDungeon) then
			local var_21_0 = DungeonConfig.instance:getChapterCO(iter_21_1)

			if arg_21_0:isTradeChapter(var_21_0.id) then
				return true
			end
		end
	end
end

function var_0_0.getHeroName(arg_22_0, arg_22_1, arg_22_2)
	if not arg_22_0._heroName then
		arg_22_0._heroName = {}
	end

	local var_22_0 = arg_22_0._heroName[arg_22_1]

	if not var_22_0 and not string.nilorempty(arg_22_1) then
		local var_22_1 = LuaUtil.getUCharArr(arg_22_1)

		if var_22_1 then
			var_22_0 = ""

			for iter_22_0 = 2, #var_22_1 do
				var_22_0 = var_22_0 .. var_22_1[iter_22_0]
			end

			arg_22_2 = arg_22_2 or 52
			var_22_0 = var_22_1[1] .. string.format("<size=%s>%s</size>", arg_22_2, var_22_0)
			arg_22_0._heroName[arg_22_1] = var_22_0
		end
	end

	return var_22_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
