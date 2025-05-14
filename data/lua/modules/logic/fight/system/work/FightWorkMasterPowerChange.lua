module("modules.logic.fight.system.work.FightWorkMasterPowerChange", package.seeall)

local var_0_0 = class("FightWorkMasterPowerChange", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0:_delayDone()
end

function var_0_0._delayDone(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
