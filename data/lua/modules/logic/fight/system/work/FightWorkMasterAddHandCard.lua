module("modules.logic.fight.system.work.FightWorkMasterAddHandCard", package.seeall)

slot0 = class("FightWorkMasterAddHandCard", FightEffectBase)

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0._actEffectMO) then
		slot0:onDone(true)

		return
	end

	slot0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)
	AudioMgr.instance:trigger(20190019)

	slot1 = FightCardInfoMO.New()

	slot1:init(slot0._actEffectMO.cardInfo)

	slot2 = FightCardModel.instance:getHandCards()

	table.insert(slot2, slot1)
	FightCardModel.instance:coverCard(slot2)

	if FightModel.instance:getVersion() >= 4 then
		FightController.instance:dispatchEvent(FightEvent.MasterAddHandCard, slot1)
		slot0:com_registTimer(slot0._delayAfterPerformance, 1 / FightModel.instance:getUISpeed())
	else
		FightCardModel.instance:coverCard(FightCardModel.calcCardsAfterCombine(slot2))
		FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
		slot0:onDone(true)
	end
end

function slot0._delayAfterPerformance(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return slot0
