module("modules.logic.fight.system.work.FightWorkCardRemove", package.seeall)

slot0 = class("FightWorkCardRemove", FightEffectBase)

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0._actEffectMO) then
		slot0:onDone(true)

		return
	end

	slot0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	if #string.splitToNumber(slot0._actEffectMO.reserveStr, "#") > 0 then
		table.sort(slot1, FightWorkCardRemove2.sort)

		slot3 = FightCardDataHelper.calcRemoveCardTime(tabletool.copy(FightCardModel.instance:getHandCards()), slot1)

		for slot7, slot8 in ipairs(slot1) do
			table.remove(slot2, slot8)
		end

		FightCardModel.instance:coverCard(slot2)

		if FightModel.instance:getVersion() >= 4 then
			slot0:com_registTimer(slot0._delayAfterPerformance, slot3 / FightModel.instance:getUISpeed())
			FightController.instance:dispatchEvent(FightEvent.CardRemove, slot1)
		else
			FightCardModel.instance:coverCard(FightCardModel.calcCardsAfterCombine(slot2))
			FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
			slot0:onDone(true)
		end

		return
	end

	slot0:onDone(true)
end

function slot0._onCombineDone(slot0)
	if slot0._finalCards then
		FightCardModel.instance:coverCard(slot0._finalCards)
	end

	slot0:onDone(true)
end

function slot0._delayAfterPerformance(slot0)
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	if slot0._finalCards then
		FightCardModel.instance:coverCard(slot0._finalCards)
	end

	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, slot0._onCombineDone, slot0)

	if slot0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return slot0
