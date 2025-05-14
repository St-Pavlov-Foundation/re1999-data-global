module("modules.logic.rouge.map.controller.RougeMapUnlockHelper", package.seeall)

local var_0_0 = class("RougeMapUnlockHelper")

var_0_0.UnlockType = {
	FinishEntrust = 14,
	PossessPower = 4,
	FinishEnd = 13,
	PossessCollectionCountByTag = 8,
	FinishAnyOneEnd = 12,
	DeadHeroNum = 17,
	PassLayer = 7,
	HadNotUniqueCollectionNum = 18,
	LevelUpSpCollectionCount = 20,
	PossessHero = 3,
	PossessSpCollectionCount = 21,
	FinishDifficulty = 16,
	PossessCollectionCount = 5,
	FinishPiece = 15,
	PossessCollectionCountByRare = 6,
	PossessCoin = 2,
	ActiveOutGenius = 9,
	FinishEvent = 11,
	PossessCollection = 1,
	CurMiddlePieceSelect = 10,
	None = 0
}

function var_0_0.checkIsUnlock(arg_1_0, arg_1_1)
	var_0_0._initHandle()

	local var_1_0 = var_0_0.unlockHandleDict[arg_1_0]

	if not var_1_0 then
		return true
	end

	return var_1_0(arg_1_1)
end

function var_0_0.getLockTips(arg_2_0, arg_2_1)
	var_0_0._initGetTipHandle()

	local var_2_0 = var_0_0.getTipHandleDict[arg_2_0]

	if not var_2_0 then
		return ""
	end

	local var_2_1 = lua_rouge_unlock_desc.configDict[arg_2_0]

	if not var_2_1 then
		return ""
	end

	local var_2_2 = var_2_1.desc

	return var_2_0(var_2_2, arg_2_1)
end

function var_0_0._initHandle()
	if var_0_0.unlockHandleDict then
		return
	end

	var_0_0.unlockHandleDict = {
		[var_0_0.UnlockType.None] = var_0_0._defaultCheck,
		[var_0_0.UnlockType.PossessCollection] = var_0_0._checkPossessCollection,
		[var_0_0.UnlockType.PossessCoin] = var_0_0._checkPossessCoin,
		[var_0_0.UnlockType.PossessHero] = var_0_0._checkPossessHero,
		[var_0_0.UnlockType.PossessPower] = var_0_0._checkPossessPower,
		[var_0_0.UnlockType.PossessCollectionCount] = var_0_0._checkPossessCollectionCount,
		[var_0_0.UnlockType.PossessCollectionCountByRare] = var_0_0._checkPossessCollectionCountByRare,
		[var_0_0.UnlockType.PassLayer] = var_0_0._checkPassLayer,
		[var_0_0.UnlockType.PossessCollectionCountByTag] = var_0_0._checkPossessCollectionCountByTag,
		[var_0_0.UnlockType.ActiveOutGenius] = var_0_0._checkActiveOutGenius,
		[var_0_0.UnlockType.CurMiddlePieceSelect] = var_0_0._checkCurMiddlePieceSelect,
		[var_0_0.UnlockType.FinishEvent] = var_0_0._checkFinishEvent,
		[var_0_0.UnlockType.FinishAnyOneEnd] = var_0_0._checkFinishAnyOneEnd,
		[var_0_0.UnlockType.FinishEnd] = var_0_0._checkFinishEnd,
		[var_0_0.UnlockType.FinishEntrust] = var_0_0._checkFinishEntrust,
		[var_0_0.UnlockType.FinishPiece] = var_0_0._checkFinishPiece,
		[var_0_0.UnlockType.FinishDifficulty] = var_0_0._checkFinishDifficulty,
		[var_0_0.UnlockType.DeadHeroNum] = var_0_0._checkDeadHeroNum,
		[var_0_0.UnlockType.HadNotUniqueCollectionNum] = var_0_0._checkHadNotUniqueCollectionNum,
		[var_0_0.UnlockType.PossessSpCollectionCount] = var_0_0._checkHadSpCollectionNum,
		[var_0_0.UnlockType.LevelUpSpCollectionCount] = var_0_0._checkHadLevelUpSpCollectionNum
	}
end

