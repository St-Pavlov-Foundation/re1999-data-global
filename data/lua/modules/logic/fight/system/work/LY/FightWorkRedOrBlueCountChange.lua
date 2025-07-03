module("modules.logic.fight.system.work.LY.FightWorkRedOrBlueCountChange", package.seeall)

local var_0_0 = class("FightWorkRedOrBlueCountChange", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0.actEffectData.buff

	FightDataHelper.LYDataMgr:setLYCountBuff(var_1_0)

	return arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
