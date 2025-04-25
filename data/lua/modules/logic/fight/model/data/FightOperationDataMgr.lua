module("modules.logic.fight.model.data.FightOperationDataMgr", package.seeall)

slot0 = FightDataClass("FightOperationDataMgr")
slot0.StateType = {
	PlayHandCard = GameUtil.getEnumId(),
	PlayAssistBossCard = GameUtil.getEnumId(),
	PlayPlayerFinisherSkill = GameUtil.getEnumId(),
	MoveHandCard = GameUtil.getEnumId()
}

function slot0.onConstructor(slot0)
	slot0.operationStates = {}
	slot0.operationList = {}
	slot0.extraMoveUsedCount = 0
	slot0.playerFinisherSkillUsedCount = nil
end

function slot0.clearClientSimulationData(slot0)
	tabletool.clear(slot0.operationList)
	tabletool.clear(slot0.operationStates)

	slot0.extraMoveUsedCount = 0
	slot0.playerFinisherSkillUsedCount = nil
end

function slot0.onCancelOperation(slot0)
	slot0:clearClientSimulationData()
end

function slot0.onStageChanged(slot0)
	if #slot0.operationStates > 0 then
		logError("战斗阶段改变了，但是操作状态列表中还有值，")
	end

	slot0:clearClientSimulationData()
end

function slot0.enterOperationState(slot0, slot1)
	table.insert(slot0.operationStates, slot1)
end

function slot0.exitOperationState(slot0, slot1)
	for slot5 = #slot0.operationStates, 1, -1 do
		if slot0.operationStates[slot5] == slot1 then
			table.remove(slot0.operationStates, slot5)
		end
	end
end

function slot0.addOperation(slot0, slot1)
	table.insert(slot0.operationList, slot1)
end

function slot0.newOperation(slot0)
	slot1 = FightOperationItemData.New()

	table.insert(slot0.operationList, slot1)

	return slot1
end

function slot0.getEntityOps(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in ipairs(slot0.operationList) do
		if slot8.belongToEntityId == slot1 and (not slot2 or slot8.operType == slot2) then
			table.insert(slot3, slot8)
		end
	end

	return slot3
end

function slot0.getShowOpActList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.operationList) do
		if slot0:canShowOpAct(slot6) then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.canShowOpAct(slot0, slot1)
	if not slot1:isMoveUniversal() and (not slot1:isMoveCard() or not FightCardModel.instance._cardMO:isUnlimitMoveCard() or slot1:isPlayCard()) then
		return true
	end
end

function slot0.getPlayCardOpList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.operationList) do
		if slot6:isPlayCard() then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.getMoveCardOpList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.operationList) do
		if slot6:isMoveCard() then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.getMoveCardOpCostActList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.operationList) do
		if slot6:isMoveCard() then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.isCardOpEnd(slot0)
	if #slot0.dataMgr.handCardMgr.handCard == 0 then
		return true
	end

	slot3 = slot0.dataMgr.fieldMgr
	slot6 = 0

	for slot10, slot11 in ipairs(slot0.operationList) do
		if slot11:isPlayCard() then
			slot5 = 0 + slot11.costActPoint
		elseif slot11:isMoveCard() then
			if not slot3:isUnlimitMoveCard() and slot3.extraMoveAct < slot6 + 1 then
				slot5 = slot5 + slot11.costActPoint
			end
		end
	end

	slot7 = slot3.actPoint

	if slot3:isSeason2() then
		slot7 = 1

		if #slot4 >= 1 then
			return true
		end
	end

	if slot7 <= slot5 then
		return true
	end

	if FightCardDataHelper.allFrozenCard(slot1) then
		return true
	end

	return false
end

function slot0.getLeftExtraMoveCount(slot0)
	if slot0.dataMgr.fieldMgr.extraMoveAct < 0 then
		return slot0.dataMgr.fieldMgr.extraMoveAct
	end

	return slot0.dataMgr.fieldMgr.extraMoveAct - slot0.extraMoveUsedCount
end

return slot0
