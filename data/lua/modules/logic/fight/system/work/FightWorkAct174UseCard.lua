module("modules.logic.fight.system.work.FightWorkAct174UseCard", package.seeall)

slot0 = class("FightWorkAct174UseCard", FightEffectBase)

function slot0.onStart(slot0)
	if FightCardModel.instance:getHandCards()[slot0._actEffectMO.effectNum] then
		table.remove(slot1, slot2)

		slot0._finalCards = FightCardDataHelper.combineCardListForPerformance(FightDataHelper.coverData(slot1))

		slot0:com_registTimer(slot0._delayAfterPerformance, 5)
		slot0:com_registFightEvent(FightEvent.PlayCardOver, slot0._onPlayCardOver)
		FightViewPartVisible.set(false, true, true, false, false)
		slot0:com_sendFightEvent(FightEvent.PlayHandCard, slot2)
	else
		slot0:onDone(true)
	end
end

function slot0._onPlayCardOver(slot0)
	FightCardModel.instance:coverCard(slot0._finalCards)
	FightCardModel.instance:clearCardOps()
	slot0:com_sendFightEvent(FightEvent.RefreshHandCard)
	slot0:onDone(true)
end

return slot0
