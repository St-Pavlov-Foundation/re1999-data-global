module("modules.logic.fight.system.work.FightWorkCardDisappear", package.seeall)

local var_0_0 = class("FightWorkCardDisappear", FightEffectBase)

function var_0_0.onStart(arg_1_0, arg_1_1)
	FightController.instance:dispatchEvent(FightEvent.CardDisappear)
	arg_1_0:onDone(true)
end

return var_0_0
