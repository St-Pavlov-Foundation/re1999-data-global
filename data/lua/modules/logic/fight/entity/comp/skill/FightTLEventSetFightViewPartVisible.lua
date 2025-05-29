module("modules.logic.fight.entity.comp.skill.FightTLEventSetFightViewPartVisible", package.seeall)

local var_0_0 = class("FightTLEventSetFightViewPartVisible")

function var_0_0.handleSkillEvent(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = FightTLHelper.getBoolParam(arg_1_3[1])

	FightViewPartVisible.setWaitAreaActive(var_1_0)
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
