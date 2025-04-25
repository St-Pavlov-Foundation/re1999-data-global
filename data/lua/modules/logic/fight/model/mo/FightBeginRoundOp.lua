module("modules.logic.fight.model.mo.FightBeginRoundOp", package.seeall)

slot0 = pureTable("FightBeginRoundOp")

function slot0.ctor(slot0)
	slot0.operType = nil
	slot0.param1 = nil
	slot0.param2 = nil
	slot0.toId = nil
	slot0.skillId = nil
	slot0.belongToEntityId = nil
	slot0.moveToIndex = nil
	slot0.costActPoint = 1
	slot0._needCopyCard = nil
	slot0.cardColor = FightEnum.CardColor.None
end

function slot0.init(slot0, slot1)
	slot0.operType = slot1.operType
	slot0.param1 = slot1.param1
	slot0.param2 = slot1.param2
	slot0.toId = slot1.toId
end

function slot0.moveCard(slot0, slot1, slot2, slot3, slot4)
	slot0.operType = FightEnum.CardOpType.MoveCard
	slot0.param1 = slot1
	slot0.param2 = slot2
	slot0.skillId = slot3
	slot0.belongToEntityId = slot4
	slot0.moveToIndex = slot2
end

function slot0.moveUniversalCard(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.operType = FightEnum.CardOpType.MoveUniversal
	slot0.param1 = slot1
	slot0.param2 = slot2
	slot0.skillId = slot3
	slot0.belongToEntityId = slot4
	slot0.moveToIndex = slot5
	slot0.costActPoint = 0
end

function slot0.playCard(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.operType = FightEnum.CardOpType.PlayCard
	slot0.param1 = slot1
	slot0.param2 = slot6
	slot0.toId = slot2
	slot0.skillId = slot3
	slot0.belongToEntityId = slot4

	if FightCardDataHelper.isSpecialCardById(slot4, slot3) then
		if slot5.cardType == FightEnum.CardType.ROUGE_SP or slot5.cardType == FightEnum.CardType.USE_ACT_POINT then
			slot0.costActPoint = 1
		else
			slot0.costActPoint = 0
		end
	end

	slot0.clientSimulateCanPlayCard = FightViewHandCardItemLock.canUseCardSkill(slot0.belongToEntityId, slot0.skillId, FightBuffHelper.simulateBuffList(FightDataHelper.entityMgr:getById(slot0.belongToEntityId)))
	slot0.cardInfoMO = FightCardInfoMO.New()

	slot0.cardInfoMO:init(slot5)
end

function slot0.playAssistBossHandCard(slot0, slot1, slot2)
	slot0.operType = FightEnum.CardOpType.AssistBoss
	slot0.param1 = slot1
	slot0.toId = slot2
	slot0.skillId = slot1
	slot0.belongToEntityId = FightDataHelper.entityMgr:getAssistBoss().id
	slot0.costActPoint = 0
end

function slot0.playPlayerFinisherSkill(slot0, slot1, slot2)
	slot0.operType = FightEnum.CardOpType.PlayerFinisherSkill
	slot0.param1 = slot1
	slot0.toId = slot2
	slot0.skillId = slot1
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

function slot0.isSeason2ChangeHero(slot0)
	return slot0.operType == FightEnum.CardOpType.Season2ChangeHero
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
