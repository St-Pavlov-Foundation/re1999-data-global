module("modules.logic.fight.entity.comp.skill.FightTLEventPlayNextSkill", package.seeall)

local var_0_0 = class("FightTLEventPlayNextSkill", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if FightModel.instance:canParallelSkill(arg_1_1) then
		FightController.instance:dispatchEvent(FightEvent.ParallelPlayNextSkillCheck, arg_1_1)
	end
end

return var_0_0
