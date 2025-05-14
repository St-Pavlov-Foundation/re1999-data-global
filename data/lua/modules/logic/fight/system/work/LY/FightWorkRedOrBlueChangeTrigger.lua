module("modules.logic.fight.system.work.LY.FightWorkRedOrBlueChangeTrigger", package.seeall)

local var_0_0 = class("FightWorkRedOrBlueChangeTrigger", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	FightDataHelper.LYDataMgr:refreshShowAreaSize()
	arg_1_0:onDone(true)
end

return var_0_0
