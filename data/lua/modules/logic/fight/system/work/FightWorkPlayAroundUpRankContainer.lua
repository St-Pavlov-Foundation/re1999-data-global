module("modules.logic.fight.system.work.FightWorkPlayAroundUpRankContainer", package.seeall)

local var_0_0 = class("FightWorkPlayAroundUpRankContainer", FightStepEffectFlow)
local var_0_1 = {
	[FightEnum.EffectType.PLAYAROUNDUPRANK] = true,
	[FightEnum.EffectType.PLAYAROUNDDOWNRANK] = true,
	[FightEnum.EffectType.PLAYCHANGERANKFAIL] = true
}

function var_0_0.onStart(arg_1_0)
	arg_1_0:playAdjacentParallelEffect(var_0_1, true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
