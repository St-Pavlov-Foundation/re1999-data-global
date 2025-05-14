module("modules.logic.fight.model.FightCardModel", package.seeall)

local var_0_0 = class("FightCardModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._cardMO = FightCardMO.New()
	arg_1_0._distributeQueue = {}
	arg_1_0._cardOps = {}
	arg_1_0.curSelectEntityId = 0
	arg_1_0.nextRoundActPoint = nil
	arg_1_0.nextRoundMoveNum = nil
	arg_1_0._universalCardMO = nil
	arg_1_0._beCombineCardMO = nil
	arg_1_0.redealCardInfoList = nil
	arg_1_0._dissolvingCard = nil
	arg_1_0._changingCard = nil
	arg_1_0.areaSize = 0
	arg_1_0._longPressIndex = -1
end

function var_0_0.getLongPressIndex(arg_2_0)
	return arg_2_0._longPressIndex
end

function var_0_0.setLongPressIndex(arg_3_0, arg_3_1)
	arg_3_0._longPressIndex = arg_3_1
end

function var_0_0.clear(arg_4_0)
	arg_4_0.redealCardInfoList = nil
	arg_4_0._dissolvingCard = nil
	arg_4_0._changingCard = nil
	arg_4_0.areaSize = 0

	arg_4_0:clearCardOps()

	if arg_4_0._cardMO then
		arg_4_0._cardMO:reset()
	end

	arg_4_0:clearDistributeQueue()
end

function var_0_0.setDissolving(arg_5_0, arg_5_1)
	if FightModel.instance:getVersion() >= 1 then
		return
	end

	arg_5_0._dissolvingCard = arg_5_1
end

function var_0_0.setChanging(arg_6_0, arg_6_1)
	arg_6_0._changingCard = arg_6_1
end

function var_0_0.isDissolving(arg_7_0)
	return arg_7_0._dissolvingCard
end

function var_0_0.isChanging(arg_8_0)
	return arg_8_0._changingCard
end

function var_0_0.setUniversalCombine(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._universalCardMO = arg_9_1
	arg_9_0._beCombineCardMO = arg_9_2
end

function var_0_0.getUniversalCardMO(arg_10_0)
	return arg_10_0._universalCardMO
end

function var_0_0.getBeCombineCardMO(arg_11_0)
	return arg_11_0._beCombineCardMO
end

function var_0_0.enqueueDistribute(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = tabletool.copy(arg_12_1)
	local var_12_1 = tabletool.copy(arg_12_2)

	if #var_12_1 > 0 then
		while #var_12_1 > 0 do
			local var_12_2 = #var_12_1
			local var_12_3 = 1
			local var_12_4 = tabletool.copy(var_12_0)

			while #var_12_1 > 0 do
				table.insert(var_12_4, table.remove(var_12_1, 1))

				if var_0_0.getCombineIndexOnce(var_12_4) then
					break
				end
			end

			local var_12_5 = {}

			for iter_12_0 = #var_12_0 + 1, #var_12_4 do
				table.insert(var_12_5, var_12_4[iter_12_0])
			end

			table.insert(arg_12_0._distributeQueue, {
				var_12_0,
				var_12_5
			})

			var_12_0 = var_0_0.calcCardsAfterCombine(var_12_4)
		end
	else
		table.insert(arg_12_0._distributeQueue, {
			var_12_0,
			var_12_1
		})
	end
end

function var_0_0.dequeueDistribute(arg_13_0)
	if #arg_13_0._distributeQueue > 0 then
		local var_13_0 = table.remove(arg_13_0._distributeQueue, 1)

		return var_13_0[1], var_13_0[2]
	end
end

function var_0_0.clearDistributeQueue(arg_14_0)
	arg_14_0._distributeQueue = {}
end

function var_0_0.getDistributeQueueLen(arg_15_0)
	return #arg_15_0._distributeQueue
end

function var_0_0.applyNextRoundActPoint(arg_16_0)
	if arg_16_0.nextRoundActPoint and arg_16_0.nextRoundActPoint > 0 then
		arg_16_0._cardMO.actPoint = arg_16_0.nextRoundActPoint
		arg_16_0._cardMO.moveNum = arg_16_0.nextRoundMoveNum
		arg_16_0.nextRoundActPoint = nil
		arg_16_0.nextRoundMoveNum = nil
	end
end

function var_0_0.getEntityOps(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._cardOps) do
		if iter_17_1.belongToEntityId == arg_17_1 and (not arg_17_2 or iter_17_1.operType == arg_17_2) then
			table.insert(var_17_0, iter_17_1)
		end
	end

	return var_17_0
end

function var_0_0.setCurSelectEntityId(arg_18_0, arg_18_1)
	arg_18_0.curSelectEntityId = arg_18_1
end

function var_0_0.resetCurSelectEntityIdDefault(arg_19_0)
	if FightModel.instance:isAuto() then
		if FightHelper.canSelectEnemyEntity(arg_19_0.curSelectEntityId) then
			arg_19_0:setCurSelectEntityId(arg_19_0.curSelectEntityId)
		else
			arg_19_0:setCurSelectEntityId(0)
		end
	else
		local var_19_0 = FightDataHelper.entityMgr:getById(arg_19_0.curSelectEntityId)

		if var_19_0 and var_19_0:isStatusDead() then
			var_19_0 = nil
		end

		if var_19_0 and var_19_0.side == FightEnum.EntitySide.MySide then
			arg_19_0.curSelectEntityId = 0
			var_19_0 = nil
		end

		local var_19_1 = var_19_0 ~= nil
		local var_19_2 = var_19_0 and var_19_0:hasBuffFeature(FightEnum.BuffType_CantSelect)
		local var_19_3 = var_19_0 and var_19_0:hasBuffFeature(FightEnum.BuffType_CantSelectEx)

		if arg_19_0.curSelectEntityId ~= 0 and var_19_1 and not var_19_2 and not var_19_3 then
			return
		end

		local var_19_4 = FightDataHelper.entityMgr:getEnemyNormalList()

		for iter_19_0 = #var_19_4, 1, -1 do
			local var_19_5 = var_19_4[iter_19_0]

			if var_19_5:hasBuffFeature(FightEnum.BuffType_CantSelect) or var_19_5:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
				table.remove(var_19_4, iter_19_0)
			end
		end

		if #var_19_4 > 0 then
			table.sort(var_19_4, function(arg_20_0, arg_20_1)
				return arg_20_0.position < arg_20_1.position
			end)
			arg_19_0:setCurSelectEntityId(var_19_4[1].id)
		end
	end
end

function var_0_0.getSelectEnemyPosLOrR(arg_21_0, arg_21_1)
	local var_21_0 = FightDataHelper.entityMgr:getEnemyNormalList()

	for iter_21_0 = #var_21_0, 1, -1 do
		local var_21_1 = var_21_0[iter_21_0]

		if var_21_1:hasBuffFeature(FightEnum.BuffType_CantSelect) or var_21_1:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
			table.remove(var_21_0, iter_21_0)
		end
	end

	if #var_21_0 > 0 then
		table.sort(var_21_0, function(arg_22_0, arg_22_1)
			local var_22_0, var_22_1, var_22_2 = FightHelper.getEntityStandPos(arg_22_0)
			local var_22_3, var_22_4, var_22_5 = FightHelper.getEntityStandPos(arg_22_1)

			return var_22_3 < var_22_0
		end)

		for iter_21_1 = 1, #var_21_0 do
			if var_21_0[iter_21_1].id == arg_21_0.curSelectEntityId then
				if arg_21_1 == 1 and iter_21_1 < #var_21_0 then
					return var_21_0[iter_21_1 + 1].id
				elseif arg_21_1 == 2 and iter_21_1 > 1 then
					return var_21_0[iter_21_1 - 1].id
				end
			end
		end
	end
end

function var_0_0.onStartRound(arg_23_0)
	arg_23_0:getCardMO():setExtraMoveAct(0)
end

function var_0_0.onEndRound(arg_24_0)
	return
end

function var_0_0.getCardMO(arg_25_0)
	return arg_25_0._cardMO
end

function var_0_0.getCardOps(arg_26_0)
	return arg_26_0._cardOps
end

function var_0_0.resetCardOps(arg_27_0)
	arg_27_0._cardOps = {}

	local var_27_0 = FightDataHelper.entityMgr:getAllEntityData()

	for iter_27_0, iter_27_1 in pairs(var_27_0) do
		iter_27_1:resetSimulateExPoint()
	end
end

function var_0_0.clearCardOps(arg_28_0)
	arg_28_0._cardOps = {}
end

function var_0_0.getShowOpActList(arg_29_0)
	local var_29_0 = {}

	for iter_29_0, iter_29_1 in ipairs(arg_29_0._cardOps) do
		if var_0_0.instance:canShowOpAct(iter_29_1) then
			table.insert(var_29_0, iter_29_1)
		end
	end

	return var_29_0
end

function var_0_0.canShowOpAct(arg_30_0, arg_30_1)
	if not arg_30_1:isMoveUniversal() and (not (arg_30_1:isMoveCard() and arg_30_0._cardMO:isUnlimitMoveCard()) or arg_30_1:isPlayCard()) then
		return true
	end
end

function var_0_0.getPlayCardOpList(arg_31_0)
	local var_31_0 = {}

	for iter_31_0, iter_31_1 in ipairs(arg_31_0._cardOps) do
		if iter_31_1:isPlayCard() then
			table.insert(var_31_0, iter_31_1)
		end
	end

	return var_31_0
end

function var_0_0.getMoveCardOpList(arg_32_0)
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in ipairs(arg_32_0._cardOps) do
		if iter_32_1:isMoveCard() then
			table.insert(var_32_0, iter_32_1)
		end
	end

	return var_32_0
end

function var_0_0.getMoveCardOpCostActList(arg_33_0)
	local var_33_0 = {}

	for iter_33_0, iter_33_1 in ipairs(arg_33_0._cardOps) do
		if iter_33_1:isMoveCard() then
			table.insert(var_33_0, iter_33_1)
		end
	end

	return var_33_0
end

function var_0_0.updateCard(arg_34_0, arg_34_1)
	arg_34_0:clearCardOps()
	arg_34_0._cardMO:init(arg_34_1)
end

function var_0_0.coverCard(arg_35_0, arg_35_1)
	if not arg_35_1 then
		logError("覆盖卡牌序列,传入的数据为空")
	end

	arg_35_0._cardMO:setCards(arg_35_1)
end

function var_0_0.getHandCards(arg_36_0)
	return arg_36_0:getHandCardsByOps(arg_36_0._cardOps)
end

function var_0_0.getHandCardData(arg_37_0)
	return arg_37_0._cardMO and arg_37_0._cardMO.cardGroup
end

function var_0_0.getHandCardsByOps(arg_38_0, arg_38_1)
	return arg_38_0:tryGettingHandCardsByOps(arg_38_1) or {}
end

function var_0_0.tryGettingHandCardsByOps(arg_39_0, arg_39_1)
	if not arg_39_0._cardMO then
		return nil
	end

	local var_39_0
	local var_39_1
	local var_39_2 = tabletool.copy(arg_39_0._cardMO.cardGroup)

	for iter_39_0, iter_39_1 in ipairs(arg_39_1) do
		local var_39_3 = false

		if iter_39_1:isMoveCard() then
			var_39_0 = nil
			var_39_1 = nil

			if not var_39_2[iter_39_1.param1] then
				return nil
			end

			if not var_39_2[iter_39_1.param2] then
				return nil
			end

			var_0_0.moveOnly(var_39_2, iter_39_1.param1, iter_39_1.param2)
		elseif iter_39_1:isPlayCard() then
			var_39_0 = nil
			var_39_1 = nil

			if not var_39_2[iter_39_1.param1] then
				return nil
			end

			table.remove(var_39_2, iter_39_1.param1)

			if iter_39_1.param2 and iter_39_1.params ~= 0 then
				var_39_3 = true
			end
		elseif iter_39_1:isMoveUniversal() then
			var_39_0 = var_39_2[iter_39_1.param1]
			var_39_1 = var_39_2[iter_39_1.param2]

			if not var_39_2[iter_39_1.param1] then
				return nil
			end

			if not var_39_2[iter_39_1.param2] then
				return nil
			end

			var_0_0.moveOnly(var_39_2, iter_39_1.param1, iter_39_1.moveToIndex)
		elseif iter_39_1:isSimulateDissolveCard() then
			table.remove(var_39_2, iter_39_1.dissolveIndex)
		end

		if var_39_3 then
			table.remove(var_39_2, iter_39_1.param2)

			local var_39_4 = var_0_0.getCombineIndexOnce(var_39_2, var_39_0, var_39_1)

			while #var_39_2 >= 2 and var_39_4 do
				var_39_2[var_39_4] = var_0_0.combineTwoCard(var_39_2[var_39_4], var_39_2[var_39_4 + 1], var_39_1)

				table.remove(var_39_2, var_39_4 + 1)

				var_39_0 = nil
				var_39_1 = nil
				var_39_4 = var_0_0.getCombineIndexOnce(var_39_2)
			end
		end

		local var_39_5 = var_0_0.getCombineIndexOnce(var_39_2, var_39_0, var_39_1)

		while #var_39_2 >= 2 and var_39_5 do
			var_39_2[var_39_5] = var_0_0.combineTwoCard(var_39_2[var_39_5], var_39_2[var_39_5 + 1], var_39_1)

			table.remove(var_39_2, var_39_5 + 1)

			var_39_0 = nil
			var_39_1 = nil
			var_39_5 = var_0_0.getCombineIndexOnce(var_39_2)
		end
	end

	return var_39_2
end

function var_0_0.isCardOpEnd(arg_40_0)
	local var_40_0 = var_0_0.instance:getCardMO()

	if not var_40_0 then
		return true
	end

	local var_40_1 = var_0_0.instance:getHandCards()

	if #var_40_1 == 0 then
		return true
	end

	local var_40_2 = var_0_0.instance:getCardOps()
	local var_40_3 = 0
	local var_40_4 = 0

	for iter_40_0, iter_40_1 in ipairs(var_40_2) do
		if iter_40_1:isPlayCard() then
			var_40_3 = var_40_3 + iter_40_1.costActPoint
		elseif iter_40_1:isMoveCard() then
			var_40_4 = var_40_4 + 1

			if not arg_40_0._cardMO:isUnlimitMoveCard() and var_40_4 > arg_40_0._cardMO.extraMoveAct then
				var_40_3 = var_40_3 + iter_40_1.costActPoint
			end
		end
	end

	local var_40_5 = var_40_0.actPoint

	if FightModel.instance:isSeason2() then
		var_40_5 = 1

		if #var_40_2 >= 1 then
			return true
		end
	end

	if var_40_5 <= var_40_3 then
		return true
	end

	if FightCardDataHelper.allFrozenCard(var_40_1) then
		return true
	end

	return false
end

function var_0_0.calcCardsAfterCombine(arg_41_0, arg_41_1)
	local var_41_0 = tabletool.copy(arg_41_0)
	local var_41_1 = var_0_0.getCombineIndexOnce(var_41_0)
	local var_41_2 = 0

	while var_41_1 do
		var_41_0[var_41_1] = var_0_0.combineTwoCard(var_41_0[var_41_1], var_41_0[var_41_1 + 1])

		table.remove(var_41_0, var_41_1 + 1)

		var_41_1 = var_0_0.getCombineIndexOnce(var_41_0)
		var_41_2 = var_41_2 + 1

		if var_41_2 == arg_41_1 then
			break
		end
	end

	return var_41_0, var_41_2
end

function var_0_0.combineTwoCard(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_2 and arg_42_2:clone() or arg_42_0:clone()

	var_42_0.skillId = var_0_0.getCombineSkillId(arg_42_0, arg_42_1, arg_42_2)
	var_42_0.tempCard = false

	FightCardDataHelper.enchantsAfterCombine(var_42_0, arg_42_1)

	if not var_42_0.uid or tonumber(var_42_0.uid) == 0 then
		var_42_0.uid = arg_42_1.uid
		var_42_0.cardType = arg_42_1.cardType
	end

	if var_42_0.heroId ~= arg_42_1.heroId then
		var_42_0.heroId = arg_42_1.heroId
	end

	var_42_0.energy = arg_42_0.energy + arg_42_1.energy
	var_42_0.heatId = var_42_0.uid and var_42_0.uid ~= "0" and var_42_0.heatId or arg_42_1.heatId

	return var_42_0
end

function var_0_0.getCombineSkillId(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0.uid
	local var_43_1 = arg_43_0.skillId

	if arg_43_2 then
		if arg_43_0 == arg_43_2 then
			var_43_1 = arg_43_0.skillId
			var_43_0 = arg_43_2.uid
		elseif arg_43_1 == arg_43_2 then
			var_43_1 = arg_43_1.skillId
			var_43_0 = arg_43_2.uid
		end
	end

	return var_0_0.instance:getSkillNextLvId(var_43_0, var_43_1)
end

function var_0_0.moveOnly(arg_44_0, arg_44_1, arg_44_2)
	if arg_44_2 < arg_44_1 then
		local var_44_0 = arg_44_0[arg_44_1]

		for iter_44_0 = arg_44_1, arg_44_2 + 1, -1 do
			arg_44_0[iter_44_0] = arg_44_0[iter_44_0 - 1]
		end

		arg_44_0[arg_44_2] = var_44_0
	elseif arg_44_1 < arg_44_2 then
		local var_44_1 = arg_44_0[arg_44_1]

		for iter_44_1 = arg_44_1, arg_44_2 - 1 do
			arg_44_0[iter_44_1] = arg_44_0[iter_44_1 + 1]
		end

		arg_44_0[arg_44_2] = var_44_1
	end
end

function var_0_0.getCombineIndexOnce(arg_45_0, arg_45_1, arg_45_2)
	if not arg_45_0 then
		return
	end

	for iter_45_0 = 1, #arg_45_0 - 1 do
		if arg_45_1 and arg_45_2 then
			if arg_45_1 == arg_45_0[iter_45_0] and arg_45_2 == arg_45_0[iter_45_0 + 1] then
				return iter_45_0
			elseif arg_45_2 == arg_45_0[iter_45_0] and arg_45_1 == arg_45_0[iter_45_0 + 1] then
				return iter_45_0
			end
		elseif FightCardDataHelper.canCombineCardForPerformance(arg_45_0[iter_45_0], arg_45_0[iter_45_0 + 1]) then
			return iter_45_0
		end
	end
end

function var_0_0.revertOp(arg_46_0)
	if #arg_46_0._cardOps > 0 then
		return table.remove(arg_46_0._cardOps, #arg_46_0._cardOps)
	end
end

function var_0_0.moveHandCardOp(arg_47_0, arg_47_1, arg_47_2, arg_47_3, arg_47_4)
	if arg_47_1 ~= arg_47_2 then
		local var_47_0 = FightBeginRoundOp.New()

		var_47_0:moveCard(arg_47_1, arg_47_2, arg_47_3, arg_47_4)
		table.insert(arg_47_0._cardOps, var_47_0)

		return var_47_0
	end
end

function var_0_0.moveUniversalCardOp(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4, arg_48_5)
	if arg_48_1 ~= arg_48_2 then
		local var_48_0 = FightBeginRoundOp.New()

		var_48_0:moveUniversalCard(arg_48_1, arg_48_2, arg_48_3, arg_48_4, arg_48_5)
		table.insert(arg_48_0._cardOps, var_48_0)

		return var_48_0
	end
end

function var_0_0.playHandCardOp(arg_49_0, arg_49_1, arg_49_2, arg_49_3, arg_49_4, arg_49_5, arg_49_6)
	local var_49_0 = FightBeginRoundOp.New()
	local var_49_1 = arg_49_2 or arg_49_0.curSelectEntityId

	if var_49_1 == 0 then
		local var_49_2 = FightHelper.getTargetLimits(FightEnum.EntitySide.MySide, arg_49_3)

		if #var_49_2 > 0 then
			var_49_1 = var_49_2[1]
		end
	end

	var_49_0:playCard(arg_49_1, var_49_1, arg_49_3, arg_49_4, arg_49_5, arg_49_6)
	table.insert(arg_49_0._cardOps, var_49_0)

	return var_49_0
end

function var_0_0.playAssistBossHandCardOp(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = FightBeginRoundOp.New()
	local var_50_1 = arg_50_2 or arg_50_0.curSelectEntityId

	if var_50_1 == 0 then
		local var_50_2 = FightHelper.getTargetLimits(FightEnum.EntitySide.MySide, arg_50_1)

		if #var_50_2 > 0 then
			var_50_1 = var_50_2[1]
		end
	end

	var_50_0:playAssistBossHandCard(arg_50_1, var_50_1)
	table.insert(arg_50_0._cardOps, var_50_0)

	return var_50_0
end

function var_0_0.playPlayerFinisherSkill(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0 = FightBeginRoundOp.New()

	var_51_0:playPlayerFinisherSkill(arg_51_1, arg_51_2)
	table.insert(arg_51_0._cardOps, var_51_0)

	return var_51_0
end

function var_0_0.simulateDissolveCard(arg_52_0, arg_52_1)
	local var_52_0 = FightBeginRoundOp.New()

	var_52_0:simulateDissolveCard(arg_52_1)
	table.insert(arg_52_0._cardOps, var_52_0)

	return var_52_0
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

function var_0_0.getHandCardContainerScale(arg_53_0, arg_53_1, arg_53_2)
	local var_53_0 = #(arg_53_2 or arg_53_0:getHandCards())
	local var_53_1 = var_0_1[var_53_0] or 1

	if var_53_0 > 20 then
		var_53_1 = 0.4
	end

	if arg_53_1 and var_53_0 >= 8 then
		var_53_1 = var_53_1 * 0.9
	end

	return var_53_1
end

function var_0_0.getSkillLv(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = FightDataHelper.entityMgr:getById(arg_54_1)

	if var_54_0 then
		return var_54_0:getSkillLv(arg_54_2)
	end

	return FightConfig.instance:getSkillLv(arg_54_2)
end

function var_0_0.getSkillNextLvId(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = FightDataHelper.entityMgr:getById(arg_55_1)

	if var_55_0 then
		return var_55_0:getSkillNextLvId(arg_55_2)
	end

	return FightConfig.instance:getSkillNextLvId(arg_55_2)
end

function var_0_0.getSkillPrevLvId(arg_56_0, arg_56_1, arg_56_2)
	local var_56_0 = FightDataHelper.entityMgr:getById(arg_56_1)

	if var_56_0 then
		return var_56_0:getSkillPrevLvId(arg_56_2)
	end

	return FightConfig.instance:getSkillPrevLvId(arg_56_2)
end

function var_0_0.isUniqueSkill(arg_57_0, arg_57_1, arg_57_2)
	local var_57_0 = FightDataHelper.entityMgr:getById(arg_57_1)

	if var_57_0 then
		return var_57_0:isUniqueSkill(arg_57_2)
	end

	return FightConfig.instance:isUniqueSkill(arg_57_2)
end

function var_0_0.isActiveSkill(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = FightDataHelper.entityMgr:getById(arg_58_1)

	if var_58_0 then
		return var_58_0:isActiveSkill(arg_58_2)
	end

	return FightConfig.instance:isActiveSkill(arg_58_2)
end

function var_0_0.isUnlimitMoveCard(arg_59_0)
	return arg_59_0._cardMO and arg_59_0._cardMO:isUnlimitMoveCard()
end

var_0_0.instance = var_0_0.New()

return var_0_0
