module("modules.logic.fight.view.cardeffect.FightCardDisplayHideAllEffect", package.seeall)

local var_0_0 = class("FightCardDisplayHideAllEffect", BaseWork)
local var_0_1 = 1
local var_0_2 = var_0_1 * 0.033

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0._dt = var_0_2 / FightModel.instance:getUISpeed()

	local var_1_0 = FlowParallel.New()

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.hideSkillItemGOs) do
		if iter_1_1.activeSelf then
			var_1_0:addWork(TweenWork.New({
				from = 1,
				type = "DOFadeCanvasGroup",
				to = 0,
				go = iter_1_1,
				t = arg_1_0._dt * 10
			}))
			var_1_0:addWork(FunctionWork.New(arg_1_0._hideLockObj, arg_1_0, iter_1_0))
		end
	end

	arg_1_0._flow = FlowSequence.New()

	arg_1_0._flow:addWork(WorkWaitSeconds.New(0.5))
	arg_1_0._flow:addWork(var_1_0)
	arg_1_0._flow:registerDoneListener(arg_1_0._onWorkDone, arg_1_0)
	arg_1_0._flow:start()
end

function var_0_0._hideLockObj(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.context.hideSkillItemGOs[arg_2_1]

	if var_2_0 then
		local var_2_1 = gohelper.findChild(var_2_0.transform.parent.gameObject, "lock")

		gohelper.setActive(var_2_1, false)
	end
end

function var_0_0.onStop(arg_3_0)
	var_0_0.super.onStop(arg_3_0)
	arg_3_0._flow:unregisterDoneListener(arg_3_0._onWorkDone, arg_3_0)

	if arg_3_0._flow.status == WorkStatus.Running then
		arg_3_0._flow:stop()
	end
end

function var_0_0._onWorkDone(arg_4_0)
	arg_4_0:onDone(true)
end

return var_0_0
