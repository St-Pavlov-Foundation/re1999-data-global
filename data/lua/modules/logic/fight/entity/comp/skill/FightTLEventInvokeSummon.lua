module("modules.logic.fight.entity.comp.skill.FightTLEventInvokeSummon", package.seeall)

local var_0_0 = class("FightTLEventInvokeSummon", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.summonList = {}

	arg_1_0:getStepDataSummon(arg_1_1)

	if #arg_1_0.summonList < 1 then
		return
	end

	local var_1_0 = arg_1_0:com_registFlowParallel()
	local var_1_1 = FightStepBuilder.ActEffectWorkCls[FightEnum.EffectType.SUMMON]

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.summonList) do
		local var_1_2 = iter_1_1[1]
		local var_1_3 = iter_1_1[2]

		var_1_0:registWork(var_1_1, var_1_2, var_1_3)
	end

	arg_1_0:addWork2TimelineFinishWork(var_1_0)
	var_1_0:start()
end

function var_0_0.getStepDataSummon(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1 and arg_2_1.actEffect

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
			arg_2_0:getStepDataSummon(iter_2_1.fightStep)
		end
	end
end

function var_0_0.onTrackEnd(arg_3_0)
	return
end

function var_0_0.onDestructor(arg_4_0)
	return
end

function var_0_0.dispose(arg_5_0)
	return
end

return var_0_0
