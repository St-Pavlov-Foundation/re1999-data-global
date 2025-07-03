module("modules.logic.fight.system.work.FightWorkBloodPoolMaxChange334", package.seeall)

local var_0_0 = class("FightWorkBloodPoolMaxChange334", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0.actEffectData.effectNum
	local var_1_1 = FightDataHelper.teamDataMgr

	var_1_1:checkBloodPoolExist(var_1_0)
	var_1_1[var_1_0].bloodPool:changeMaxValue(arg_1_0.actEffectData.effectNum1)
	FightController.instance:dispatchEvent(FightEvent.BloodPool_MaxValueChange, var_1_0)
	arg_1_0:onDone(true)
end

return var_0_0
