module("modules.logic.fight.model.datahelper.FightCardDataHelper", package.seeall)

local var_0_0 = {
	isBigSkill = function(arg_1_0)
		local var_1_0 = lua_skill.configDict[arg_1_0]

		if not var_1_0 then
			return false
		end

		return var_1_0.isBigSkill == 1
	end
}

function var_0_0.combineCardListForLocal(arg_2_0)
	return var_0_0.combineCardList(arg_2_0, FightLocalDataMgr.instance)
end

function var_0_0.combineCardListForPerformance(arg_3_0)
	return var_0_0.combineCardList(arg_3_0, FightDataMgr.instance)
end

function var_0_0.combineCardList(arg_4_0, arg_4_1)
	if not arg_4_1 then
		logError("调用list合牌方法,但是没有传入entityDataMgr,请检查代码")

		arg_4_1 = FightLocalDataMgr.entityMgr
	end

	local var_4_0 = 1
	local var_4_1 = false

	while not var_4_1 do
		local var_4_2 = false

		repeat
			if var_0_0.canCombineCard(arg_4_0[var_4_0], arg_4_0[var_4_0 + 1], arg_4_1) then
				local var_4_3 = table.remove(arg_4_0, var_4_0 + 1)
				local var_4_4 = arg_4_0[var_4_0]

				var_0_0.combineCard(var_4_4, var_4_3, arg_4_1)

				var_4_2 = true
			else
				var_4_0 = var_4_0 + 1
			end
		until var_4_0 >= #arg_4_0

		if not var_4_2 then
			var_4_1 = true
		else
			var_4_0 = 1
		end
	end

	return arg_4_0
end

function var_0_0.combineCardForLocal(arg_5_0, arg_5_1)
	return var_0_0.combineCard(arg_5_0, arg_5_1, FightLocalDataMgr.instance)
end

function var_0_0.combineCardForPerformance(arg_6_0, arg_6_1)
	return var_0_0.combineCard(arg_6_0, arg_6_1, FightDataMgr.instance)
end

