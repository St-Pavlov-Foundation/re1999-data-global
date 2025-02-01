module("modules.logic.fight.view.cardeffect.FightCardDragEndEffect", package.seeall)

slot0 = class("FightCardDragEndEffect", BaseWork)
slot2 = 1 * 0.033

function slot0.ctor(slot0)
end

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._dt = uv1 / FightModel.instance:getUISpeed()
	slot0._dragItem = slot1.handCardItemList[slot1.index]
	slot0._cardCount = slot1.cardCount
	slot0._handCardTr = slot1.handCardTr
	slot0._targetIndex = slot1.targetIndex
	slot2, slot3, slot4 = transformhelper.getLocalScale(slot0._dragItem.tr)
	slot0._tweenWork = TweenWork.New({
		type = "DOTweenFloat",
		to = 1,
		from = slot2,
		t = slot0._dt * 4,
		frameCb = slot0._tweenFrameScale,
		cbObj = slot0
	})

	slot0._tweenWork:registerDoneListener(slot0._onWorkDone, slot0)
	slot0._tweenWork:onStart()
end

function slot0._tweenFrameScale(slot0, slot1)
	slot0._dragScale = slot1

	slot0:_updateDragHandCards()
end

function slot0._onWorkDone(slot0)
	FightCardDragEffect.setCardsUniversalMatch(slot0.context.handCardItemList, slot0.context.handCards, slot0.context.index, slot0.context.targetIndex, slot0.context.cardCount, false)
	slot0:onDone(true)
end

function slot0._updateDragHandCards(slot0)
	slot1 = slot0.context.index
	slot2 = slot0._dragItem
	slot4 = slot0._dragScale
	slot5 = slot0.context.handCardItemList

	recthelper.setAnchorY(slot2.tr, FightViewHandCard.HandCardHeight * (slot4 - 1) / 2)

	slot10 = slot4

	transformhelper.setLocalScale(slot2.tr, slot4, slot10, 1)

	for slot10 = 1, slot0._cardCount do
		slot11 = slot10

		if slot10 ~= slot1 then
			if slot1 < slot10 and slot10 <= slot0._targetIndex then
				slot11 = slot10 - 1
			elseif slot10 < slot1 and slot0._targetIndex <= slot10 then
				slot11 = slot10 + 1
			end
		else
			slot11 = slot0._targetIndex
		end

		slot12 = slot5[slot10]
		slot13 = recthelper.getAnchorX(slot12.tr)

		recthelper.setAnchorX(slot12.tr, FightViewHandCard.calcCardPosXDraging(slot11, slot3, slot0._targetIndex, slot4))
	end
end

function slot0.clearWork(slot0)
	if slot0._tweenWork then
		slot0._tweenWork:onStop()
		slot0._tweenWork:unregisterDoneListener(slot0._onWorkDone, slot0)

		slot0._tweenWork = nil
	end
end

return slot0
