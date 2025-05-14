module("modules.logic.fight.system.work.FightWorkCardHeatValueChange", package.seeall)

local var_0_0 = class("FightWorkCardHeatValueChange", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0:com_sendFightEvent(FightEvent.RefreshCardHeatShow)
	arg_1_0:onDone(true)
end

return var_0_0
