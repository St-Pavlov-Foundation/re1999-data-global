module("modules.logic.fight.entity.comp.skill.FightTLEventInvokeLookBack", package.seeall)

local var_0_0 = class("FightTLEventInvokeLookBack")

function var_0_0.handleSkillEvent(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_1 and arg_1_1.actEffectMOs

	if not var_1_0 then
		return
	end

	local var_1_1 = {}
	local var_1_2 = false

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if iter_1_1.effectType == FightEnum.EffectType.SAVEFIGHTRECORDSTART then
			var_1_2 = true
		elseif iter_1_1.effectType == FightEnum.EffectType.SAVEFIGHTRECORDEND then
			break
		elseif var_1_2 then
			table.insert(var_1_1, iter_1_1)
		end
	end

	if #var_1_1 < 1 then
		return
	end

	arg_1_0._flow = FlowParallel.New()

	for iter_1_2, iter_1_3 in ipairs(var_1_1) do
		local var_1_3 = FightStepBuilder.ActEffectWorkCls[iter_1_3.effectType]

		if var_1_3 then
			arg_1_0._flow:addWork(FightWork2Work.New(var_1_3, arg_1_1, iter_1_3))
		end
	end

	arg_1_0._flow:start()
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
