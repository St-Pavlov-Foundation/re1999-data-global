module("modules.logic.fight.view.cardeffect.FightCardDisplayEndEffect", package.seeall)

local var_0_0 = class("FightCardDisplayEndEffect", BaseWork)
local var_0_1 = 1
local var_0_2 = var_0_1 * 0.033

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0._dt = var_0_2 / FightModel.instance:getUISpeed()
	arg_1_0._flow = FlowSequence.New()

	if arg_1_1.skillItemGO then
		local var_1_0 = TweenWork.New({
			from = 1,
			type = "DOFadeCanvasGroup",
			to = 0,
			go = arg_1_1.skillItemGO,
			t = arg_1_0._dt * 5
		})

		arg_1_0._flow:addWork(var_1_0)
	end

	local var_1_1 = arg_1_1.waitingAreaGO.transform
	local var_1_2 = arg_1_1.skillTipsGO.transform
	local var_1_3 = recthelper.getWidth(var_1_1) + recthelper.getWidth(var_1_2)
	local var_1_4 = TweenWork.New({
		type = "DOAnchorPosX",
		tr = var_1_2,
		to = var_1_3,
		t = arg_1_0._dt * 3
	})

	arg_1_0._flow:addWork(var_1_4)

	local var_1_5 = FunctionWork.New(function()
		gohelper.setActive(arg_1_1.skillItemGO, false)
		gohelper.setActive(arg_1_1.skillTipsGO, false)
	end)

	arg_1_0._flow:addWork(var_1_5)
	arg_1_0._flow:registerDoneListener(arg_1_0._onWorkDone, arg_1_0)
	arg_1_0._flow:start()
end

function var_0_0.onStop(arg_3_0)
	var_0_0.super.onStop(arg_3_0)

	if arg_3_0._flow then
		arg_3_0._flow:unregisterDoneListener(arg_3_0._onWorkDone, arg_3_0)
		arg_3_0._flow:stop()

		arg_3_0._flow = nil
	end
end

function var_0_0._onWorkDone(arg_4_0)
	arg_4_0:onDone(true)
end

return var_0_0
