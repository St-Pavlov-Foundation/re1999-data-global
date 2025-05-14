module("modules.logic.fight.view.cardeffect.FightCardLongPressEffect", package.seeall)

local var_0_0 = class("FightCardLongPressEffect", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	var_0_0.super.onStart(arg_2_0, arg_2_1)

	arg_2_0._dragItem = arg_2_1.handCardItemList[arg_2_1.index]
	arg_2_0._cardCount = arg_2_1.cardCount

	gohelper.setAsLastSibling(arg_2_0._dragItem.go)

	local var_2_0 = 0.033

	arg_2_0._sequence = FlowSequence.New()

	arg_2_0._sequence:addWork(TweenWork.New({
		from = 1,
		type = "DOTweenFloat",
		to = 0.9,
		t = var_2_0 * 3,
		frameCb = arg_2_0._tweenFrameScale,
		cbObj = arg_2_0
	}))
	arg_2_0._sequence:addWork(TweenWork.New({
		from = 0.9,
		type = "DOTweenFloat",
		to = 1.2,
		t = var_2_0 * 4,
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

function var_0_0.onStop(arg_4_0)
	var_0_0.super.onStop(arg_4_0)
	arg_4_0._sequence:stop()
end

function var_0_0._onWorkDone(arg_5_0)
	arg_5_0._sequence:unregisterDoneListener(arg_5_0._onWorkDone, arg_5_0)

	local var_5_0 = arg_5_0.context.handCardItemList[arg_5_0.context.index]
	local var_5_1 = var_5_0.cardInfoMO and var_5_0.cardInfoMO.skillId

	if var_5_1 then
		FightController.instance:dispatchEvent(FightEvent.ShowCardSkillTips, var_5_1, var_5_0.cardInfoMO.uid, var_5_0.cardInfoMO)
	end

	arg_5_0:onDone(true)
end

function var_0_0._updateDragHandCards(arg_6_0)
	local var_6_0 = arg_6_0.context.index
	local var_6_1 = arg_6_0._dragItem
	local var_6_2 = arg_6_0._cardCount
	local var_6_3 = arg_6_0._dragScale
	local var_6_4 = arg_6_0.context.handCardItemList
	local var_6_5 = FightViewHandCard.HandCardHeight * (var_6_3 - 1) / 2

	recthelper.setAnchorY(var_6_1.tr, var_6_5)
	transformhelper.setLocalScale(var_6_1.tr, var_6_3, var_6_3, 1)

	for iter_6_0 = 1, var_6_2 do
		local var_6_6 = var_6_4[iter_6_0]
		local var_6_7 = recthelper.getAnchorX(var_6_6.tr)
		local var_6_8 = FightViewHandCard.calcCardPosXDraging(iter_6_0, var_6_2, var_6_0, var_6_3)

		recthelper.setAnchorX(var_6_6.tr, var_6_8)
	end
end

return var_0_0
