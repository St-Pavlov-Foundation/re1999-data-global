module("modules.logic.fight.entity.comp.skill.FightTLEventRemoveSummoned", package.seeall)

local var_0_0 = class("FightTLEventRemoveSummoned")

function var_0_0.handleSkillEvent(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if arg_1_3[1] == "1" then
		for iter_1_0, iter_1_1 in ipairs(arg_1_1.actEffectMOs) do
			if iter_1_1.effectType == FightEnum.EffectType.SUMMONEDDELETE then
				FightWork2Work.New(FightWorkSummonedDelete, arg_1_1, iter_1_1):onStart()
			end
		end
	end
end

function var_0_0.handleSkillEventEnd(arg_2_0)
	return
end

function var_0_0.reset(arg_3_0)
	return
end

function var_0_0.dispose(arg_4_0)
	return
end

return var_0_0
