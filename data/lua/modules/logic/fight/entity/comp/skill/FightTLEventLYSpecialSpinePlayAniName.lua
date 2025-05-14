module("modules.logic.fight.entity.comp.skill.FightTLEventLYSpecialSpinePlayAniName", package.seeall)

local var_0_0 = class("FightTLEventLYSpecialSpinePlayAniName")

function var_0_0.handleSkillEvent(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_3[1]

	FightController.instance:dispatchEvent(FightEvent.TimelineLYSpecialSpinePlayAniName, var_1_0)
end

function var_0_0.handleSkillEventEnd(arg_2_0)
	return
end

function var_0_0.onSkillEnd(arg_3_0)
	return
end

function var_0_0.clear(arg_4_0)
	return
end

function var_0_0.dispose(arg_5_0)
	return
end

return var_0_0
