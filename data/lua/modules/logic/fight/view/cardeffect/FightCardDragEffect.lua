module("modules.logic.fight.view.cardeffect.FightCardDragEffect", package.seeall)

local var_0_0 = class("FightCardDragEffect", BaseWork)
local var_0_1 = "ui/viewres/fight/ui_effect_dna_b.prefab"
local var_0_2
local var_0_3
local var_0_4 = 1
local var_0_5 = var_0_4 * 0.033

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0._dt = var_0_5 / FightModel.instance:getUISpeed()
	arg_1_0._tweenIds = {}
	arg_1_0._dragItem = arg_1_1.handCardItemList[arg_1_1.index]
	arg_1_0._position = arg_1_1.position
	arg_1_0._cardCount = arg_1_1.cardCount
	arg_1_0._handCardTr = arg_1_1.handCardTr
	arg_1_0._handCards = arg_1_1.handCards

	gohelper.setAsLastSibling(arg_1_0._dragItem.go)

	local var_1_0, var_1_1, var_1_2 = transformhelper.getLocalScale(arg_1_0._dragItem.tr)

	arg_1_0._dragScale = var_1_0
	arg_1_0._prevIndex = arg_1_0.context.index
	arg_1_0._after_drag_card_list = {}

	for iter_1_0 = 1, #arg_1_0.context.handCardItemList do
		table.insert(arg_1_0._after_drag_card_list, arg_1_0.context.handCardItemList[iter_1_0])
	end

	arg_1_0._sequence = FlowSequence.New()

	local var_1_3 = 1.14
	local var_1_4 = 5

	arg_1_0._sequence:addWork(FunctionWork.New(function()
		arg_1_0:_playCardSpringEffect(arg_1_0.context.index)
	end))
	arg_1_0._sequence:addWork(TweenWork.New({
		type = "DOTweenFloat",
		from = var_1_0,
		to = var_1_3,
		t = arg_1_0._dt * var_1_4,
		frameCb = arg_1_0._tweenFrameScale,
		cbObj = arg_1_0
	}))
	arg_1_0._sequence:registerDoneListener(arg_1_0._onWorkDone, arg_1_0)
	arg_1_0._sequence:start()
	FightController.instance:registerCallback(FightEvent.DragHandCard, arg_1_0._onDragHandCard, arg_1_0)
	FightController.instance:registerCallback(FightEvent.CardLongPressEffectEnd, arg_1_0._onCardLongPressEffectEnd, arg_1_0)
end

function var_0_0._onCardLongPressEffectEnd(arg_3_0)
	gohelper.setAsLastSibling(arg_3_0._dragItem.go)
end

function var_0_0._tweenFrameScale(arg_4_0, arg_4_1)
	arg_4_0._dragScale = arg_4_1

	transformhelper.setLocalScale(arg_4_0._dragItem.tr, arg_4_0._dragScale, arg_4_0._dragScale, 1)

	local var_4_0 = FightViewHandCard.HandCardHeight * (arg_4_0._dragScale - 1) / 2

	recthelper.setAnchorY(arg_4_0._dragItem.tr, var_4_0)
end

function var_0_0._playCardSpringEffect(arg_5_0, arg_5_1)
	arg_5_0:_killAllPosTween()

	for iter_5_0 = 1, arg_5_0._cardCount do
		if iter_5_0 ~= arg_5_1 then
			local var_5_0 = arg_5_0._after_drag_card_list[iter_5_0]
			local var_5_1 = 0

			if math.abs(iter_5_0 - arg_5_1) == 1 then
				var_5_1 = iter_5_0 < arg_5_1 and 8 or -8
			end

			local var_5_2 = ZProj.TweenHelper.DOAnchorPosX(var_5_0.tr, FightViewHandCard.calcCardPosX(iter_5_0) + var_5_1, 5 * arg_5_0._dt, function()
				arg_5_0:_setCardsUniversalMatch(arg_5_1)
			end)

			table.insert(arg_5_0._tweenIds, var_5_2)
		end
	end
end

function var_0_0.onStop(arg_7_0)
	var_0_0.super.onStop(arg_7_0)
	arg_7_0._sequence:unregisterDoneListener(arg_7_0._onWorkDone, arg_7_0)

	if arg_7_0._sequence.status == WorkStatus.Running then
		arg_7_0._sequence:stop()
	end
end

function var_0_0.clearWork(arg_8_0)
	FightController.instance:unregisterCallback(FightEvent.DragHandCard, arg_8_0._onDragHandCard, arg_8_0)
	FightController.instance:unregisterCallback(FightEvent.CardLongPressEffectEnd, arg_8_0._onCardLongPressEffectEnd, arg_8_0)
	arg_8_0:_killAllPosTween()
	arg_8_0:_killDragTween()

	if var_0_2 then
		var_0_2:dispose()
	end

	var_0_2 = nil
	var_0_3 = nil
	arg_8_0._after_drag_card_list = {}
end

function var_0_0._killDragTween(arg_9_0)
	if arg_9_0._drag_tween then
		ZProj.TweenHelper.KillById(arg_9_0._drag_tween)

		arg_9_0._drag_tween = nil
	end
end

function var_0_0._killAllPosTween(arg_10_0)
	if arg_10_0._tweenIds then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._tweenIds) do
			ZProj.TweenHelper.KillById(iter_10_1)
		end
	end

	arg_10_0._tweenIds = {}
