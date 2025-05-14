module("modules.logic.fight.view.cardeffect.FightCardDragEndEffect", package.seeall)

local var_0_0 = class("FightCardDragEndEffect", BaseWork)
local var_0_1 = 1
local var_0_2 = var_0_1 * 0.033

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	var_0_0.super.onStart(arg_2_0, arg_2_1)

	arg_2_0._dt = var_0_2 / FightModel.instance:getUISpeed()
	arg_2_0._dragItem = arg_2_1.handCardItemList[arg_2_1.index]
	arg_2_0._cardCount = arg_2_1.cardCount
	arg_2_0._handCardTr = arg_2_1.handCardTr
	arg_2_0._targetIndex = arg_2_1.targetIndex

	local var_2_0, var_2_1, var_2_2 = transformhelper.getLocalScale(arg_2_0._dragItem.tr)

	arg_2_0._tweenWork = TweenWork.New({
		type = "DOTweenFloat",
		to = 1,
		from = var_2_0,
		t = arg_2_0._dt * 4,
		frameCb = arg_2_0._tweenFrameScale,
		cbObj = arg_2_0
	})

	arg_2_0._tweenWork:registerDoneListener(arg_2_0._onWorkDone, arg_2_0)
	arg_2_0._tweenWork:onStart()
end

function var_0_0._tweenFrameScale(arg_3_0, arg_3_1)
	arg_3_0._dragScale = arg_3_1

	arg_3_0:_updateDragHandCards()
end

function var_0_0._onWorkDone(arg_4_0)
	local var_4_0 = arg_4_0.context.handCardItemList
	local var_4_1 = arg_4_0.context.handCards
	local var_4_2 = arg_4_0.context.index
	local var_4_3 = arg_4_0.context.targetIndex
	local var_4_4 = arg_4_0.context.cardCount

	FightCardDragEffect.setCardsUniversalMatch(var_4_0, var_4_1, var_4_2, var_4_3, var_4_4, false)
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

	for iter_5_0 = 1, var_5_2 do
		local var_5_6 = iter_5_0

		if iter_5_0 ~= var_5_0 then
			if var_5_0 < iter_5_0 and iter_5_0 <= arg_5_0._targetIndex then
				var_5_6 = iter_5_0 - 1
			elseif iter_5_0 < var_5_0 and iter_5_0 >= arg_5_0._targetIndex then
				var_5_6 = iter_5_0 + 1
			end
		else
			var_5_6 = arg_5_0._targetIndex
		end

		local var_5_7 = var_5_4[iter_5_0]
		local var_5_8 = recthelper.getAnchorX(var_5_7.tr)
		local var_5_9 = FightViewHandCard.calcCardPosXDraging(var_5_6, var_5_2, arg_5_0._targetIndex, var_5_3)

		recthelper.setAnchorX(var_5_7.tr, var_5_9)
	end
end

function var_0_0.clearWork(arg_6_0)
	if arg_6_0._tweenWork then
		arg_6_0._tweenWork:onStop()
		arg_6_0._tweenWork:unregisterDoneListener(arg_6_0._onWorkDone, arg_6_0)

		arg_6_0._tweenWork = nil
	end
end

return var_0_0
