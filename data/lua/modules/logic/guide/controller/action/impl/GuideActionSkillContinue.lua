module("modules.logic.guide.controller.action.impl.GuideActionSkillContinue", package.seeall)

local var_0_0 = class("GuideActionSkillContinue", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	FightController.instance:dispatchEvent(FightEvent.OnGuideBeforeSkillContinue)
	arg_1_0:onDone(true)
end

return var_0_0
