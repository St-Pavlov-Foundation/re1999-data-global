module("modules.logic.fight.entity.comp.skill.FightTLEventPlayNextSkill", package.seeall)

local var_0_0 = class("FightTLEventPlayNextSkill")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.handleSkillEvent(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if FightModel.instance:canParallelSkill(arg_2_1) then
		FightController.instance:dispatchEvent(FightEvent.ParallelPlayNextSkillCheck, arg_2_1)
	end
end

return var_0_0
