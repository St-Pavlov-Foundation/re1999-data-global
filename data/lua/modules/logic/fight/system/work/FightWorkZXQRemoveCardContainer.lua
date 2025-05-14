module("modules.logic.fight.system.work.FightWorkZXQRemoveCardContainer", package.seeall)

local var_0_0 = class("FightWorkZXQRemoveCardContainer", FightStepEffectFlow)

function var_0_0.onStart(arg_1_0)
	arg_1_0:playAdjacentSequenceEffect(nil, true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
