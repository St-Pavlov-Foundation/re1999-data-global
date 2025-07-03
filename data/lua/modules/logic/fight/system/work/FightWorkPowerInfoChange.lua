module("modules.logic.fight.system.work.FightWorkPowerInfoChange", package.seeall)

local var_0_0 = class("FightWorkPowerInfoChange", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0.actEffectData.targetId
	local var_1_1 = arg_1_0.actEffectData.powerInfo.powerId

	arg_1_0:com_sendFightEvent(FightEvent.PowerInfoChange, var_1_0, var_1_1)
	arg_1_0:onDone(true)
end

return var_0_0
