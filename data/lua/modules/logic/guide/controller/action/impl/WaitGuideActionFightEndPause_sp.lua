module("modules.logic.guide.controller.action.impl.WaitGuideActionFightEndPause_sp", package.seeall)

local var_0_0 = class("WaitGuideActionFightEndPause_sp", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	FightController.instance:registerCallback(FightEvent.OnGuideFightEndPause_sp, arg_1_0._onGuideFightEndPause, arg_1_0)
end

function var_0_0._onGuideFightEndPause(arg_2_0, arg_2_1)
	arg_2_1.OnGuideFightEndPause_sp = true

	FightController.instance:unregisterCallback(FightEvent.OnGuideFightEndPause_sp, arg_2_0._onGuideFightEndPause, arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnGuideFightEndPause_sp, arg_3_0._onGuideFightEndPause, arg_3_0)
end

return var_0_0