function var_0_0._initGetTipHandle()
	if var_0_0.getTipHandleDict then
		return
	end

	var_0_0.getTipHandleDict = {
		[var_0_0.UnlockType.PossessCollection] = var_0_0._getPossessCollectionTip,
		[var_0_0.UnlockType.PossessCoin] = var_0_0._getDefaultTips,
		[var_0_0.UnlockType.PossessHero] = var_0_0._getDefaultTips,
		[var_0_0.UnlockType.PossessPower] = var_0_0._getDefaultTips,
		[var_0_0.UnlockType.PossessCollectionCount] = var_0_0._getDefaultTips,
		[var_0_0.UnlockType.PossessCollectionCountByRare] = var_0_0._getPossessCollectionCountByRareTip,
		[var_0_0.UnlockType.PassLayer] = var_0_0._getPassLayerTip,
		[var_0_0.UnlockType.PossessCollectionCountByTag] = var_0_0._getPossessCollectionCountByTagTip,
		[var_0_0.UnlockType.ActiveOutGenius] = var_0_0._getActiveOutGeniusTip,
		[var_0_0.UnlockType.CurMiddlePieceSelect] = var_0_0._noParamTips,
		[var_0_0.UnlockType.FinishEvent] = var_0_0._getFinishEventTip,
		[var_0_0.UnlockType.FinishAnyOneEnd] = var_0_0._noParamTips,
		[var_0_0.UnlockType.FinishEnd] = var_0_0._getFinishEndTips,
		[var_0_0.UnlockType.FinishEntrust] = var_0_0._noParamTips,
		[var_0_0.UnlockType.FinishPiece] = var_0_0._noParamTips,
		[var_0_0.UnlockType.FinishDifficulty] = var_0_0._getFinishDifficultyTips,
		[var_0_0.UnlockType.DeadHeroNum] = var_0_0._getDefaultTips,
		[var_0_0.UnlockType.HadNotUniqueCollectionNum] = var_0_0._getDefaultTips,
		[var_0_0.UnlockType.PossessSpCollectionCount] = var_0_0._getDefaultTips,
		[var_0_0.UnlockType.LevelUpSpCollectionCount] = var_0_0._getDefaultTips
	}
end

function var_0_0._defaultCheck()
	return true
end

function var_0_0._checkPossessCollection(arg_6_0)
	local var_6_0 = tonumber(arg_6_0)

	if not var_6_0 then
		return true
	end

	local var_6_1 = RougeCollectionModel.instance:getAllCollections()

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		if iter_6_1.cfgId == var_6_0 then
			return true
		end
	end

	return false
end

function var_0_0._checkPossessCoin(arg_7_0)
	local var_7_0 = RougeModel.instance:getRougeInfo()

	return var_7_0 and var_7_0.coin >= tonumber(arg_7_0)
end

function var_0_0._checkPossessHero(arg_8_0)
	local var_8_0 = RougeModel.instance:getTeamInfo()

	return var_8_0 and var_8_0:getAllHeroCount() >= tonumber(arg_8_0)
end

function var_0_0._checkPossessPower(arg_9_0)
	local var_9_0 = RougeModel.instance:getRougeInfo()

	return var_9_0 and var_9_0.power >= tonumber(arg_9_0)
end

function var_0_0._checkPossessCollectionCount(arg_10_0)
	local var_10_0 = RougeCollectionModel.instance:getAllCollections()

	return var_10_0 and #var_10_0 >= tonumber(arg_10_0)
end

function var_0_0._checkPossessCollectionCountByRare(arg_11_0)
	local var_11_0 = string.splitToNumber(arg_11_0, "#")
	local var_11_1 = var_11_0[1]
	local var_11_2 = var_11_0[2]
	local var_11_3 = 0
	local var_11_4 = RougeCollectionModel.instance:getAllCollections()

	for iter_11_0, iter_11_1 in ipairs(var_11_4) do
		if RougeCollectionConfig.instance:getCollectionCfg(iter_11_1.cfgId).rare == var_11_1 then
			var_11_3 = var_11_3 + 1

			if var_11_2 <= var_11_3 then
				return true
			end
		end
	end

	return var_11_2 <= var_11_3
end

function var_0_0._checkPassLayer(arg_12_0)
	return RougeMapModel.instance:getLayerId() >= tonumber(arg_12_0)
end

function var_0_0._checkPossessCollectionCountByTag(arg_13_0)
	local var_13_0 = string.splitToNumber(arg_13_0, "#")
	local var_13_1 = var_13_0[1]
	local var_13_2 = var_13_0[2]
	local var_13_3 = 0
	local var_13_4 = RougeCollectionModel.instance:getAllCollections()

	for iter_13_0, iter_13_1 in ipairs(var_13_4) do
		local var_13_5 = RougeCollectionConfig.instance:getCollectionTags(iter_13_1.cfgId)

		for iter_13_2, iter_13_3 in ipairs(var_13_5) do
			if iter_13_3 == var_13_1 then
				var_13_3 = var_13_3 + 1

				if var_13_2 <= var_13_3 then
					return true
				end
			end

			break
		end
	end

	return var_13_2 <= var_13_3
end

function var_0_0._checkActiveOutGenius(arg_14_0)
	return RougeTalentModel.instance:checkNodeLight(tonumber(arg_14_0))
end

function var_0_0._checkCurMiddlePieceSelect(arg_15_0)
	if RougeMapModel.instance:isNormalLayer() then
		return false
	end

	local var_15_0 = string.splitToNumber(arg_15_0, "#")
	local var_15_1 = var_15_0[1]
	local var_15_2 = var_15_0[2]
	local var_15_3 = RougeMapModel.instance:getPieceList()

	for iter_15_0, iter_15_1 in ipairs(var_15_3) do
		if var_15_1 == iter_15_1.id then
			return var_15_2 == iter_15_1.selectId
		end
	end

	return false
end

function var_0_0._checkFinishEvent(arg_16_0)
	return RougeOutsideModel.instance:passedEventId(tonumber(arg_16_0))
end

