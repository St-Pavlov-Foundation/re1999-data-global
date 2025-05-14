module("modules.logic.fight.view.cardeffect.FightCardDisplayEffect", package.seeall)

local var_0_0 = class("FightCardDisplayEffect", BaseWork)
local var_0_1 = 1
local var_0_2 = var_0_1 * 0.033

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0._dt = var_0_2 / FightModel.instance:getUISpeed()

	gohelper.setActive(arg_1_1.skillTipsGO, true)

	local var_1_0 = arg_1_1.skillTipsGO.transform
	local var_1_1 = recthelper.getWidth(var_1_0)
	local var_1_2 = arg_1_1.skillItemGO.transform.parent
	local var_1_3 = recthelper.getAnchorX(var_1_2) - recthelper.getWidth(var_1_2) * 0.5

	recthelper.setAnchorX(var_1_0, 1100 + var_1_1)

	local var_1_4 = FlowSequence.New()

	var_1_4:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = var_1_0,
		to = var_1_3 - 47.5,
		t = arg_1_0._dt * 7
	}))
	var_1_4:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = var_1_0,
		to = var_1_3 - 34.2,
		t = arg_1_0._dt * 3
	}))

	local var_1_5 = arg_1_1.skillItemGO.transform
	local var_1_6 = FlowSequence.New()

	var_1_6:addWork(TweenWork.New({
		type = "DOAnchorPos",
		tox = -15,
		toy = 22,
		tr = var_1_5,
		t = arg_1_0._dt * 6
	}))

	local var_1_7 = FlowSequence.New()

	var_1_7:addWork(TweenWork.New({
		to = 0.922,
		type = "DOScale",
		tr = var_1_5,
		t = arg_1_0._dt * 3
	}))
	var_1_7:addWork(TweenWork.New({
		to = 1.2,
		type = "DOScale",
		tr = var_1_5,
		t = arg_1_0._dt * 3
	}))

	arg_1_0._flow = FlowParallel.New()

	arg_1_0._flow:addWork(var_1_4)
	arg_1_0._flow:addWork(var_1_6)
	arg_1_0._flow:addWork(var_1_7)
	arg_1_0._flow:registerDoneListener(arg_1_0._onWorkDone, arg_1_0)
	arg_1_0._flow:start()
end

function var_0_0.onStop(arg_2_0)
	var_0_0.super.onStop(arg_2_0)

	if arg_2_0._flow then
		arg_2_0._flow:unregisterDoneListener(arg_2_0._onWorkDone, arg_2_0)
		arg_2_0._flow:stop()

		arg_2_0._flow = nil
	end
end

function var_0_0._onWorkDone(arg_3_0)
	arg_3_0:onDone(true)
end

return var_0_0
