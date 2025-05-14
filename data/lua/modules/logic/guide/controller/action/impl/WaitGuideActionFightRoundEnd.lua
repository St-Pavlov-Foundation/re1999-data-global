module("modules.logic.guide.controller.action.impl.WaitGuideActionFightRoundEnd", package.seeall)

local var_0_0 = class("WaitGuideActionFightRoundEnd", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, arg_1_0._onRoundFinish, arg_1_0)
end

function var_0_0._onRoundFinish(arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, arg_2_0._onRoundFinish, arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, arg_3_0._onRoundFinish, arg_3_0)
end

return var_0_0
