module("modules.logic.fight.model.FightCardModel", package.seeall)

slot0 = class("FightCardModel", BaseModel)

function slot0.onInit(slot0)
	slot0._cardMO = FightCardMO.New()
	slot0._distributeQueue = {}
	slot0._cardOps = {}
	slot0.curSelectEntityId = 0
	slot0.nextRoundActPoint = nil
	slot0.nextRoundMoveNum = nil
	slot0._universalCardMO = nil
	slot0._beCombineCardMO = nil
	slot0.redealCardInfoList = nil
	slot0._dissolvingCard = nil
	slot0._changingCard = nil
	slot0._longPressIndex = -1
end

function slot0.getLongPressIndex(slot0)
	return slot0._longPressIndex
end

function slot0.setLongPressIndex(slot0, slot1)
	slot0._longPressIndex = slot1
end

function slot0.clear(slot0)
	slot0.redealCardInfoList = nil
	slot0._dissolvingCard = nil
	slot0._changingCard = nil

	slot0:clearCardOps()

	if slot0._cardMO then
		slot0._cardMO:reset()
	end

	slot0:clearDistributeQueue()
end

function slot0.setDissolving(slot0, slot1)
	if FightModel.instance:getVersion() >= 1 then
		return
	end

	slot0._dissolvingCard = slot1
end

function slot0.setChanging(slot0, slot1)
	slot0._changingCard = slot1
end

function slot0.isDissolving(slot0)
	return slot0._dissolvingCard
end

function slot0.isChanging(slot0)
	return slot0._changingCard
end

function slot0.setUniversalCombine(slot0, slot1, slot2)
	slot0._universalCardMO = slot1
	slot0._beCombineCardMO = slot2
end

function slot0.getUniversalCardMO(slot0)
	return slot0._universalCardMO
end

function slot0.getBeCombineCardMO(slot0)
	return slot0._beCombineCardMO
end

function slot0.enqueueDistribute(slot0, slot1, slot2)
	slot3 = tabletool.copy(slot1)

	if #tabletool.copy(slot2) > 0 then
		while #slot4 > 0 do
			slot5 = #slot4
			slot6 = 1
			slot7 = tabletool.copy(slot3)

			while #slot4 > 0 do
				table.insert(slot7, table.remove(slot4, 1))

				if uv0.getCombineIndexOnce(slot7) then
					break
				end
			end

			slot8 = {}

			for slot12 = #slot3 + 1, #slot7 do
				table.insert(slot8, slot7[slot12])
			end

			table.insert(slot0._distributeQueue, {
				slot3,
				slot8
			})

			slot3 = uv0.calcCardsAfterCombine(slot7)
		end
	else
		table.insert(slot0._distributeQueue, {
			slot3,
			slot4
		})
	end
end

function slot0.dequeueDistribute(slot0)
	if #slot0._distributeQueue > 0 then
		slot1 = table.remove(slot0._distributeQueue, 1)

		return slot1[1], slot1[2]
	end
end

function slot0.clearDistributeQueue(slot0)
	slot0._distributeQueue = {}
end

function slot0.getDistributeQueueLen(slot0)
	return #slot0._distributeQueue
end

function slot0.applyNextRoundActPoint(slot0)
	if slot0.nextRoundActPoint and slot0.nextRoundActPoint > 0 then
		slot0._cardMO.actPoint = slot0.nextRoundActPoint
		slot0._cardMO.moveNum = slot0.nextRoundMoveNum
		slot0.nextRoundActPoint = nil
		slot0.nextRoundMoveNum = nil
	end
end