function var_0_0._checkFinishAnyOneEnd()
	return RougeOutsideModel.instance:passAnyOneEnd()
end

function var_0_0._checkFinishEnd(arg_18_0)
	return RougeOutsideModel.instance:passEndId(tonumber(arg_18_0))
end

function var_0_0._checkFinishEntrust(arg_19_0)
	return RougeOutsideModel.instance:passEntrustId(tonumber(arg_19_0))
end

function var_0_0._checkFinishPiece(arg_20_0)
	if RougeMapModel.instance:isNormalLayer() then
		return false
	end

	local var_20_0 = string.splitToNumber(arg_20_0, "#")
	local var_20_1 = RougeMapModel.instance:getPieceList()
	local var_20_2 = false

	for iter_20_0, iter_20_1 in ipairs(var_20_1) do
		if tabletool.indexOf(var_20_0, iter_20_1.id) then
			var_20_2 = iter_20_1:isFinish()

			if var_20_2 then
				break
			end
		end
	end

	return var_20_2
end

function var_0_0._checkFinishDifficulty(arg_21_0)
	return tonumber(arg_21_0) <= RougeOutsideModel.instance:passedDifficulty()
end

function var_0_0._checkDeadHeroNum(arg_22_0)
	return RougeModel.instance:getDeadHeroNum() >= tonumber(arg_22_0)
end

function var_0_0._checkHadNotUniqueCollectionNum(arg_23_0)
	return tonumber(arg_23_0) <= RougeCollectionHelper.getNotUniqueCollectionNum()
end

function var_0_0._checkHadSpCollectionNum(arg_24_0)
	return tonumber(arg_24_0) <= RougeDLCModel102.instance:getAllSpCollectionCount()
end

function var_0_0._checkHadLevelUpSpCollectionNum(arg_25_0)
	return tonumber(arg_25_0) <= RougeDLCModel102.instance:getAllCanLevelUpSpCollectionCount()
end

function var_0_0._noParamTips(arg_26_0, arg_26_1)
	return arg_26_0
end

function var_0_0._getDefaultTips(arg_27_0, arg_27_1)
	return GameUtil.getSubPlaceholderLuaLangOneParam(arg_27_0, arg_27_1)
end

function var_0_0._getPossessCollectionTip(arg_28_0, arg_28_1)
	local var_28_0 = RougeCollectionConfig.instance:getCollectionName(tonumber(arg_28_1))

	return GameUtil.getSubPlaceholderLuaLangOneParam(arg_28_0, var_28_0)
end

function var_0_0._getPossessCollectionCountByRareTip(arg_29_0, arg_29_1)
	local var_29_0 = string.splitToNumber(arg_29_1, "#")
	local var_29_1 = var_29_0[1]
	local var_29_2 = var_29_0[2]
	local var_29_3 = lua_rouge_quality.configDict[var_29_1].name

	return GameUtil.getSubPlaceholderLuaLangTwoParam(arg_29_0, var_29_3, var_29_2)
end

function var_0_0._getPassLayerTip(arg_30_0, arg_30_1)
	local var_30_0 = lua_rouge_layer.configDict[tonumber(arg_30_1)].name

	return GameUtil.getSubPlaceholderLuaLangOneParam(arg_30_0, var_30_0)
end

function var_0_0._getPossessCollectionCountByTagTip(arg_31_0, arg_31_1)
	local var_31_0 = string.splitToNumber(arg_31_1, "#")
	local var_31_1 = var_31_0[1]
	local var_31_2 = var_31_0[2]
	local var_31_3 = lua_rouge_tag.configDict[var_31_1].name

	return GameUtil.getSubPlaceholderLuaLangTwoParam(arg_31_0, var_31_3, var_31_2)
end

function var_0_0._getActiveOutGeniusTip(arg_32_0, arg_32_1)
	local var_32_0 = tonumber(arg_32_1)
	local var_32_1 = RougeTalentConfig.instance:getBranchConfigByID(RougeModel.instance:getSeason() or 1, var_32_0)

	return GameUtil.getSubPlaceholderLuaLangOneParam(arg_32_0, var_32_1.name)
end

function var_0_0._getFinishEventTip(arg_33_0, arg_33_1)
	local var_33_0 = RougeMapConfig.instance:getRougeEvent(tonumber(arg_33_1))

	return GameUtil.getSubPlaceholderLuaLangOneParam(arg_33_0, var_33_0 and var_33_0.name)
end

function var_0_0._getFinishEndTips(arg_34_0, arg_34_1)
	local var_34_0 = lua_rouge_ending.configDict[tonumber(arg_34_1)]

	return GameUtil.getSubPlaceholderLuaLangOneParam(arg_34_0, var_34_0 and var_34_0.desc)
end

function var_0_0._getFinishDifficultyTips(arg_35_0, arg_35_1)
	local var_35_0 = RougeModel.instance:getSeason() or 1
	local var_35_1 = tonumber(arg_35_1)
	local var_35_2 = lua_rouge_difficulty.configDict[var_35_0][var_35_1]

	return GameUtil.getSubPlaceholderLuaLangOneParam(arg_35_0, var_35_2 and var_35_2.title)
end

return var_0_0
