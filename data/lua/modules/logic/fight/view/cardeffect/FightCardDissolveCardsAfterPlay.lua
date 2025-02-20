module("modules.logic.fight.view.cardeffect.FightCardDissolveCardsAfterPlay", package.seeall)

slot0 = class("FightCardDissolveCardsAfterPlay", BaseWork)

function slot0.onStart(slot0, slot1)
	FightController.instance:dispatchEvent(FightEvent.SetBlockCardOperate, true)

	if slot1.dissolveCardIndexsAfterPlay and #slot2 > 0 then
		TaskDispatcher.runDelay(slot0._delayDone, slot0, 10)
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, slot0._onCombineDone, slot0)

		slot3 = slot0.context.cards
		slot8 = slot3

		slot1.view:_updateHandCards(slot8)

		for slot8, slot9 in ipairs(slot2) do
			FightController.instance:dispatchEvent(FightEvent.CardRemove, {
				slot9
			}, FightCardDataHelper.calcRemoveCardTime2(slot3, slot2), true)
			table.remove(slot3, slot9)
		end

		return
	end

	slot0:onDone(true)
end

function slot0._onCombineDone(slot0)
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, slot0._onCombineDone, slot0)
end

return slot0