function slot0.getEntityOps(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in ipairs(slot0._cardOps) do
		if slot8.belongToEntityId == slot1 and (not slot2 or slot8.operType == slot2) then
			table.insert(slot3, slot8)
		end
	end

	return slot3
end

function slot0.setCurSelectEntityId(slot0, slot1)
	slot0.curSelectEntityId = slot1
end

function slot0.resetCurSelectEntityIdDefault(slot0)
	if FightModel.instance:isAuto() then
		if FightHelper.canSelectEnemyEntity(slot0.curSelectEntityId) then
			slot0:setCurSelectEntityId(slot0.curSelectEntityId)
		else
			slot0:setCurSelectEntityId(0)
		end
	else
		if FightDataHelper.entityMgr:getById(slot0.curSelectEntityId) and slot1:isStatusDead() then
			slot1 = nil
		end

		if slot1 and slot1.side == FightEnum.EntitySide.MySide then
			slot0.curSelectEntityId = 0
			slot1 = nil
		end

		if slot0.curSelectEntityId ~= 0 and slot1 ~= nil and not (slot1 and slot1:hasBuffFeature(FightEnum.BuffType_CantSelect)) and not (slot1 and slot1:hasBuffFeature(FightEnum.BuffType_CantSelectEx)) then
			return
		end

		for slot9 = #FightDataHelper.entityMgr:getEnemyNormalList(), 1, -1 do
			if slot5[slot9]:hasBuffFeature(FightEnum.BuffType_CantSelect) or slot10:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
				table.remove(slot5, slot9)
			end
		end

		if #slot5 > 0 then
			table.sort(slot5, function (slot0, slot1)
				return slot0.position < slot1.position
			end)
			slot0:setCurSelectEntityId(slot5[1].id)
		end
	end
end

function slot0.getSelectEnemyPosLOrR(slot0, slot1)
	for slot6 = #FightDataHelper.entityMgr:getEnemyNormalList(), 1, -1 do
		if slot2[slot6]:hasBuffFeature(FightEnum.BuffType_CantSelect) or slot7:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
			table.remove(slot2, slot6)
		end
	end

	if #slot2 > 0 then
		table.sort(slot2, function (slot0, slot1)
			return slot0.position < slot1.position
		end)

		for slot6 = 1, #slot2 do
			if slot2[slot6].id == slot0.curSelectEntityId then
				if slot1 == 1 and slot6 < #slot2 then
					return slot2[slot6 + 1].id
				elseif slot1 == 2 and slot6 > 1 then
					return slot2[slot6 - 1].id
				end
			end
		end
	end
end

function slot0.onStartRound(slot0)
	slot0:getCardMO():setExtraMoveAct(0)
end

function slot0.onEndRound(slot0)
end

function slot0.getCardMO(slot0)
	return slot0._cardMO
end

function slot0.getCardOps(slot0)
	return slot0._cardOps
end

function slot0.resetCardOps(slot0)
	slot0._cardOps = {}

	for slot5, slot6 in ipairs(FightDataHelper.entityMgr:getMyNormalList()) do
		slot6:resetSimulateExPoint()
	end

	for slot5, slot6 in ipairs(FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.MySide)) do
		slot6:resetSimulateExPoint()
	end
end

function slot0.clearCardOps(slot0)
	slot0._cardOps = {}
end

function slot0.getShowOpActList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0._cardOps) do
		if uv0.instance:canShowOpAct(slot6) then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.canShowOpAct(slot0, slot1)
	if not slot1:isMoveUniversal() and (not slot1:isMoveCard() or not slot0._cardMO:isUnlimitMoveCard() or slot1:isPlayCard()) then
		return true
	end
end

function slot0.getPlayCardOpList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0._cardOps) do
		if slot6:isPlayCard() then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.getMoveCardOpList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0._cardOps) do
		if slot6:isMoveCard() then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.getMoveCardOpCostActList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0._cardOps) do
		if slot6:isMoveCard() then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.updateCard(slot0, slot1)
	slot0:clearCardOps()
	slot0._cardMO:init(slot1)
end

function slot0.coverCard(slot0, slot1)
	if not slot1 then
		logError("覆盖卡牌序列,传入的数据为空")
	end

	slot0._cardMO:setCards(slot1)
end

function slot0.getHandCards(slot0)
	return slot0:getHandCardsByOps(slot0._cardOps)
end

function slot0.getHandCardData(slot0)
	return slot0._cardMO and slot0._cardMO.cardGroup
end

function slot0.getHandCardsByOps(slot0, slot1)
	return slot0:tryGettingHandCardsByOps(slot1) or {}
end

