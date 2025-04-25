module("modules.logic.fight.model.data.FightOperationItemData", package.seeall)

slot0 = FightDataClass("FightOperationItemData")

function slot0.onConstructor(slot0)
	slot0.costActPoint = 0
end

function slot0.setByProto(slot0, slot1)
	slot0.operType = slot1.operType
	slot0.param1 = slot1.param1
	slot0.param2 = slot1.param2
	slot0.toId = slot1.toId
end

function slot0.moveCard(slot0, slot1, slot2)
	slot0.operType = FightEnum.CardOpType.MoveCard
	slot0.param1 = slot1
	slot0.param2 = slot2
	slot0.costActPoint = 1
end

function slot0.moveUniversalCard(slot0, slot1, slot2)
	slot0.operType = FightEnum.CardOpType.MoveUniversal
	slot0.param1 = slot1
	slot0.param2 = slot2
	slot0.costActPoint = 0
end

function slot0.playCard(slot0, slot1, slot2, slot3, slot4)
	slot0.operType = FightEnum.CardOpType.PlayCard
	slot0.param1 = slot1
	slot0.param2 = slot4
	slot0.toId = slot2
	slot0.costActPoint = 1
	slot0.skillId = slot3.skillId
	slot0.belongToEntityId = slot3.uid

	if FightCardDataHelper.isSpecialCardById(slot0.belongToEntityId, slot0.skillId) then
		if slot3.cardType == FightEnum.CardType.ROUGE_SP or slot3.cardType == FightEnum.CardType.USE_ACT_POINT then
			slot0.costActPoint = 1
		else
			slot0.costActPoint = 0
		end
	end

	slot0.clientSimulateCanPlayCard = FightViewHandCardItemLock.canUseCardSkill(slot0.belongToEntityId, slot0.skillId, FightBuffHelper.simulateBuffList(FightDataHelper.entityMgr:getById(slot0.belongToEntityId)))
	slot0.cardInfoMO = FightDataHelper.coverData(slot3, nil)
end

function slot0.playAssistBossHandCard(slot0, slot1, slot2)
	slot0.operType = FightEnum.CardOpType.AssistBoss
	slot0.param1 = slot1
	slot0.toId = slot2
	slot0.skillId = slot1
	slot0.belongToEntityId = FightDataHelper.entityMgr:getAssistBoss().id
	slot0.costActPoint = 0
end

function slot0.simulateDissolveCard(slot0, slot1)
	slot0.operType = FightEnum.CardOpType.SimulateDissolveCard
	slot0.dissolveIndex = slot1
	slot0.costActPoint = 0
end

function slot0.selectSkillTarget(slot0, slot1)
	slot0.toId = slot1
end

function slot0.isMoveCard(slot0)
	return slot0.operType == FightEnum.CardOpType.MoveCard
end

function slot0.isMoveUniversal(slot0)
	return slot0.operType == FightEnum.CardOpType.MoveUniversal
end

function slot0.isPlayCard(slot0)
	return slot0.operType == FightEnum.CardOpType.PlayCard
end

function slot0.isAssistBossPlayCard(slot0)
	return slot0.operType == FightEnum.CardOpType.AssistBoss
end

function slot0.isPlayerFinisherSkill(slot0)
	return slot0.operType == FightEnum.CardOpType.PlayerFinisherSkill
end

function slot0.isSimulateDissolveCard(slot0)
	return slot0.operType == FightEnum.CardOpType.SimulateDissolveCard
end

function slot0.copyCard(slot0)
	slot0._needCopyCard = 1
end

function slot0.needCopyCard(slot0)
	return slot0._needCopyCard == 1
end

return slot0