function var_0_0.combineCard(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_2 then
		logError("调用合牌方法,但是没有传入entityDataMgr,请检查代码")

		arg_7_2 = FightLocalDataMgr.entityMgr
	end

	arg_7_0.skillId = FightCardModel.instance:getSkillNextLvId(arg_7_0.uid, arg_7_0.skillId)
	arg_7_0.tempCard = false

	var_0_0.enchantsAfterCombine(arg_7_0, arg_7_1)

	return arg_7_0
end

function var_0_0.canCombineCardForLocal(arg_8_0, arg_8_1)
	return var_0_0.canCombineCard(arg_8_0, arg_8_1, FightLocalDataMgr.instance)
end

function var_0_0.canCombineCardForPerformance(arg_9_0, arg_9_1)
	return var_0_0.canCombineCard(arg_9_0, arg_9_1, FightDataMgr.instance)
end

function var_0_0.canCombineCard(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_2 then
		logError("调用检测是否可以合牌方法,但是没有传入entityDataMgr,请检查代码")

		arg_10_2 = FightLocalDataMgr.entityMgr
	end

	if not arg_10_0 or not arg_10_1 then
		return false
	end

	if FightEnum.UniversalCard[arg_10_0.skillId] or FightEnum.UniversalCard[arg_10_1.skillId] then
		return false
	end

	if var_0_0.isSpecialCard(arg_10_0) or var_0_0.isSpecialCard(arg_10_1) then
		return false
	end

	if arg_10_0.uid ~= arg_10_1.uid then
		return false
	end

	if arg_10_0.skillId ~= arg_10_1.skillId then
		return false
	end

	local var_10_0 = lua_skill.configDict[arg_10_0.skillId]
	local var_10_1 = lua_skill.configDict[arg_10_1.skillId]

	if not var_10_0 or not var_10_1 then
		return false
	end

	if var_10_0.isBigSkill == 1 or var_10_1.isBigSkill == 1 then
		return false
	end

	if not FightCardModel.instance:getSkillNextLvId(arg_10_0.uid, arg_10_0.skillId) then
		return false
	end

	return true
end

function var_0_0.canCombineWithUniversalForLocal(arg_11_0, arg_11_1)
	return var_0_0.canCombineWithUniversal(arg_11_0, arg_11_1, FightLocalDataMgr.instance)
end

function var_0_0.canCombineWithUniversalForPerformance(arg_12_0, arg_12_1)
	return var_0_0.canCombineWithUniversal(arg_12_0, arg_12_1, FightDataMgr.instance)
end

function var_0_0.canCombineWithUniversal(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_2 then
		logError("调用检测是否可以和万能牌合牌,但是没有传入entityDataMgr,请检查代码")

		arg_13_2 = FightLocalDataMgr.entityMgr
	end

	if not arg_13_0 or not arg_13_1 then
		return false
	end

	if var_0_0.isSpecialCard(arg_13_1) then
		return false
	end

	local var_13_0 = arg_13_1.skillId

	if var_13_0 == FightEnum.UniversalCard1 or var_13_0 == FightEnum.UniversalCard2 then
		return false
	end

	local var_13_1 = FightCardModel.instance:getSkillLv(arg_13_1.uid, var_13_0)

	if arg_13_0.skillId == FightEnum.UniversalCard1 then
		if var_13_1 ~= 1 then
			return false
		end
	elseif arg_13_0.skillId == FightEnum.UniversalCard2 and var_13_1 ~= 1 and var_13_1 ~= 2 then
		return false
	end

	return true
end

function var_0_0.enchantsAfterCombine(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.enchants or {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1.enchants) do
		if var_0_0.canAddEnchant(arg_14_0, iter_14_1.enchantId) then
			var_0_0.addEnchant(var_14_0, iter_14_1)
		end
	end
end

function var_0_0.canAddEnchant(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.enchants or {}
	local var_15_1 = var_0_0.excludeEnchants(arg_15_1)
	local var_15_2 = true

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		if iter_15_1.enchantId == arg_15_1 then
			return true
		end

		if var_0_0.rejectEnchant(iter_15_1, arg_15_1) then
			return false
		end

		if var_15_1[iter_15_1.enchantId] then
			var_15_2 = false
		end
	end

	if var_15_2 then
		return #var_15_0 < FightEnum.EnchantNumLimit
	end

	return true
end

function var_0_0.addEnchant(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.enchantId
	local var_16_1 = var_0_0.excludeEnchants(var_16_0)

	for iter_16_0 = #arg_16_0, 1, -1 do
		if var_16_1[arg_16_0[iter_16_0].enchantId] then
			table.remove(arg_16_0, iter_16_0)
		end
	end

	local var_16_2 = false

	for iter_16_1, iter_16_2 in ipairs(arg_16_0) do
		if iter_16_2.enchantId == var_16_0 then
			var_16_2 = true

			if iter_16_2.duration == -1 or arg_16_1.duration == -1 then
				iter_16_2.duration = -1
			else
				iter_16_2.duration = math.max(iter_16_2.duration, arg_16_1.duration)
			end
		end
	end

	if not var_16_2 then
		table.insert(arg_16_0, arg_16_1)
	end
end

function var_0_0.excludeEnchants(arg_17_0)
	local var_17_0 = lua_card_enchant.configDict[arg_17_0]
	local var_17_1 = {}

	if not string.nilorempty(var_17_0.excludeTypes) then
		local var_17_2 = string.splitToNumber(var_17_0.excludeTypes, "#")

		for iter_17_0, iter_17_1 in ipairs(var_17_2) do
			var_17_1[iter_17_1] = true
		end
	end

	return var_17_1
end

function var_0_0.rejectEnchant(arg_18_0, arg_18_1)
	local var_18_0 = lua_card_enchant.configDict[arg_18_0.enchantId]
	local var_18_1 = lua_card_enchant.configDict[arg_18_1]
	local var_18_2 = string.splitToNumber(var_18_0.rejectTypes, "#")

	for iter_18_0, iter_18_1 in ipairs(var_18_2) do
		if iter_18_1 == var_18_1.id then
			return true
		end
	end
end

function var_0_0.isFrozenCard(arg_19_0)
	local var_19_0 = arg_19_0.enchants or {}

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		if iter_19_1.enchantId == FightEnum.EnchantedType.Frozen then
			return true
		end
	end
end

function var_0_0.isBurnCard(arg_20_0)
	local var_20_0 = arg_20_0.enchants or {}

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		if iter_20_1.enchantId == FightEnum.EnchantedType.Burn then
			return true
		end
	end
end

function var_0_0.isChaosCard(arg_21_0)
	local var_21_0 = arg_21_0.enchants or {}

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if iter_21_1.enchantId == FightEnum.EnchantedType.Chaos then
			return true
		end
	end
end

function var_0_0.isDiscard(arg_22_0)
	local var_22_0 = arg_22_0.enchants or {}

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		if iter_22_1.enchantId == FightEnum.EnchantedType.Discard then
			return true
		end
	end
end

function var_0_0.isBlockade(arg_23_0)
	local var_23_0 = arg_23_0.enchants or {}

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		if iter_23_1.enchantId == FightEnum.EnchantedType.Blockade then
			return true
		end
	end
end

function var_0_0.isPrecision(arg_24_0)
	local var_24_0 = arg_24_0.enchants or {}

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		if iter_24_1.enchantId == FightEnum.EnchantedType.Precision then
			return true
		end
	end
end

function var_0_0.isSpecialCard(arg_25_0)
	if not arg_25_0 then
		return
	end

	return var_0_0.isSpecialCardById(arg_25_0.uid, arg_25_0.skillId)
end

function var_0_0.isSpecialCardById(arg_26_0, arg_26_1)
	if (arg_26_0 == FightEntityScene.MySideId or arg_26_0 == FightEntityScene.EnemySideId) and not FightEnum.UniversalCard[arg_26_1] then
		return true
	end
end

function var_0_0.isNoCostSpecialCard(arg_27_0)
	if not arg_27_0 then
		return
	end

	if var_0_0.isSpecialCard(arg_27_0) and arg_27_0.cardType ~= FightEnum.CardType.ROUGE_SP and arg_27_0.cardType ~= FightEnum.CardType.USE_ACT_POINT then
		return true
	end
end

function var_0_0.canPlayCard(arg_28_0)
	if not arg_28_0 then
		return false
	end

	if var_0_0.isFrozenCard(arg_28_0) then
		return false
	end

	if var_0_0.isBlockade(arg_28_0) then
		local var_28_0 = arg_28_0.custom_handCardIndex

		if var_28_0 then
			local var_28_1 = FightCardModel.instance:getHandCards()

			return var_28_0 == 1 or var_28_0 == #var_28_1
		end
	end

	return true
end

function var_0_0.checkCanPlayCard(arg_29_0, arg_29_1)
	if not arg_29_0 then
		return false
	end

	if var_0_0.isFrozenCard(arg_29_0) then
		return false
	end

	if var_0_0.isBlockade(arg_29_0) then
		local var_29_0 = tabletool.indexOf(arg_29_1, arg_29_0)

		if var_29_0 then
			return var_29_0 == 1 or var_29_0 == #arg_29_1
		end
	end

	return true
end

function var_0_0.canMoveCard(arg_30_0)
	if not arg_30_0 then
		return false
	end

	if var_0_0.isSpecialCard(arg_30_0) then
		return false
	end

	if var_0_0.isFrozenCard(arg_30_0) then
		return false
	end

	return true
end

function var_0_0.playCanAddExpoint(arg_31_0, arg_31_1)
	if not arg_31_1 then
		return false
	end

	if var_0_0.isSpecialCard(arg_31_1) then
		return false
	end

	return true
end

function var_0_0.moveCanAddExpoint(arg_32_0, arg_32_1)
	if not arg_32_1 then
		return false
	end

	if FightEnum.UniversalCard[arg_32_1.skillId] then
		return false
	end

	if FightCardModel.instance:isUnlimitMoveCard() then
		return false
	end

	local var_32_0 = FightCardModel.instance:getCardMO().extraMoveAct

	if var_32_0 > 0 and var_32_0 > #FightCardModel.instance:getMoveCardOpCostActList() then
		return false
	end

	return true
end

function var_0_0.combineCanAddExpoint(arg_33_0, arg_33_1, arg_33_2)
	if not arg_33_1 or not arg_33_2 then
		return false
	end

	return true
end

function var_0_0.allFrozenCard(arg_34_0)
	local var_34_0 = 0

	for iter_34_0, iter_34_1 in ipairs(arg_34_0) do
		if var_0_0.isFrozenCard(iter_34_1) then
			var_34_0 = var_34_0 + 1
		end
	end

	return var_34_0 == #arg_34_0
end

function var_0_0.composeCards(arg_35_0, arg_35_1)
	local var_35_0, var_35_1, var_35_2 = FightCardModel.calcCardsAfterCombine(arg_35_0, arg_35_1)

	FightCardModel.instance:coverCard(var_35_0)
	FightController.instance:dispatchEvent(FightEvent.CardsCompose)

	return var_35_2
end

function var_0_0.calcRemoveCardTime(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = 0.033
	local var_36_1 = arg_36_2 or 1.2
	local var_36_2 = #arg_36_0
	local var_36_3 = #arg_36_1

	for iter_36_0, iter_36_1 in ipairs(arg_36_1) do
		if iter_36_1 < var_36_2 then
			var_36_1 = var_36_1 + var_36_0 * 7
			var_36_1 = var_36_1 + 3 * var_36_0 * (var_36_2 - arg_36_1[var_36_3] - var_36_3)

			break
		end
	end

	return var_36_1
end

function var_0_0.calcRemoveCardTime2(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = 0.033
	local var_37_1 = arg_37_2 or 1.2
	local var_37_2 = tabletool.copy(arg_37_0)

	for iter_37_0, iter_37_1 in ipairs(arg_37_1) do
		table.remove(var_37_2, iter_37_1)
	end

	for iter_37_2, iter_37_3 in ipairs(var_37_2) do
		if iter_37_3 ~= arg_37_0[iter_37_2] then
			var_37_1 = var_37_1 + var_37_0 * 7
			var_37_1 = var_37_1 + 3 * var_37_0 * (#var_37_2 - iter_37_2)

			break
		end
	end

	return var_37_1
end

function var_0_0.cardChangeIsMySide(arg_38_0)
	if FightModel.instance:getVersion() >= 1 then
		if not arg_38_0 then
			return false
		end

		if arg_38_0 and arg_38_0.teamType ~= FightEnum.TeamType.MySide then
			return false
		end
	end

	return true
end

function var_0_0.newCardList(arg_39_0)
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in ipairs(arg_39_0) do
		table.insert(var_39_0, FightCardData.New(iter_39_1))
	end

	return var_39_0
end

function var_0_0.newPlayCardList(arg_40_0)
	local var_40_0 = {}

	for iter_40_0, iter_40_1 in ipairs(arg_40_0) do
		table.insert(var_40_0, FightClientPlayCardData.New(iter_40_1, iter_40_0))
	end

	return var_40_0
end

local var_0_1 = {
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	0.9,
	0.8,
	0.73,
	0.67,
	0.62,
	0.57,
	0.53,
	0.5,
	0.47,
	0.44,
	0.42,
	0.4
}

function var_0_0.getHandCardContainerScale(arg_41_0, arg_41_1)
	local var_41_0 = #(arg_41_1 or FightDataHelper.handCardMgr.handCard)
	local var_41_1 = var_0_1[var_41_0] or 1

	if var_41_0 > 20 then
		var_41_1 = 0.4
	end

	if arg_41_0 and var_41_0 >= 8 then
		var_41_1 = var_41_1 * 0.9
	end

	return var_41_1
end

function var_0_0.remainedAfterCombine(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0.cardData
	local var_42_1 = arg_42_1.cardData

	if FightEnum.UniversalCard[var_42_0.skillId] or FightEnum.UniversalCard[var_42_1.skillId] then
		local var_42_2 = FightEnum.UniversalCard[arg_42_0.cardData.skillId] and arg_42_1 or arg_42_0
		local var_42_3 = var_42_2 == arg_42_0 and arg_42_1 or arg_42_0

		return var_42_2, var_42_3
	end

	if arg_42_0:getItemIndex() < arg_42_1:getItemIndex() then
		return arg_42_0, arg_42_1
	else
		return arg_42_1, arg_42_0
	end
end

return var_0_0
