module("modules.logic.fight.entity.comp.skill.FightTLEventInvokeLookBack", package.seeall)

local var_0_0 = class("FightTLEventInvokeLookBack", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_1 and arg_1_1.actEffect

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

	local var_1_3 = arg_1_0:com_registFlowParallel()

	for iter_1_2, iter_1_3 in ipairs(var_1_1) do
		local var_1_4 = FightStepBuilder.ActEffectWorkCls[iter_1_3.effectType]

		if var_1_4 then
			var_1_3:registWork(var_1_4, arg_1_1, iter_1_3)
		end
	end

	arg_1_0:addWork2TimelineFinishWork(var_1_3)
	var_1_3:start()
end

function var_0_0.onTrackEnd(arg_2_0)
	return
end

function var_0_0.onDestructor(arg_3_0)
	return
end

return var_0_0
