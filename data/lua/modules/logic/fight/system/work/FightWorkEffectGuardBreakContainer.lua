module("modules.logic.fight.system.work.FightWorkEffectGuardBreakContainer", package.seeall)

local var_0_0 = class("FightWorkEffectGuardBreakContainer", FightStepEffectFlow)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = {
		[FightEnum.EffectType.GUARDBREAK] = true
	}

	arg_1_0:playAdjacentParallelEffect(var_1_0, true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
