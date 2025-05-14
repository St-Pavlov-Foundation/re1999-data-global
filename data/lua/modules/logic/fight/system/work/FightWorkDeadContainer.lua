module("modules.logic.fight.system.work.FightWorkDeadContainer", package.seeall)

local var_0_0 = class("FightWorkDeadContainer", FightStepEffectFlow)
local var_0_1 = {
	[FightEnum.EffectType.DEAD] = true,
	[FightEnum.EffectType.KILL] = true,
	[FightEnum.EffectType.REMOVEENTITYCARDS] = true
}

function var_0_0.onStart(arg_1_0)
	arg_1_0:playAdjacentParallelEffect(var_0_1, true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
