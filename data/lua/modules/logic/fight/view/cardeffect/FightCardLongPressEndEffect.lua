module("modules.logic.fight.view.cardeffect.FightCardLongPressEndEffect", package.seeall)

local var_0_0 = class("FightCardLongPressEndEffect", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	var_0_0.super.onStart(arg_2_0, arg_2_1)

	arg_2_0._dragItem = arg_2_1.handCardItemList[arg_2_1.index]
	arg_2_0._cardCount = arg_2_1.cardCount

	gohelper.setAsLastSibling(arg_2_0._dragItem.go)
	FightController.instance:dispatchEvent(FightEvent.CardLongPressEffectEnd)

	local var_2_0, var_2_1, var_2_2 = transformhelper.getLocalScale(arg_2_0._dragItem.tr)

	arg_2_0._sequence = FlowSequence.New()

	arg_2_0._sequence:addWork(TweenWork.New({
		type = "DOTweenFloat",
		to = 1,
		t = 0.05,
		from = var_2_0,
		frameCb = arg_2_0._tweenFrameScale,
		cbObj = arg_2_0
	}))
	arg_2_0._sequence:registerDoneListener(arg_2_0._onWorkDone, arg_2_0)
	arg_2_0._sequence:start()
end

function var_0_0._tweenFrameScale(arg_3_0, arg_3_1)
	arg_3_0._dragScale = arg_3_1

	arg_3_0:_updateDragHandCards()
end

function var_0_0._onWorkDone(arg_4_0)
	arg_4_0._sequence:unregisterDoneListener(arg_4_0._onWorkDone, arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0._updateDragHandCards(arg_5_0)
	local var_5_0 = arg_5_0.context.index
	local var_5_1 = arg_5_0._dragItem
	local var_5_2 = arg_5_0._cardCount
	local var_5_3 = arg_5_0._dragScale
	local var_5_4 = arg_5_0.context.handCardItemList
	local var_5_5 = FightViewHandCard.HandCardHeight * (var_5_3 - 1) / 2

	recthelper.setAnchorY(var_5_1.tr, var_5_5)
	transformhelper.setLocalScale(var_5_1.tr, var_5_3, var_5_3, 1)

	if var_5_4 then
		if var_5_2 == nil then
			return
		end

		for iter_5_0 = 1, var_5_2 do
			local var_5_6 = var_5_4[iter_5_0]
			local var_5_7 = recthelper.getAnchorX(var_5_6.tr)
			local var_5_8 = FightViewHandCard.calcCardPosXDraging(iter_5_0, var_5_2, var_5_0, var_5_3)

			recthelper.setAnchorX(var_5_6.tr, var_5_8)
		end
	end
end

return var_0_0
