module("modules.logic.guide.controller.action.impl.WaitGuideActionEntityDeadPause", package.seeall)

local var_0_0 = class("WaitGuideActionEntityDeadPause", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	FightController.instance:registerCallback(FightEvent.OnGuideEntityDeadPause, arg_1_0._onGuideEntityDeadPause, arg_1_0)

	arg_1_0._side = tonumber(arg_1_0.actionParam)
end

function var_0_0._onGuideEntityDeadPause(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2.side == arg_2_0._side then
		arg_2_1.OnGuideEntityDeadPause = true

		FightController.instance:unregisterCallback(FightEvent.OnGuideEntityDeadPause, arg_2_0._onGuideEntityDeadPause, arg_2_0)
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnGuideEntityDeadPause, arg_3_0._onGuideEntityDeadPause, arg_3_0)
end

return var_0_0
