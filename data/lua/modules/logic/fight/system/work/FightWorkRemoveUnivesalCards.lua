module("modules.logic.fight.system.work.FightWorkRemoveUnivesalCards", package.seeall)

slot0 = class("FightWorkRemoveUnivesalCards", FightEffectBase)

function slot0.onStart(slot0, slot1)
	if not FightCardDataHelper.cardChangeIsMySide(slot0._actEffectMO) then
		slot0:onDone(true)

		return
	end

	slot0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	slot2 = {}
	slot3 = FightCardModel.instance:getHandCards()
	slot4 = #slot3

	for slot8 = #slot3, 1, -1 do
		if FightEnum.UniversalCard[slot3[slot8].skillId] then
			table.insert(slot2, slot8)
			table.remove(slot3, slot8)
		end
	end

	if #slot2 > 0 then
		FightCardModel.instance:coverCard(slot3)

		slot5 = 0.033

		if FightModel.instance:getVersion() >= 4 then
			slot0:com_registTimer(slot0._delayAfterPerformance, (1.2 + slot5 * 7 + 3 * slot5 * (slot4 - #slot2)) / FightModel.instance:getUISpeed())
			FightController.instance:dispatchEvent(FightEvent.CardRemove, slot2)
		else
			FightCardModel.instance:coverCard(FightCardModel.calcCardsAfterCombine(slot3))
			FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
			slot0:onDone(true)
		end
	else
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
