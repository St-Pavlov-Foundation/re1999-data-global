module("modules.logic.fight.system.work.FightWorkAddHandCardContainer", package.seeall)

local var_0_0 = class("FightWorkAddHandCardContainer", FightStepEffectFlow)
local var_0_1 = {
	[FightEnum.EffectType.EXPOINTCHANGE] = true,
	[FightEnum.EffectType.POWERCHANGE] = true
}

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0:getAdjacentSameEffectList(var_0_1, true)
	local var_1_1 = arg_1_0:com_registWorkDoneFlowParallel()
	local var_1_2 = 0

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		local var_1_3 = iter_1_1.actEffectData.effectType
		local var_1_4 = FightStepBuilder.ActEffectWorkCls[var_1_3]

		var_1_2 = var_1_2 + 1

		local var_1_5 = var_1_1:registWork(FightWorkFlowSequence)

		var_1_5:registWork(FightWorkDelayTimer, 0.05 * var_1_2)
		var_1_5:registWork(var_1_4, iter_1_1.fightStepData, iter_1_1.actEffectData)
	end

	var_1_1:start()
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
