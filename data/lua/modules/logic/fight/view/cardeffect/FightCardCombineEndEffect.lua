module("modules.logic.fight.view.cardeffect.FightCardCombineEndEffect", package.seeall)

slot0 = class("FightCardCombineEndEffect", BaseWork)

function slot0.onStart(slot0, slot1)
	if slot1.preCombineIndex and slot1.newCardCount > 0 then
		slot2 = slot1.preCombineIndex
		slot4 = slot1.handCardItemList

		for slot9 = 1, slot1.preCardCount do
			recthelper.setAnchorX(slot4[slot9].tr, slot1.oldPosXList[slot9])
		end

		slot0._flow = FightCardCombineEffect.buildCombineEndFlow(slot2, slot3, slot3, slot4)

		slot0._flow:registerDoneListener(slot0._onMoveEnd, slot0)
		slot0._flow:start()
	else
		slot0:onDone(true)
	end
end

function slot0._onMoveEnd(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._flow then
		slot0._flow:stop()
		slot0._flow:unregisterDoneListener(slot0._onBornEnd, slot0)
	end
end

return slot0
