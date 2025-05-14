module("modules.logic.fight.system.work.FightWorkKillContainer", package.seeall)

local var_0_0 = class("FightWorkKillContainer", FightStepEffectFlow)

function var_0_0.onStart(arg_1_0)
	arg_1_0:playAdjacentParallelEffect(nil, true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
