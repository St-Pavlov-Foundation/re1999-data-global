module("modules.logic.guide.controller.action.impl.GuideActionEntityDeadContinue", package.seeall)

local var_0_0 = class("GuideActionEntityDeadContinue", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	FightController.instance:dispatchEvent(FightEvent.OnGuideEntityDeadContinue)
	arg_1_0:onDone(true)
end

return var_0_0
