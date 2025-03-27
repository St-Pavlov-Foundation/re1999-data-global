module("modules.logic.rouge.map.controller.RougeMapUnlockHelper", package.seeall)

slot0 = class("RougeMapUnlockHelper")
slot0.UnlockType = {
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

function slot0.checkIsUnlock(slot0, slot1)
	uv0._initHandle()

	if not uv0.unlockHandleDict[slot0] then
		return true
	end

	return slot2(slot1)
end

function slot0.getLockTips(slot0, slot1)
	uv0._initGetTipHandle()

	if not uv0.getTipHandleDict[slot0] then
		return ""
	end

	if not lua_rouge_unlock_desc.configDict[slot0] then
		return ""
	end

	return slot2(slot3.desc, slot1)
end

function slot0._initHandle()
	if uv0.unlockHandleDict then
		return
	end

	uv0.unlockHandleDict = {
		[uv0.UnlockType.None] = uv0._defaultCheck,
		[uv0.UnlockType.PossessCollection] = uv0._checkPossessCollection,
		[uv0.UnlockType.PossessCoin] = uv0._checkPossessCoin,
		[uv0.UnlockType.PossessHero] = uv0._checkPossessHero,
		[uv0.UnlockType.PossessPower] = uv0._checkPossessPower,
		[uv0.UnlockType.PossessCollectionCount] = uv0._checkPossessCollectionCount,
		[uv0.UnlockType.PossessCollectionCountByRare] = uv0._checkPossessCollectionCountByRare,
		[uv0.UnlockType.PassLayer] = uv0._checkPassLayer,
		[uv0.UnlockType.PossessCollectionCountByTag] = uv0._checkPossessCollectionCountByTag,
		[uv0.UnlockType.ActiveOutGenius] = uv0._checkActiveOutGenius,
		[uv0.UnlockType.CurMiddlePieceSelect] = uv0._checkCurMiddlePieceSelect,
		[uv0.UnlockType.FinishEvent] = uv0._checkFinishEvent,
		[uv0.UnlockType.FinishAnyOneEnd] = uv0._checkFinishAnyOneEnd,
		[uv0.UnlockType.FinishEnd] = uv0._checkFinishEnd,
		[uv0.UnlockType.FinishEntrust] = uv0._checkFinishEntrust,
		[uv0.UnlockType.FinishPiece] = uv0._checkFinishPiece,
		[uv0.UnlockType.FinishDifficulty] = uv0._checkFinishDifficulty,
		[uv0.UnlockType.DeadHeroNum] = uv0._checkDeadHeroNum,
		[uv0.UnlockType.HadNotUniqueCollectionNum] = uv0._checkHadNotUniqueCollectionNum,
		[uv0.UnlockType.PossessSpCollectionCount] = uv0._checkHadSpCollectionNum,
		[uv0.UnlockType.LevelUpSpCollectionCount] = uv0._checkHadLevelUpSpCollectionNum
	}
end

function slot0._initGetTipHandle()
	if uv0.getTipHandleDict then
		return
	end

	uv0.getTipHandleDict = {
		[uv0.UnlockType.PossessCollection] = uv0._getPossessCollectionTip,
		[uv0.UnlockType.PossessCoin] = uv0._getDefaultTips,
		[uv0.UnlockType.PossessHero] = uv0._getDefaultTips,
		[uv0.UnlockType.PossessPower] = uv0._getDefaultTips,
		[uv0.UnlockType.PossessCollectionCount] = uv0._getDefaultTips,
		[uv0.UnlockType.PossessCollectionCountByRare] = uv0._getPossessCollectionCountByRareTip,
		[uv0.UnlockType.PassLayer] = uv0._getPassLayerTip,
		[uv0.UnlockType.PossessCollectionCountByTag] = uv0._getPossessCollectionCountByTagTip,
		[uv0.UnlockType.ActiveOutGenius] = uv0._getActiveOutGeniusTip,
		[uv0.UnlockType.CurMiddlePieceSelect] = uv0._noParamTips,
		[uv0.UnlockType.FinishEvent] = uv0._getFinishEventTip,
		[uv0.UnlockType.FinishAnyOneEnd] = uv0._noParamTips,
		[uv0.UnlockType.FinishEnd] = uv0._getFinishEndTips,
		[uv0.UnlockType.FinishEntrust] = uv0._noParamTips,
		[uv0.UnlockType.FinishPiece] = uv0._noParamTips,
		[uv0.UnlockType.FinishDifficulty] = uv0._getFinishDifficultyTips,
		[uv0.UnlockType.DeadHeroNum] = uv0._getDefaultTips,
		[uv0.UnlockType.HadNotUniqueCollectionNum] = uv0._getDefaultTips,
		[uv0.UnlockType.PossessSpCollectionCount] = uv0._getDefaultTips,
		[uv0.UnlockType.LevelUpSpCollectionCount] = uv0._getDefaultTips
	}
end

function slot0._defaultCheck()
	return true
end

function slot0._checkPossessCollection(slot0)
	if not tonumber(slot0) then
		return true
	end

	for slot6, slot7 in ipairs(RougeCollectionModel.instance:getAllCollections()) do
		if slot7.cfgId == slot1 then
			return true
		end
	end

	return false
end

function slot0._checkPossessCoin(slot0)
	return RougeModel.instance:getRougeInfo() and tonumber(slot0) <= slot1.coin
end

function slot0._checkPossessHero(slot0)
	return RougeModel.instance:getTeamInfo() and tonumber(slot0) <= slot1:getAllHeroCount()
end

function slot0._checkPossessPower(slot0)
	return RougeModel.instance:getRougeInfo() and tonumber(slot0) <= slot1.power
end

function slot0._checkPossessCollectionCount(slot0)
	return RougeCollectionModel.instance:getAllCollections() and tonumber(slot0) <= #slot1
end

function slot0._checkPossessCollectionCountByRare(slot0)
	slot1 = string.splitToNumber(slot0, "#")
	slot3 = slot1[2]
	slot4 = 0

	for slot9, slot10 in ipairs(RougeCollectionModel.instance:getAllCollections()) do
		if RougeCollectionConfig.instance:getCollectionCfg(slot10.cfgId).rare == slot1[1] and slot3 <= slot4 + 1 then
			return true
		end
	end

	return slot3 <= slot4
end

function slot0._checkPassLayer(slot0)
	return tonumber(slot0) <= RougeMapModel.instance:getLayerId()
end

function slot0._checkPossessCollectionCountByTag(slot0)
	slot1 = string.splitToNumber(slot0, "#")
	slot2 = slot1[1]
	slot3 = slot1[2]
	slot4 = 0

	for slot9, slot10 in ipairs(RougeCollectionModel.instance:getAllCollections()) do
		for slot15, slot16 in ipairs(RougeCollectionConfig.instance:getCollectionTags(slot10.cfgId)) do
			if slot16 == slot2 and slot3 <= slot4 + 1 then
				return true
			end

			break
		end
	end

	return slot3 <= slot4
end

function slot0._checkActiveOutGenius(slot0)
	return RougeTalentModel.instance:checkNodeLight(tonumber(slot0))
end

function slot0._checkCurMiddlePieceSelect(slot0)
	if RougeMapModel.instance:isNormalLayer() then
		return false
	end

	slot1 = string.splitToNumber(slot0, "#")

	for slot8, slot9 in ipairs(RougeMapModel.instance:getPieceList()) do
		if slot1[1] == slot9.id then
			return slot1[2] == slot9.selectId
		end
	end

	return false
end

function slot0._checkFinishEvent(slot0)
	return RougeOutsideModel.instance:passedEventId(tonumber(slot0))
end

function slot0._checkFinishAnyOneEnd()
	return RougeOutsideModel.instance:passAnyOneEnd()
end

function slot0._checkFinishEnd(slot0)
	return RougeOutsideModel.instance:passEndId(tonumber(slot0))
end

function slot0._checkFinishEntrust(slot0)
	return RougeOutsideModel.instance:passEntrustId(tonumber(slot0))
end

function slot0._checkFinishPiece(slot0)
	if RougeMapModel.instance:isNormalLayer() then
		return false
	end

	slot3 = false

	for slot7, slot8 in ipairs(RougeMapModel.instance:getPieceList()) do
		if tabletool.indexOf(string.splitToNumber(slot0, "#"), slot8.id) and slot8:isFinish() then
			break
		end
	end

	return slot3
end

function slot0._checkFinishDifficulty(slot0)
	return tonumber(slot0) <= RougeOutsideModel.instance:passedDifficulty()
end

function slot0._checkDeadHeroNum(slot0)
	return tonumber(slot0) <= RougeModel.instance:getDeadHeroNum()
end

function slot0._checkHadNotUniqueCollectionNum(slot0)
	return tonumber(slot0) <= RougeCollectionHelper.getNotUniqueCollectionNum()
end

function slot0._checkHadSpCollectionNum(slot0)
	return tonumber(slot0) <= RougeDLCModel102.instance:getAllSpCollectionCount()
end

function slot0._checkHadLevelUpSpCollectionNum(slot0)
	return tonumber(slot0) <= RougeDLCModel102.instance:getAllCanLevelUpSpCollectionCount()
end

function slot0._noParamTips(slot0, slot1)
	return slot0
end

function slot0._getDefaultTips(slot0, slot1)
	return GameUtil.getSubPlaceholderLuaLangOneParam(slot0, slot1)
end

function slot0._getPossessCollectionTip(slot0, slot1)
	return GameUtil.getSubPlaceholderLuaLangOneParam(slot0, RougeCollectionConfig.instance:getCollectionName(tonumber(slot1)))
end

function slot0._getPossessCollectionCountByRareTip(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "#")

	return GameUtil.getSubPlaceholderLuaLangTwoParam(slot0, lua_rouge_quality.configDict[slot2[1]].name, slot2[2])
end

function slot0._getPassLayerTip(slot0, slot1)
	return GameUtil.getSubPlaceholderLuaLangOneParam(slot0, lua_rouge_layer.configDict[tonumber(slot1)].name)
end

function slot0._getPossessCollectionCountByTagTip(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "#")

	return GameUtil.getSubPlaceholderLuaLangTwoParam(slot0, lua_rouge_tag.configDict[slot2[1]].name, slot2[2])
end

function slot0._getActiveOutGeniusTip(slot0, slot1)
	return GameUtil.getSubPlaceholderLuaLangOneParam(slot0, RougeTalentConfig.instance:getBranchConfigByID(RougeModel.instance:getSeason() or 1, tonumber(slot1)).name)
end

function slot0._getFinishEventTip(slot0, slot1)
	return GameUtil.getSubPlaceholderLuaLangOneParam(slot0, RougeMapConfig.instance:getRougeEvent(tonumber(slot1)) and slot2.name)
end

function slot0._getFinishEndTips(slot0, slot1)
	return GameUtil.getSubPlaceholderLuaLangOneParam(slot0, lua_rouge_ending.configDict[tonumber(slot1)] and slot2.desc)
end

function slot0._getFinishDifficultyTips(slot0, slot1)
	return GameUtil.getSubPlaceholderLuaLangOneParam(slot0, lua_rouge_difficulty.configDict[RougeModel.instance:getSeason() or 1][tonumber(slot1)] and slot4.title)
end

return slot0
