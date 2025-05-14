module("modules.logic.guide.controller.action.impl.WaitGuideActionBreakFightResultClose", package.seeall)

local var_0_0 = class("WaitGuideActionBreakFightResultClose", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	FightController.instance:registerCallback(FightEvent.OnBreakResultViewClose, arg_1_0._onBreakResultViewClose, arg_1_0)
end

function var_0_0._onBreakResultViewClose(arg_2_0, arg_2_1)
	arg_2_1.isBreak = true

	FightController.instance:unregisterCallback(FightEvent.OnBreakResultViewClose, arg_2_0._onBreakResultViewClose, arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnBreakResultViewClose, arg_3_0._onBreakResultViewClose, arg_3_0)
end

return var_0_0
