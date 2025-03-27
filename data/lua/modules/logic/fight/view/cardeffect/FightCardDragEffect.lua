module("modules.logic.fight.view.cardeffect.FightCardDragEffect", package.seeall)

slot0 = class("FightCardDragEffect", BaseWork)
slot1 = "ui/viewres/fight/ui_effect_dna_b.prefab"
slot2, slot3 = nil
slot5 = 1 * 0.033

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._dt = uv1 / FightModel.instance:getUISpeed()
	slot0._tweenIds = {}
	slot0._dragItem = slot1.handCardItemList[slot1.index]
	slot0._position = slot1.position
	slot0._cardCount = slot1.cardCount
	slot0._handCardTr = slot1.handCardTr
	slot0._handCards = slot1.handCards

	gohelper.setAsLastSibling(slot0._dragItem.go)

	slot0._dragScale, slot3, slot4 = transformhelper.getLocalScale(slot0._dragItem.tr)
	slot0._prevIndex = slot0.context.index
	slot0._after_drag_card_list = {}

	for slot8 = 1, #slot0.context.handCardItemList do
		table.insert(slot0._after_drag_card_list, slot0.context.handCardItemList[slot8])
	end

	slot0._sequence = FlowSequence.New()

	slot0._sequence:addWork(FunctionWork.New(function ()
		uv0:_playCardSpringEffect(uv0.context.index)
	end))
	slot0._sequence:addWork(TweenWork.New({
		type = "DOTweenFloat",
		from = slot2,
		to = 1.14,
		t = slot0._dt * 5,
		frameCb = slot0._tweenFrameScale,
		cbObj = slot0
	}))
	slot0._sequence:registerDoneListener(slot0._onWorkDone, slot0)
	slot0._sequence:start()
	FightController.instance:registerCallback(FightEvent.DragHandCard, slot0._onDragHandCard, slot0)
	FightController.instance:registerCallback(FightEvent.CardLongPressEffectEnd, slot0._onCardLongPressEffectEnd, slot0)
end

function slot0._onCardLongPressEffectEnd(slot0)
	gohelper.setAsLastSibling(slot0._dragItem.go)
end

function slot0._tweenFrameScale(slot0, slot1)
	slot0._dragScale = slot1

	transformhelper.setLocalScale(slot0._dragItem.tr, slot0._dragScale, slot0._dragScale, 1)
	recthelper.setAnchorY(slot0._dragItem.tr, FightViewHandCard.HandCardHeight * (slot0._dragScale - 1) / 2)
end

function slot0._playCardSpringEffect(slot0, slot1)
	slot0:_killAllPosTween()

	for slot5 = 1, slot0._cardCount do
		if slot5 ~= slot1 then
			slot6 = slot0._after_drag_card_list[slot5]
			slot7 = 0

			if math.abs(slot5 - slot1) == 1 then
				slot7 = slot5 < slot1 and 8 or -8
			end

			table.insert(slot0._tweenIds, ZProj.TweenHelper.DOAnchorPosX(slot6.tr, FightViewHandCard.calcCardPosX(slot5) + slot7, 5 * slot0._dt, function ()
				uv0:_setCardsUniversalMatch(uv1)
			end))
		end
	end
end

function slot0.onStop(slot0)
	uv0.super.onStop(slot0)
	slot0._sequence:unregisterDoneListener(slot0._onWorkDone, slot0)

	if slot0._sequence.status == WorkStatus.Running then
		slot0._sequence:stop()
	end
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.DragHandCard, slot0._onDragHandCard, slot0)
	FightController.instance:unregisterCallback(FightEvent.CardLongPressEffectEnd, slot0._onCardLongPressEffectEnd, slot0)
	slot0:_killAllPosTween()
	slot0:_killDragTween()

	if uv0 then
		uv0:dispose()
	end

	uv0 = nil
	uv1 = nil
	slot0._after_drag_card_list = {}
end

function slot0._killDragTween(slot0)
	if slot0._drag_tween then
		ZProj.TweenHelper.KillById(slot0._drag_tween)

		slot0._drag_tween = nil
	end
end

function slot0._killAllPosTween(slot0)
	if slot0._tweenIds then
		for slot4, slot5 in ipairs(slot0._tweenIds) do
			ZProj.TweenHelper.KillById(slot5)
		end
	end

	slot0._tweenIds = {}
