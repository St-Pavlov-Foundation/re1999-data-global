module("modules.logic.fight.system.work.FightStepEffectFlow", package.seeall)

local var_0_0 = class("FightStepEffectFlow", FightEffectBase)

function var_0_0.playEffectData(arg_1_0)
	return
end

function var_0_0.playAdjacentSequenceEffect(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0:getAdjacentSameEffectList(arg_2_1, arg_2_2)
	local var_2_1 = arg_2_0:com_registWorkDoneFlowSequence()

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_2 = iter_2_1.actEffectData
		local var_2_3 = var_2_2.effectType
		local var_2_4 = FightStepBuilder.ActEffectWorkCls[var_2_3]

		var_2_1:registWork(var_2_4, iter_2_1.fightStepData, var_2_2)
	end

	return var_2_1:start()
end

function var_0_0.playAdjacentParallelEffect(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:getAdjacentSameEffectList(arg_3_1, arg_3_2)
	local var_3_1 = arg_3_0:com_registWorkDoneFlowParallel()

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_2 = iter_3_1.actEffectData.effectType
		local var_3_3 = FightStepBuilder.ActEffectWorkCls[var_3_2]

		var_3_1:registWork(var_3_3, iter_3_1.fightStepData, iter_3_1.actEffectData)
	end

	return var_3_1:start()
end

return var_0_0
