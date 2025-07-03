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
	return var_0_0.combineCardList(arg_2_0, FightLocalDataMgr.instance.entityMgr)
end

function var_0_0.combineCardListForPerformance(arg_3_0)
	return var_0_0.combineCardList(arg_3_0, FightDataMgr.instance.entityMgr)
end

function var_0_0.combineCardList(arg_4_0, arg_4_1)
	if not arg_4_1 then
		logError("调用list合牌方法,但是没有传入entityDataMgr,请检查代码")

		arg_4_1 = FightLocalDataMgr.instance.entityMgr
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
	return var_0_0.combineCard(arg_5_0, arg_5_1, FightLocalDataMgr.instance.entityMgr)
end

function var_0_0.combineCardForPerformance(arg_6_0, arg_6_1)
	return var_0_0.combineCard(arg_6_0, arg_6_1, FightDataMgr.instance.entityMgr)
end

function var_0_0.combineCard(arg_7_0, arg_7_1, arg_7_2)
	if FightEnum.UniversalCard[arg_7_0.skillId] then
		arg_7_1, arg_7_0 = arg_7_0, arg_7_1
	end

	if not arg_7_2 then
		logError("调用合牌方法,但是没有传入entityDataMgr,请检查代码")

		arg_7_2 = FightLocalDataMgr.instance.entityMgr
	end

	arg_7_0.skillId = var_0_0.getSkillNextLvId(arg_7_0.uid, arg_7_0.skillId)
	arg_7_0.tempCard = false
	arg_7_0.energy = arg_7_0.energy + arg_7_1.energy

	var_0_0.enchantsAfterCombine(arg_7_0, arg_7_1)

	return arg_7_0
end

