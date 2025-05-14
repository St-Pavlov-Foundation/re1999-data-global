module("modules.logic.guide.controller.action.impl.WaitGuideActionSkillPause", package.seeall)

local var_0_0 = class("WaitGuideActionSkillPause", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	FightController.instance:registerCallback(FightEvent.OnGuideBeforeSkillPause, arg_1_0._onGuideBeforeSkillPause, arg_1_0)

	local var_1_0 = string.splitToNumber(arg_1_0.actionParam, "#")

	arg_1_0._attackId = var_1_0[1]
	arg_1_0._skillId = var_1_0[2]
end

function var_0_0._onGuideBeforeSkillPause(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_1.OnGuideBeforeSkillPause = arg_2_2 == arg_2_0._attackId and arg_2_3 == arg_2_0._skillId

	if arg_2_1.OnGuideBeforeSkillPause then
		FightController.instance:unregisterCallback(FightEvent.OnGuideBeforeSkillPause, arg_2_0._onGuideBeforeSkillPause, arg_2_0)
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnGuideBeforeSkillPause, arg_3_0._onGuideBeforeSkillPause, arg_3_0)
end

return var_0_0
