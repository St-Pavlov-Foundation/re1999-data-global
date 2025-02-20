module("modules.logic.fight.system.work.FightWorkAddHandCard", package.seeall)

slot0 = class("FightWorkAddHandCard", FightEffectBase)

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0._actEffectMO) then
		slot0:onDone(true)

		return
	end

	slot0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)
	FightCardInfoMO.New():init(slot0._actEffectMO.cardInfo)

	if slot0._actEffectMO.cardInfo.skillId == 0 then
		slot2 = ""

		if FightLocalDataMgr.instance:getEntityById(slot0._actEffectMO.cardInfo.uid) then
			slot2 = slot3:getEntityName() or ""
		end

		logError(string.format("服务器下发了一张技能id为0的卡牌,卡牌归属者uid:%s,归属者名称:%s,所属步骤类型:%s, actId:%s", slot0._actEffectMO.cardInfo.uid, slot2, slot0._fightStepMO.actType, slot0._fightStepMO.actId))
	end

	slot2 = FightCardModel.instance:getHandCards()

	table.insert(slot2, slot1)
	FightCardModel.instance:coverCard(slot2)

	if FightModel.instance:getVersion() >= 4 then
		slot0:com_registTimer(slot0._delayAfterPerformance, 0.5)
		FightController.instance:dispatchEvent(FightEvent.AddHandCard, slot1)
	else
		FightCardModel.instance:coverCard(FightCardModel.calcCardsAfterCombine(slot2))
		FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	if slot0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return slot0