function var_0_0.getCombineCardSkillId(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.uid
	local var_8_1 = arg_8_0.skillId
	local var_8_2 = var_0_0.getSkillNextLvId()(var_8_0, var_8_1)
	local var_8_3 = true

	if var_0_0.isSkill3(arg_8_0) or var_0_0.isSkill3(arg_8_1) then
		var_8_3 = false
	end

	if var_8_3 and not FightEnum.UniversalCard[arg_8_0.skillId] and not FightEnum.UniversalCard[arg_8_1.skillId] then
		local var_8_4 = FightEnum.BuffFeature.ChangeComposeCardSkill
		local var_8_5 = {}

		tabletool.addValues(var_8_5, FightDataHelper.entityMgr:getMyPlayerList())
		tabletool.addValues(var_8_5, FightDataHelper.entityMgr:getMyNormalList())
		tabletool.addValues(var_8_5, FightDataHelper.entityMgr:getMySpList())

		local var_8_6 = 0

		for iter_8_0, iter_8_1 in ipairs(var_8_5) do
			local var_8_7 = iter_8_1.buffDic

			for iter_8_2, iter_8_3 in pairs(var_8_7) do
				local var_8_8 = FightConfig.instance:hasBuffFeature(iter_8_3.buffId, var_8_4)

				if var_8_8 then
					local var_8_9 = string.splitToNumber(var_8_8.featureStr, "#")

					if var_8_9[2] then
						var_8_6 = var_8_6 + var_8_9[2]
					end
				end
			end
		end

		if var_8_6 == 0 then
			return var_8_2
		elseif var_8_6 > 0 then
			for iter_8_4 = 1, var_8_6 do
				var_8_2 = var_0_0.getSkillNextLvId(var_8_0, var_8_2) or var_8_2
			end
		else
			for iter_8_5 = 1, math.abs(var_8_6) do
				var_8_2 = var_0_0.getSkillPrevLvId(var_8_0, var_8_2) or var_8_2
			end
		end
	end

	return var_8_2
end

function var_0_0.canCombineCardForLocal(arg_9_0, arg_9_1)
	return var_0_0.canCombineCard(arg_9_0, arg_9_1, FightLocalDataMgr.instance.entityMgr)
end

function var_0_0.canCombineCardForPerformance(arg_10_0, arg_10_1)
	return var_0_0.canCombineCard(arg_10_0, arg_10_1, FightDataMgr.instance.entityMgr)
end

function var_0_0.canCombineCardListForPerformance(arg_11_0)
	for iter_11_0 = 1, #arg_11_0 - 1 do
		if var_0_0.canCombineCardForPerformance(arg_11_0[iter_11_0], arg_11_0[iter_11_0 + 1]) then
			return iter_11_0
		end
	end
end

function var_0_0.canCombineCard(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_2 then
		logError("调用检测是否可以合牌方法,但是没有传入entityDataMgr,请检查代码")

		arg_12_2 = FightLocalDataMgr.instance.entityMgr
	end

	if not arg_12_0 or not arg_12_1 then
		return false
	end

	local var_12_0 = arg_12_0.skillId
	local var_12_1 = arg_12_1.skillId

	if var_12_0 ~= var_12_1 then
		return false
	end

	if FightEnum.UniversalCard[var_12_0] or FightEnum.UniversalCard[var_12_1] then
		return false
	end

	if var_0_0.isSpecialCard(arg_12_0) or var_0_0.isSpecialCard(arg_12_1) then
		return false
	end

	if arg_12_0.uid ~= arg_12_1.uid then
		return false
	end

	local var_12_2 = lua_skill.configDict[var_12_0]
	local var_12_3 = lua_skill.configDict[var_12_1]

	if not var_12_2 or not var_12_3 then
		return false
	end

	if not var_0_0.isSkill3(arg_12_0) and not var_0_0.isSkill3(arg_12_1) and (var_12_2.isBigSkill == 1 or var_12_3.isBigSkill == 1) then
		return false
	end

	local var_12_4 = lua_skill_next.configDict[var_12_0]

	if var_12_4 then
		return var_12_4.nextId ~= 0
	end

	if not var_0_0.getSkillNextLvId(arg_12_0.uid, var_12_0) then
		return false
	end

	return true
end

function var_0_0.canCombineWithUniversalForLocal(arg_13_0, arg_13_1)
	return var_0_0.canCombineWithUniversal(arg_13_0, arg_13_1, FightLocalDataMgr.instance.entityMgr)
end

function var_0_0.canCombineWithUniversalForPerformance(arg_14_0, arg_14_1)
	return var_0_0.canCombineWithUniversal(arg_14_0, arg_14_1, FightDataMgr.instance.entityMgr)
end

function var_0_0.canCombineWithUniversal(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_2 then
		logError("调用检测是否可以和万能牌合牌,但是没有传入entityDataMgr,请检查代码")

		arg_15_2 = FightLocalDataMgr.instance.entityMgr
	end

	if not arg_15_0 or not arg_15_1 then
		return false
	end

	if var_0_0.isSkill3(arg_15_1) then
		return false
	end

	if var_0_0.isSpecialCard(arg_15_1) then
		return false
	end

	local var_15_0 = arg_15_1.skillId

	if var_15_0 == FightEnum.UniversalCard1 or var_15_0 == FightEnum.UniversalCard2 then
		return false
	end

	local var_15_1 = var_0_0.getSkillLv(arg_15_1.uid, var_15_0)

	if arg_15_0.skillId == FightEnum.UniversalCard1 then
		if var_15_1 ~= 1 then
			return false
		end
	elseif arg_15_0.skillId == FightEnum.UniversalCard2 and var_15_1 ~= 1 and var_15_1 ~= 2 then
		return false
	end

	return true
end

function var_0_0.enchantsAfterCombine(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.enchants or {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1.enchants) do
		if var_0_0.canAddEnchant(arg_16_0, iter_16_1.enchantId) then
			var_0_0.addEnchant(var_16_0, iter_16_1)
		end
	end
end

function var_0_0.canAddEnchant(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.enchants or {}
	local var_17_1 = var_0_0.excludeEnchants(arg_17_1)
	local var_17_2 = true

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		if iter_17_1.enchantId == arg_17_1 then
			return true
		end

		if var_0_0.rejectEnchant(iter_17_1, arg_17_1) then
			return false
		end

		if var_17_1[iter_17_1.enchantId] then
			var_17_2 = false
		end
	end

	if var_17_2 then
		return #var_17_0 < FightEnum.EnchantNumLimit
	end

	return true
end

function var_0_0.addEnchant(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.enchantId
	local var_18_1 = var_0_0.excludeEnchants(var_18_0)

	for iter_18_0 = #arg_18_0, 1, -1 do
		if var_18_1[arg_18_0[iter_18_0].enchantId] then
			table.remove(arg_18_0, iter_18_0)
		end
	end

	local var_18_2 = false

	for iter_18_1, iter_18_2 in ipairs(arg_18_0) do
		if iter_18_2.enchantId == var_18_0 then
			var_18_2 = true

			if iter_18_2.duration == -1 or arg_18_1.duration == -1 then
				iter_18_2.duration = -1
			else
				iter_18_2.duration = math.max(iter_18_2.duration, arg_18_1.duration)
			end
		end
	end

	if not var_18_2 then
		table.insert(arg_18_0, arg_18_1)
	end
end

function var_0_0.excludeEnchants(arg_19_0)
	local var_19_0 = lua_card_enchant.configDict[arg_19_0]
	local var_19_1 = {}

	if not string.nilorempty(var_19_0.excludeTypes) then
		local var_19_2 = string.splitToNumber(var_19_0.excludeTypes, "#")

		for iter_19_0, iter_19_1 in ipairs(var_19_2) do
			var_19_1[iter_19_1] = true
		end
	end

	return var_19_1
end

function var_0_0.rejectEnchant(arg_20_0, arg_20_1)
	local var_20_0 = lua_card_enchant.configDict[arg_20_0.enchantId]
	local var_20_1 = lua_card_enchant.configDict[arg_20_1]
	local var_20_2 = string.splitToNumber(var_20_0.rejectTypes, "#")

	for iter_20_0, iter_20_1 in ipairs(var_20_2) do
		if iter_20_1 == var_20_1.id then
			return true
		end
	end
end

function var_0_0.isFrozenCard(arg_21_0)
	local var_21_0 = arg_21_0.enchants or {}

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if iter_21_1.enchantId == FightEnum.EnchantedType.Frozen then
			return true
		end
	end
end

function var_0_0.isBurnCard(arg_22_0)
	local var_22_0 = arg_22_0.enchants or {}

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		if iter_22_1.enchantId == FightEnum.EnchantedType.Burn then
			return true
		end
	end
end

function var_0_0.isChaosCard(arg_23_0)
	local var_23_0 = arg_23_0.enchants or {}

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		if iter_23_1.enchantId == FightEnum.EnchantedType.Chaos then
			return true
		end
	end
end

function var_0_0.isDiscard(arg_24_0)
	local var_24_0 = arg_24_0.enchants or {}

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		if iter_24_1.enchantId == FightEnum.EnchantedType.Discard then
			return true
		end
	end
end

function var_0_0.isBlockade(arg_25_0)
	local var_25_0 = arg_25_0.enchants or {}

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		if iter_25_1.enchantId == FightEnum.EnchantedType.Blockade then
			return true
		end
	end
end

function var_0_0.isPrecision(arg_26_0)
	local var_26_0 = arg_26_0.enchants or {}

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		if iter_26_1.enchantId == FightEnum.EnchantedType.Precision then
			return true
		end
	end
end

function var_0_0.isSkill3(arg_27_0)
	if not arg_27_0 then
		return
	end

	return arg_27_0.cardType == FightEnum.CardType.SKILL3
end

function var_0_0.isSpecialCard(arg_28_0)
	if not arg_28_0 then
		return
	end

	return var_0_0.isSpecialCardById(arg_28_0.uid, arg_28_0.skillId)
end

function var_0_0.isSpecialCardById(arg_29_0, arg_29_1)
	if (arg_29_0 == FightEntityScene.MySideId or arg_29_0 == FightEntityScene.EnemySideId) and not FightEnum.UniversalCard[arg_29_1] then
		return true
	end
end

function var_0_0.isNoCostSpecialCard(arg_30_0)
	if not arg_30_0 then
		return
	end

	if var_0_0.isSpecialCard(arg_30_0) and arg_30_0.cardType ~= FightEnum.CardType.ROUGE_SP and arg_30_0.cardType ~= FightEnum.CardType.USE_ACT_POINT then
		return true
	end
end

function var_0_0.checkIsBigSkillCostActPoint(arg_31_0, arg_31_1)
	local var_31_0 = FightDataHelper.entityMgr:getById(arg_31_0)

	if not var_31_0 then
		return true
	end

	local var_31_1 = lua_skill.configDict[arg_31_1]

	if not var_31_1 then
		return true
	end

	if var_31_1.isBigSkill ~= 1 then
		return true
	end

	if var_31_0:hasBuffFeature(FightEnum.BuffType_BigSkillNoUseActPoint) then
		return false
	end

	return true
end

function var_0_0.moveActCost(arg_32_0)
	if FightEnum.UniversalCard[arg_32_0.skillId] then
		return 0
	end

	return 1
end

function var_0_0.playActCost(arg_33_0)
	local var_33_0 = 1
	local var_33_1 = arg_33_0.uid
	local var_33_2 = arg_33_0.skillId
	local var_33_3 = arg_33_0.cardType

	if var_0_0.isSpecialCardById(var_33_1, var_33_2) then
		var_33_0 = (var_33_3 == FightEnum.CardType.ROUGE_SP or var_33_3 == FightEnum.CardType.USE_ACT_POINT) and 1 or 0
	end

	if var_0_0.isSkill3(arg_33_0) then
		var_33_0 = 0
	end

	if not var_0_0.checkIsBigSkillCostActPoint(var_33_1, var_33_2) then
		var_33_0 = 0
	end

	return var_33_0
end

function var_0_0.canPlayCard(arg_34_0)
	if not arg_34_0 then
		return false
	end

	if var_0_0.isFrozenCard(arg_34_0) then
		return false
	end

	if var_0_0.isBlockade(arg_34_0) then
		local var_34_0 = FightDataHelper.handCardMgr:getHandCard()
		local var_34_1 = tabletool.indexOf(var_34_0, arg_34_0)

		if var_34_1 then
			local var_34_2 = var_34_0

			return var_34_1 == 1 or var_34_1 == #var_34_2
		end
	end

	return true
end

function var_0_0.checkCanPlayCard(arg_35_0, arg_35_1)
	if not arg_35_0 then
		return false
	end

	if var_0_0.isFrozenCard(arg_35_0) then
		return false
	end

	if var_0_0.isBlockade(arg_35_0) then
		local var_35_0 = tabletool.indexOf(arg_35_1, arg_35_0)

		if var_35_0 then
			return var_35_0 == 1 or var_35_0 == #arg_35_1
		end
	end

	return true
end

function var_0_0.canMoveCard(arg_36_0)
	if not arg_36_0 then
		return false
	end

	if var_0_0.isSpecialCard(arg_36_0) then
		return false
	end

	if var_0_0.isFrozenCard(arg_36_0) then
		return false
	end

	if var_0_0.isSkill3(arg_36_0) then
		return false
	end

	return true
end

function var_0_0.playCanAddExpoint(arg_37_0, arg_37_1)
	if not arg_37_1 then
		return false
	end

	if var_0_0.isSpecialCard(arg_37_1) then
		return false
	end

	if var_0_0.isSkill3(arg_37_1) then
		return false
	end

	local var_37_0 = FightDataHelper.entityMgr:getById(arg_37_1.uid)

	if var_37_0 then
		local var_37_1 = FightEnum.ExPointTypeFeature[var_37_0.exPointType]

		if var_37_1 then
			return var_37_1.playAddExpoint
		end
	end

	return true
end

function var_0_0.moveCanAddExpoint(arg_38_0, arg_38_1)
	if not arg_38_1 then
		return false
	end

	if var_0_0.isSkill3(arg_38_1) then
		return false
	end

	if FightEnum.UniversalCard[arg_38_1.skillId] then
		return false
	end

	if FightDataHelper.operationDataMgr:isUnlimitMoveCard() then
		return false
	end

	local var_38_0 = FightDataHelper.operationDataMgr.extraMoveAct

	if var_38_0 > 0 and var_38_0 > #FightDataHelper.operationDataMgr:getMoveCardOpCostActList() then
		return false
	end

	local var_38_1 = FightDataHelper.entityMgr:getById(arg_38_1.uid)

	if var_38_1 then
		local var_38_2 = FightEnum.ExPointTypeFeature[var_38_1.exPointType]

		if var_38_2 then
			return var_38_2.moveAddExpoint
		end
	end

	return true
end

function var_0_0.combineCanAddExpoint(arg_39_0, arg_39_1, arg_39_2)
	if not arg_39_1 or not arg_39_2 then
		return false
	end

	if var_0_0.isSkill3(arg_39_1) or var_0_0.isSkill3(arg_39_2) then
		return false
	end

	local var_39_0 = FightDataHelper.entityMgr:getById(FightEnum.UniversalCard[arg_39_1.skillId] and arg_39_2.uid or arg_39_1.uid)

	if var_39_0 then
		local var_39_1 = FightEnum.ExPointTypeFeature[var_39_0.exPointType]

		if var_39_1 then
			return var_39_1.combineAddExpoint
		end
	end

	return true
end

function var_0_0.allFrozenCard(arg_40_0)
	local var_40_0 = 0

	for iter_40_0, iter_40_1 in ipairs(arg_40_0) do
		if var_0_0.isFrozenCard(iter_40_1) then
			var_40_0 = var_40_0 + 1
		end
	end

	return var_40_0 == #arg_40_0
end

function var_0_0.calcRemoveCardTime(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = 0.033
	local var_41_1 = arg_41_2 or 1.2
	local var_41_2 = #arg_41_0
	local var_41_3 = #arg_41_1

	for iter_41_0, iter_41_1 in ipairs(arg_41_1) do
		if iter_41_1 < var_41_2 then
			var_41_1 = var_41_1 + var_41_0 * 7
			var_41_1 = var_41_1 + 3 * var_41_0 * (var_41_2 - arg_41_1[var_41_3] - var_41_3)

			break
		end
	end

	return var_41_1
end

function var_0_0.calcRemoveCardTime2(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = 0.033
	local var_42_1 = arg_42_2 or 1.2
	local var_42_2 = tabletool.copy(arg_42_0)

	for iter_42_0, iter_42_1 in ipairs(arg_42_1) do
		table.remove(var_42_2, iter_42_1)
	end

	for iter_42_2, iter_42_3 in ipairs(var_42_2) do
		if iter_42_3 ~= arg_42_0[iter_42_2] then
			var_42_1 = var_42_1 + var_42_0 * 7
			var_42_1 = var_42_1 + 3 * var_42_0 * (#var_42_2 - iter_42_2)

			break
		end
	end

	return var_42_1
end

function var_0_0.cardChangeIsMySide(arg_43_0)
	if FightModel.instance:getVersion() >= 1 then
		if not arg_43_0 then
			return false
		end

		if arg_43_0 and arg_43_0.teamType ~= FightEnum.TeamType.MySide then
			return false
		end
	end

	return true
end

function var_0_0.newCardList(arg_44_0)
	local var_44_0 = {}

	for iter_44_0, iter_44_1 in ipairs(arg_44_0) do
		table.insert(var_44_0, FightCardInfoData.New(iter_44_1))
	end

	return var_44_0
end

function var_0_0.newPlayCardList(arg_45_0)
	local var_45_0 = {}

	for iter_45_0, iter_45_1 in ipairs(arg_45_0) do
		table.insert(var_45_0, FightClientPlayCardData.New(iter_45_1, iter_45_0))
	end

	return var_45_0
end

function var_0_0.remainedAfterCombine(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0.cardData
	local var_46_1 = arg_46_1.cardData

	if FightEnum.UniversalCard[var_46_0.skillId] or FightEnum.UniversalCard[var_46_1.skillId] then
		local var_46_2 = FightEnum.UniversalCard[arg_46_0.cardData.skillId] and arg_46_1 or arg_46_0
		local var_46_3 = var_46_2 == arg_46_0 and arg_46_1 or arg_46_0

		return var_46_2, var_46_3
	end

	if arg_46_0:getItemIndex() < arg_46_1:getItemIndex() then
		return arg_46_0, arg_46_1
	else
		return arg_46_1, arg_46_0
	end
end

function var_0_0.isBigSkill(arg_47_0)
	local var_47_0 = lua_skill.configDict[arg_47_0]

	if not var_47_0 then
		return false
	end

	return var_47_0.isBigSkill == 1
end

function var_0_0.getSkillLv(arg_48_0, arg_48_1)
	local var_48_0 = FightDataHelper.entityMgr:getById(arg_48_0)

	if var_48_0 then
		return var_48_0:getSkillLv(arg_48_1)
	end

	return FightConfig.instance:getSkillLv(arg_48_1)
end

function var_0_0.getSkillNextLvId(arg_49_0, arg_49_1)
	local var_49_0 = lua_skill_next.configDict[arg_49_1]

	if var_49_0 and var_49_0.nextId ~= 0 then
		return var_49_0.nextId
	end

	local var_49_1 = FightDataHelper.entityMgr:getById(arg_49_0)

	if var_49_1 then
		return var_49_1:getSkillNextLvId(arg_49_1)
	end

	return FightConfig.instance:getSkillNextLvId(arg_49_1)
end

function var_0_0.getSkillPrevLvId(arg_50_0, arg_50_1)
	local var_50_0 = FightDataHelper.entityMgr:getById(arg_50_0)

	if var_50_0 then
		return var_50_0:getSkillPrevLvId(arg_50_1)
	end

	return FightConfig.instance:getSkillPrevLvId(arg_50_1)
end

function var_0_0.isActiveSkill(arg_51_0, arg_51_1)
	local var_51_0 = FightDataHelper.entityMgr:getById(arg_51_0)

	if var_51_0 then
		return var_51_0:isActiveSkill(arg_51_1)
	end

	return FightConfig.instance:isActiveSkill(arg_51_1)
end

function var_0_0.calcCardsAfterCombine(arg_52_0)
	arg_52_0 = FightDataUtil.copyData(arg_52_0)

	var_0_0.combineCardListForPerformance(arg_52_0)

	return arg_52_0
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

function var_0_0.getHandCardContainerScale(arg_53_0, arg_53_1)
	local var_53_0 = #(arg_53_1 or FightDataHelper.handCardMgr.handCard)
	local var_53_1 = var_0_1[var_53_0] or 1

	if var_53_0 > 20 then
		var_53_1 = 0.4
	end

	if arg_53_0 and var_53_0 >= 8 then
		var_53_1 = var_53_1 * 0.9
	end

	return var_53_1
end

function var_0_0.moveOnly(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = table.remove(arg_54_0, arg_54_1)

	table.insert(arg_54_0, arg_54_2, var_54_0)
end

function var_0_0.checkOpAsPlayCardHandle(arg_55_0)
	if not arg_55_0 then
		return false
	end

	if arg_55_0:isPlayCard() then
		return true
	end

	if arg_55_0:isAssistBossPlayCard() then
		return true
	end

	if arg_55_0:isBloodPoolSkill() then
		return true
	end

	if arg_55_0:isPlayerFinisherSkill() then
		return true
	end

	return false
end

return var_0_0
