module("modules.logic.guide.controller.action.impl.WaitGuideActionFightSkillPlayFinish", package.seeall)

local var_0_0 = class("WaitGuideActionFightSkillPlayFinish", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_1_0._onSkillPlayFinish, arg_1_0)

	local var_1_0 = string.splitToNumber(arg_1_0.actionParam, "#")

	arg_1_0._attackId = var_1_0[1]
	arg_1_0._skillId = var_1_0[2]
end

function var_0_0._onSkillPlayFinish(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1:getMO().modelId
	local var_2_1 = not arg_2_0._attackId or arg_2_0._attackId == var_2_0
	local var_2_2 = not arg_2_0._skillId or arg_2_0._skillId == arg_2_2

	if var_2_1 and var_2_2 then
		FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_2_0._onSkillPlayFinish, arg_2_0)
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_3_0._onSkillPlayFinish, arg_3_0)
end

return var_0_0
