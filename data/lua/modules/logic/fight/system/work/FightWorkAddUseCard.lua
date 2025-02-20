module("modules.logic.fight.system.work.FightWorkAddUseCard", package.seeall)

slot0 = class("FightWorkAddUseCard", FightEffectBase)

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0._actEffectMO) then
		slot0:onDone(true)

		return
	end

	if slot0._actEffectMO.effectNum - 1 > #FightPlayCardModel.instance:getUsedCards() then
		slot1 = #slot2 + 1
	end

	FightViewPartVisible.set(false, false, false, false, true)
	FightPlayCardModel.instance:addUseCard(slot1, slot0._actEffectMO.cardInfo)
	FightController.instance:dispatchEvent(FightEvent.AddUseCard, slot1)
	slot0:com_registTimer(slot0._delayAfterPerformance, 0.5 / FightModel.instance:getUISpeed())
end

function slot0.clearWork(slot0)
end

return slot0
