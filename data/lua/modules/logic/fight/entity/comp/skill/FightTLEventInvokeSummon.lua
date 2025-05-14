module("modules.logic.fight.entity.comp.skill.FightTLEventInvokeSummon", package.seeall)

local var_0_0 = class("FightTLEventInvokeSummon")

function var_0_0.handleSkillEvent(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.summonList = {}

	arg_1_0:getStepMoSummon(arg_1_1)

	if #arg_1_0.summonList < 1 then
		return
	end

	arg_1_0._flow = FlowParallel.New()

	local var_1_0 = FightStepBuilder.ActEffectWorkCls[FightEnum.EffectType.SUMMON]

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.summonList) do
		local var_1_1 = iter_1_1[1]
		local var_1_2 = iter_1_1[2]

		arg_1_0._flow:addWork(FightWork2Work.New(var_1_0, var_1_1, var_1_2))
	end

	arg_1_0._flow:start()
end

function var_0_0.getStepMoSummon(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1 and arg_2_1.actEffectMOs

	if not var_2_0 then
		return
	end

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if iter_2_1.effectType == FightEnum.EffectType.SUMMON then
			table.insert(arg_2_0.summonList, {
				arg_2_1,
				iter_2_1
			})
		elseif iter_2_1.effectType == FightEnum.EffectType.FIGHTSTEP then
			arg_2_0:getStepMoSummon(iter_2_1.cus_stepMO)
		end
	end
end

function var_0_0.handleSkillEventEnd(arg_3_0)
	return
end

function var_0_0.onSkillEnd(arg_4_0)
	return
end

function var_0_0.clear(arg_5_0)
	return
end

function var_0_0.dispose(arg_6_0)
	return
end

return var_0_0
