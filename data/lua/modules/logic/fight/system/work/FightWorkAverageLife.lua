module("modules.logic.fight.system.work.FightWorkAverageLife", package.seeall)

local var_0_0 = class("FightWorkAverageLife", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0:com_sendFightEvent(FightEvent.OnCurrentHpChange, arg_1_0.actEffectData.targetId)
	arg_1_0:onDone(true)
end

return var_0_0