end

function slot0._onWorkDone(slot0)
	slot0._sequence:unregisterDoneListener(slot0._onWorkDone, slot0)
end

function slot0._onDragHandCard(slot0, slot1, slot2)
	slot0._position = slot2

	slot0:_updateDragHandCards()
end

function slot0._updateDragHandCards(slot0)
	slot1 = slot0.context.index
	slot5 = slot0.context.handCardItemList
	slot8 = FightViewHandCard.HandCardWidth * 0.5

	slot0:_killDragTween()

	if math.abs(recthelper.getAnchorX(slot0._dragItem.tr) - Mathf.Clamp(recthelper.screenPosToAnchorPos(slot0._position, slot0._handCardTr).x - FightViewHandCard.HalfWidth, -FightViewHandCard.calcTotalWidth(slot0._cardCount, 1) + slot8, -slot8)) > 20 then
		slot0._drag_tween = ZProj.TweenHelper.DOAnchorPosX(slot2.tr, slot9, 6 * slot0._dt)
	else
		recthelper.setAnchorX(slot2.tr, slot9)
	end

	slot0:_setCardsUniversalMatch(FightViewHandCard.calcCardIndexDraging(slot9, slot3, slot4))

	if slot0._prevIndex and slot11 ~= slot0._prevIndex then
		slot12 = Time.realtimeSinceStartup

		if not slot0._lastPlayTime or slot12 > slot0._lastPlayTime + 0.25 then
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_FightMoveCard)

			slot0._lastPlayTime = slot12
		end

		table.insert(slot0._after_drag_card_list, slot11, table.remove(slot0._after_drag_card_list, slot0._prevIndex))
		slot0:_playCardSpringEffect(slot11)
	end

	slot0._prevIndex = slot11
end

function slot0._setCardsUniversalMatch(slot0, slot1)
	uv0.setCardsUniversalMatch(slot0.context.handCardItemList, slot0._handCards, slot0.context.index, slot1, slot0._cardCount, true)
end

function slot0.setCardsUniversalMatch(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot1[slot2] then
		logError("dragCardMO = nil, dragIndex = " .. slot2 .. ", handCardCount = " .. #slot1)
	end

	slot9 = FightEnum.UniversalCard[slot6.skillId]
	slot10, slot11 = nil

	for slot15 = 1, slot4 do
		if slot15 ~= slot2 and recthelper.getAnchorX(slot0[slot2].tr) - recthelper.getAnchorX(slot0[slot15].tr) > 0 and (not slot10 or slot18 < slot10) and slot18 < 2 * FightViewHandCard.HandCardWidth then
			slot10 = slot18
			slot11 = slot15
		end
	end

	FightCardModel.instance:setUniversalCombine(nil, )

	slot12 = nil

	for slot16 = 1, slot4 do
		if slot16 ~= slot2 then
			slot0[slot16]:setUniversal(false)

			if slot9 and slot16 == slot11 and FightCardDataHelper.canCombineWithUniversalForPerformance(slot6, slot1[slot16]) then
				slot17:setUniversal(true)
				FightCardModel.instance:setUniversalCombine(slot6, slot1[slot16])

				slot12 = slot17
			end
		end
	end

	if slot5 then
		uv0._setUniversalLinkEffect(slot7, slot12)
	end

	slot0[slot2]:setUniversal(slot9 and FightCardModel.instance:getUniversalCardMO())
end

function slot0._setUniversalLinkEffect(slot0, slot1)
	if slot1 then
		if FightViewHandCard.HandCardWidth < recthelper.getAnchorX(slot0.tr) - recthelper.getAnchorX(slot1.tr) then
			if not uv0 then
				uv1 = gohelper.create2d(slot1.go, "linkEffect")
				uv0 = PrefabInstantiate.Create(uv1)

				uv0:startLoad(uv2)
			end

			gohelper.addChild(slot1.go, uv1)
			recthelper.setAnchorX(uv1.transform, 170)
		elseif uv1 then
			recthelper.setAnchorX(uv1.transform, 10000)
		end
	elseif uv1 then
		recthelper.setAnchorX(uv1.transform, 10000)
	end
end

return slot0
