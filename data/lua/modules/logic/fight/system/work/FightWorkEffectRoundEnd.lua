module("modules.logic.fight.system.work.FightWorkEffectRoundEnd", package.seeall)

local var_0_0 = class("FightWorkEffectRoundEnd", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	FightController.instance:dispatchEvent(FightEvent.OnMySideRoundEnd)
	arg_1_0:onDone(true)
end

return var_0_0
