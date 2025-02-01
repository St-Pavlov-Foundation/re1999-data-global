module("modules.logic.fight.view.cardeffect.FightCardLongPressEndEffect", package.seeall)

slot0 = class("FightCardLongPressEndEffect", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._dragItem = slot1.handCardItemList[slot1.index]
	slot0._cardCount = slot1.cardCount

	gohelper.setAsLastSibling(slot0._dragItem.go)
	FightController.instance:dispatchEvent(FightEvent.CardLongPressEffectEnd)

	slot2, slot3, slot4 = transformhelper.getLocalScale(slot0._dragItem.tr)
	slot0._sequence = FlowSequence.New()

	slot0._sequence:addWork(TweenWork.New({
		type = "DOTweenFloat",
		to = 1,
		t = 0.05,
		from = slot2,
		frameCb = slot0._tweenFrameScale,
		cbObj = slot0
	}))
	slot0._sequence:registerDoneListener(slot0._onWorkDone, slot0)
	slot0._sequence:start()
end

function slot0._tweenFrameScale(slot0, slot1)
	slot0._dragScale = slot1

	slot0:_updateDragHandCards()
end

function slot0._onWorkDone(slot0)
	slot0._sequence:unregisterDoneListener(slot0._onWorkDone, slot0)
	slot0:onDone(true)
end

function slot0._updateDragHandCards(slot0)
	slot1 = slot0.context.index
	slot2 = slot0._dragItem
	slot3 = slot0._cardCount
	slot4 = slot0._dragScale

	recthelper.setAnchorY(slot2.tr, FightViewHandCard.HandCardHeight * (slot4 - 1) / 2)
	transformhelper.setLocalScale(slot2.tr, slot4, slot4, 1)

	if slot0.context.handCardItemList then
		for slot10 = 1, slot3 do
			slot11 = slot5[slot10]
			slot12 = recthelper.getAnchorX(slot11.tr)

			recthelper.setAnchorX(slot11.tr, FightViewHandCard.calcCardPosXDraging(slot10, slot3, slot1, slot4))
		end
	end
end

return slot0