function slot0.tryGettingHandCardsByOps(slot0, slot1)
	if not slot0._cardMO then
		return nil
	end

	slot2, slot3 = nil
	slot4 = tabletool.copy(slot0._cardMO.cardGroup)

	for slot8, slot9 in ipairs(slot1) do
		slot10 = false

		if slot9:isMoveCard() then
			slot2, slot3 = nil

			if not slot4[slot9.param1] then
				return nil
			end

			if not slot4[slot9.param2] then
				return nil
			end

			uv0.moveOnly(slot4, slot9.param1, slot9.param2)
		elseif slot9:isPlayCard() then
			slot2, slot3 = nil

			if not slot4[slot9.param1] then
				return nil
			end

			table.remove(slot4, slot9.param1)

			if slot9.param2 and slot9.params ~= 0 then
				slot10 = true
			end
		elseif slot9:isMoveUniversal() then
			slot2 = slot4[slot9.param1]
			slot3 = slot4[slot9.param2]

			if not slot4[slot9.param1] then
				return nil
			end

			if not slot4[slot9.param2] then
				return nil
			end

			uv0.moveOnly(slot4, slot9.param1, slot9.moveToIndex)
		elseif slot9:isSimulateDissolveCard() then
			table.remove(slot4, slot9.dissolveIndex)
		end

		if slot10 then
			table.remove(slot4, slot9.param2)

			slot11 = uv0.getCombineIndexOnce(slot4, slot2, slot3)

			while #slot4 >= 2 and slot11 do
				slot4[slot11] = uv0.combineTwoCard(slot4[slot11], slot4[slot11 + 1], slot3)

				table.remove(slot4, slot11 + 1)

				slot2, slot3 = nil
				slot11 = uv0.getCombineIndexOnce(slot4)
			end
		end

		slot11 = uv0.getCombineIndexOnce(slot4, slot2, slot3)

		while #slot4 >= 2 and slot11 do
			slot4[slot11] = uv0.combineTwoCard(slot4[slot11], slot4[slot11 + 1], slot3)

			table.remove(slot4, slot11 + 1)

			slot2, slot3 = nil
			slot11 = uv0.getCombineIndexOnce(slot4)
		end
	end

	return slot4
end

function slot0.isCardOpEnd(slot0)
	if not uv0.instance:getCardMO() then
		return true
	end

	if #uv0.instance:getHandCards() == 0 then
		return true
	end

	slot6 = 0

	for slot10, slot11 in ipairs(uv0.instance:getCardOps()) do
		if slot11:isPlayCard() then
			slot5 = 0 + slot11.costActPoint
		elseif slot11:isMoveCard() then
			if not slot0._cardMO:isUnlimitMoveCard() and slot0._cardMO.extraMoveAct < slot6 + 1 then
				slot5 = slot5 + slot11.costActPoint
			end
		end
	end

	slot7 = slot1.actPoint

	if FightModel.instance:isSeason2() then
		slot7 = 1

		if #slot4 >= 1 then
			return true
		end
	end

	if slot7 <= slot5 then
		return true
	end

	if FightCardDataHelper.allFrozenCard(slot2) then
		return true
	end

	return false
end

function slot0.calcCardsAfterCombine(slot0, slot1)
	slot3 = uv0.getCombineIndexOnce(tabletool.copy(slot0))
	slot4 = 0

	while slot3 do
		slot2[slot3] = uv0.combineTwoCard(slot2[slot3], slot2[slot3 + 1])

		table.remove(slot2, slot3 + 1)

		slot3 = uv0.getCombineIndexOnce(slot2)

		if slot4 + 1 == slot1 then
			break
		end
	end

	return slot2, slot4
end

function slot0.combineTwoCard(slot0, slot1, slot2)
	slot3 = slot2 and slot2:clone() or slot0:clone()
	slot3.skillId = uv0.getCombineSkillId(slot0, slot1, slot2)
	slot3.tempCard = false

	FightCardDataHelper.enchantsAfterCombine(slot3, slot1)

	if not slot3.uid or tonumber(slot3.uid) == 0 then
		slot3.uid = slot1.uid
		slot3.cardType = slot1.cardType
	end

	if slot3.heroId ~= slot1.heroId then
		slot3.heroId = slot1.heroId
	end

	slot3.energy = slot0.energy + slot1.energy

	return slot3
end

function slot0.getCombineSkillId(slot0, slot1, slot2)
	slot3 = slot0.uid
	slot4 = slot0.skillId

	if slot2 then
		if slot0 == slot2 then
			slot4 = slot0.skillId
			slot3 = slot2.uid
		elseif slot1 == slot2 then
			slot4 = slot1.skillId
			slot3 = slot2.uid
		end
	end

	return uv0.instance:getSkillNextLvId(slot3, slot4)
end

function slot0.moveOnly(slot0, slot1, slot2)
	if slot2 < slot1 then
		slot3 = slot0[slot1]

		for slot7 = slot1, slot2 + 1, -1 do
			slot0[slot7] = slot0[slot7 - 1]
		end

		slot0[slot2] = slot3
	elseif slot1 < slot2 then
		slot3 = slot0[slot1]

		for slot7 = slot1, slot2 - 1 do
			slot0[slot7] = slot0[slot7 + 1]
		end

		slot0[slot2] = slot3
	end
end

