module("modules.logic.fight.entity.comp.skill.FightTLEventJoinSameSkillStart", package.seeall)

local var_0_0 = class("FightTLEventJoinSameSkillStart", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if not FightModel.instance:canParallelSkill(arg_1_1) then
		return
	end

	arg_1_0._attacker = FightHelper.getEntity(arg_1_1.fromId)

	if arg_1_0._attacker and arg_1_0._attacker.skill then
		arg_1_0._attacker.skill:recordSameSkillStartParam(arg_1_1, arg_1_3)
	end
end

return var_0_0
