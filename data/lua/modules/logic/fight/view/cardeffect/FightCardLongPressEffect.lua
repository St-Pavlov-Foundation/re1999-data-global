module("modules.logic.fight.view.cardeffect.FightCardLongPressEffect", package.seeall)

slot0 = class("FightCardLongPressEffect", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._dragItem = slot1.handCardItemList[slot1.index]
	slot0._cardCount = slot1.cardCount

	gohelper.setAsLastSibling(slot0._dragItem.go)

	slot2 = 0.033
	slot0._sequence = FlowSequence.New()

	slot0._sequence:addWork(TweenWork.New({
		from = 1,
		type = "DOTweenFloat",
		to = 0.9,
		t = slot2 * 3,
		frameCb = slot0._tweenFrameScale,
		cbObj = slot0
	}))
	slot0._sequence:addWork(TweenWork.New({
		from = 0.9,
		type = "DOTweenFloat",
		to = 1.2,
		t = slot2 * 4,
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

function slot0.onStop(slot0)
	uv0.super.onStop(slot0)
	slot0._sequence:stop()
end

function slot0._onWorkDone(slot0)
	slot0._sequence:unregisterDoneListener(slot0._onWorkDone, slot0)

	if slot0.context.handCardItemList[slot0.context.index].cardInfoMO and slot1.cardInfoMO.skillId then
		FightController.instance:dispatchEvent(FightEvent.ShowCardSkillTips, slot2, slot1.cardInfoMO.uid, slot1.cardInfoMO)
	end

	slot0:onDone(true)
end

function slot0._updateDragHandCards(slot0)
	slot2 = slot0._dragItem
	slot4 = slot0._dragScale

	recthelper.setAnchorY(slot2.tr, FightViewHandCard.HandCardHeight * (slot4 - 1) / 2)

	slot10 = slot4

	transformhelper.setLocalScale(slot2.tr, slot4, slot10, 1)

	for slot10 = 1, slot0._cardCount do
		slot11 = slot0.context.handCardItemList[slot10]
		slot12 = recthelper.getAnchorX(slot11.tr)

		recthelper.setAnchorX(slot11.tr, FightViewHandCard.calcCardPosXDraging(slot10, slot3, slot0.context.index, slot4))
	end
end

return slot0
