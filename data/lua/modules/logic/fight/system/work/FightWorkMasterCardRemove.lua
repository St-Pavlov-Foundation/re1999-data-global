module("modules.logic.fight.system.work.FightWorkMasterCardRemove", package.seeall)

slot0 = class("FightWorkMasterCardRemove", FightEffectBase)

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0._actEffectMO) then
		slot0:onDone(true)

		return
	end

	slot0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	if #string.splitToNumber(slot0._actEffectMO.reserveStr, "#") > 0 then
		AudioMgr.instance:trigger(20190020)
		table.sort(slot1, FightWorkCardRemove2.sort)

		slot7 = 0.7
		slot3 = FightCardDataHelper.calcRemoveCardTime(tabletool.copy(FightCardModel.instance:getHandCards()), slot1, slot7)

		for slot7, slot8 in ipairs(slot1) do
			table.remove(slot2, slot8)
		end

		FightCardModel.instance:coverCard(slot2)

		if FightModel.instance:getVersion() >= 4 then
			slot0:com_registTimer(slot0._delayAfterPerformance, slot3 / FightModel.instance:getUISpeed())
			FightController.instance:dispatchEvent(FightEvent.MasterCardRemove, slot1)
		else
			FightCardModel.instance:coverCard(FightCardModel.calcCardsAfterCombine(slot2))
			FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
			slot0:onDone(true)
		end

		return
	end

	slot0:onDone(true)
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
