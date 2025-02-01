module("modules.logic.fight.system.work.FightWorkCardsCompose", package.seeall)

slot0 = class("FightWorkCardsCompose", FightEffectBase)

function slot0.onStart(slot0)
	slot0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	if FightCardModel.getCombineIndexOnce(FightCardModel.instance:getHandCards()) then
		slot0:com_registTimer(slot0._delayDone, 10)

		slot0._finalCards, slot0._count = FightCardModel.calcCardsAfterCombine(slot1)

		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, slot0._onCombineDone, slot0)
		FightController.instance:dispatchEvent(FightEvent.CardsCompose)
	else
		slot0:onDone(true)
	end
end

function slot0._onCombineDone(slot0)
	if slot0._finalCards then
		FightCardModel.instance:coverCard(slot0._finalCards)
	end

	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	if slot0._finalCards then
		FightCardModel.instance:coverCard(slot0._finalCards)
	end

	FightController.instance:dispatchEvent(FightEvent.CardsComposeTimeOut)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end

	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, slot0._onCombineDone, slot0)
end

return slot0