function slot0.getCombineIndexOnce(slot0, slot1, slot2)
	if not slot0 then
		return
	end

	for slot6 = 1, #slot0 - 1 do
		if slot1 and slot2 then
			if slot1 == slot0[slot6] and slot2 == slot0[slot6 + 1] then
				return slot6
			elseif slot2 == slot0[slot6] and slot1 == slot0[slot6 + 1] then
				return slot6
			end
		elseif FightCardDataHelper.canCombineCardForPerformance(slot0[slot6], slot0[slot6 + 1]) then
			return slot6
		end
	end
end

function slot0.revertOp(slot0)
	if #slot0._cardOps > 0 then
		return table.remove(slot0._cardOps, #slot0._cardOps)
	end
end

function slot0.moveHandCardOp(slot0, slot1, slot2, slot3, slot4)
	if slot1 ~= slot2 then
		slot5 = FightBeginRoundOp.New()

		slot5:moveCard(slot1, slot2, slot3, slot4)
		table.insert(slot0._cardOps, slot5)

		return slot5
	end
end

function slot0.moveUniversalCardOp(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot1 ~= slot2 then
		slot6 = FightBeginRoundOp.New()

		slot6:moveUniversalCard(slot1, slot2, slot3, slot4, slot5)
		table.insert(slot0._cardOps, slot6)

		return slot6
	end
end

function slot0.playHandCardOp(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = FightBeginRoundOp.New()

	if (slot2 or slot0.curSelectEntityId) == 0 and #FightHelper.getTargetLimits(FightEnum.EntitySide.MySide, slot3) > 0 then
		slot8 = slot9[1]
	end

	slot7:playCard(slot1, slot8, slot3, slot4, slot5, slot6)
	table.insert(slot0._cardOps, slot7)

	return slot7
end

function slot0.playAssistBossHandCardOp(slot0, slot1, slot2)
	slot3 = FightBeginRoundOp.New()

	if (slot2 or slot0.curSelectEntityId) == 0 and #FightHelper.getTargetLimits(FightEnum.EntitySide.MySide, slot1) > 0 then
		slot4 = slot5[1]
	end

	slot3:playAssistBossHandCard(slot1, slot4)
	table.insert(slot0._cardOps, slot3)

	return slot3
end

function slot0.playPlayerFinisherSkill(slot0, slot1, slot2)
	slot3 = FightBeginRoundOp.New()

	slot3:playPlayerFinisherSkill(slot1, slot2)
	table.insert(slot0._cardOps, slot3)

	return slot3
end

function slot0.simulateDissolveCard(slot0, slot1)
	slot2 = FightBeginRoundOp.New()

	slot2:simulateDissolveCard(slot1)
	table.insert(slot0._cardOps, slot2)

	return slot2
end

slot1 = {
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

function slot0.getHandCardContainerScale(slot0, slot1, slot2)
	slot5 = uv0[#(slot2 or slot0:getHandCards())] or 1

	if slot4 > 20 then
		slot5 = 0.4
	end

	if slot1 and slot4 >= 8 then
		slot5 = slot5 * 0.9
	end

	return slot5
end

function slot0.getSkillLv(slot0, slot1, slot2)
	if FightDataHelper.entityMgr:getById(slot1) then
		return slot3:getSkillLv(slot2)
	end

	return FightConfig.instance:getSkillLv(slot2)
end

function slot0.getSkillNextLvId(slot0, slot1, slot2)
	if FightDataHelper.entityMgr:getById(slot1) then
		return slot3:getSkillNextLvId(slot2)
	end

	return FightConfig.instance:getSkillNextLvId(slot2)
end

function slot0.getSkillPrevLvId(slot0, slot1, slot2)
	if FightDataHelper.entityMgr:getById(slot1) then
		return slot3:getSkillPrevLvId(slot2)
	end

	return FightConfig.instance:getSkillPrevLvId(slot2)
end

function slot0.isUniqueSkill(slot0, slot1, slot2)
	if FightDataHelper.entityMgr:getById(slot1) then
		return slot3:isUniqueSkill(slot2)
	end

	return FightConfig.instance:isUniqueSkill(slot2)
end

function slot0.isActiveSkill(slot0, slot1, slot2)
	if FightDataHelper.entityMgr:getById(slot1) then
		return slot3:isActiveSkill(slot2)
	end

	return FightConfig.instance:isActiveSkill(slot2)
end

function slot0.isUnlimitMoveCard(slot0)
	return slot0._cardMO and slot0._cardMO:isUnlimitMoveCard()
end

slot0.instance = slot0.New()

return slot0