end

function var_0_0._onWorkDone(arg_11_0)
	arg_11_0._sequence:unregisterDoneListener(arg_11_0._onWorkDone, arg_11_0)
end

function var_0_0._onDragHandCard(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._position = arg_12_2

	arg_12_0:_updateDragHandCards()
end

function var_0_0._updateDragHandCards(arg_13_0)
	local var_13_0 = arg_13_0.context.index
	local var_13_1 = arg_13_0._dragItem
	local var_13_2 = arg_13_0._cardCount
	local var_13_3 = 1
	local var_13_4 = arg_13_0.context.handCardItemList
	local var_13_5 = recthelper.screenPosToAnchorPos(arg_13_0._position, arg_13_0._handCardTr)
	local var_13_6 = FightViewHandCard.calcTotalWidth(var_13_2, var_13_3)
	local var_13_7 = FightViewHandCard.HandCardWidth * 0.5
	local var_13_8 = var_13_5.x - FightViewHandCard.HalfWidth
	local var_13_9 = Mathf.Clamp(var_13_8, -var_13_6 + var_13_7, -var_13_7)

	arg_13_0:_killDragTween()

	local var_13_10 = recthelper.getAnchorX(var_13_1.tr)

	if math.abs(var_13_10 - var_13_9) > 20 then
		arg_13_0._drag_tween = ZProj.TweenHelper.DOAnchorPosX(var_13_1.tr, var_13_9, 6 * arg_13_0._dt)
	else
		recthelper.setAnchorX(var_13_1.tr, var_13_9)
	end

	local var_13_11 = FightViewHandCard.calcCardIndexDraging(var_13_9, var_13_2, var_13_3)

	arg_13_0:_setCardsUniversalMatch(var_13_11)

	if arg_13_0._prevIndex and var_13_11 ~= arg_13_0._prevIndex then
		local var_13_12 = Time.realtimeSinceStartup

		if not arg_13_0._lastPlayTime or var_13_12 > arg_13_0._lastPlayTime + 0.25 then
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_FightMoveCard)

			arg_13_0._lastPlayTime = var_13_12
		end

		local var_13_13 = table.remove(arg_13_0._after_drag_card_list, arg_13_0._prevIndex)

		table.insert(arg_13_0._after_drag_card_list, var_13_11, var_13_13)
		arg_13_0:_playCardSpringEffect(var_13_11)
	end

	arg_13_0._prevIndex = var_13_11
end

function var_0_0._setCardsUniversalMatch(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.context.index
	local var_14_1 = arg_14_0.context.handCardItemList
	local var_14_2 = arg_14_0._cardCount

	var_0_0.setCardsUniversalMatch(var_14_1, arg_14_0._handCards, var_14_0, arg_14_1, var_14_2, true)
end

function var_0_0.setCardsUniversalMatch(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	local var_15_0 = arg_15_1[arg_15_2]

	if not var_15_0 then
		logError("dragCardMO = nil, dragIndex = " .. arg_15_2 .. ", handCardCount = " .. #arg_15_1)
	end

	local var_15_1 = arg_15_0[arg_15_2]
	local var_15_2 = recthelper.getAnchorX(var_15_1.tr)
	local var_15_3 = FightEnum.UniversalCard[var_15_0.skillId]
	local var_15_4
	local var_15_5

	for iter_15_0 = 1, arg_15_4 do
		if iter_15_0 ~= arg_15_2 then
			local var_15_6 = arg_15_0[iter_15_0]
			local var_15_7 = var_15_2 - recthelper.getAnchorX(var_15_6.tr)

			if var_15_7 > 0 and (not var_15_4 or var_15_7 < var_15_4) and var_15_7 < 2 * FightViewHandCard.HandCardWidth then
				var_15_4 = var_15_7
				var_15_5 = iter_15_0
			end
		end
	end

	local var_15_8

	for iter_15_1 = 1, arg_15_4 do
		if iter_15_1 ~= arg_15_2 then
			local var_15_9 = arg_15_0[iter_15_1]

			var_15_9:setUniversal(false)

			if var_15_3 and iter_15_1 == var_15_5 and FightCardDataHelper.canCombineWithUniversalForPerformance(var_15_0, arg_15_1[iter_15_1]) then
				var_15_9:setUniversal(true)

				var_15_8 = var_15_9
			end
		end
	end

	if arg_15_5 then
		var_0_0._setUniversalLinkEffect(var_15_1, var_15_8)
	end

	arg_15_0[arg_15_2]:setUniversal(var_15_3)
end

function var_0_0._setUniversalLinkEffect(arg_16_0, arg_16_1)
	if arg_16_1 then
		if recthelper.getAnchorX(arg_16_0.tr) - recthelper.getAnchorX(arg_16_1.tr) > FightViewHandCard.HandCardWidth then
			if not var_0_2 then
				var_0_3 = gohelper.create2d(arg_16_1.go, "linkEffect")
				var_0_2 = PrefabInstantiate.Create(var_0_3)

				var_0_2:startLoad(var_0_1)
			end

			gohelper.addChild(arg_16_1.go, var_0_3)
			recthelper.setAnchorX(var_0_3.transform, 170)
		elseif var_0_3 then
			recthelper.setAnchorX(var_0_3.transform, 10000)
		end
	elseif var_0_3 then
		recthelper.setAnchorX(var_0_3.transform, 10000)
	end
end

return var_0_0
