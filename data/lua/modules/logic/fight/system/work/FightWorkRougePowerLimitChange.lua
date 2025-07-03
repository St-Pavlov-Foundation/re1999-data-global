module("modules.logic.fight.system.work.FightWorkRougePowerLimitChange", package.seeall)

local var_0_0 = class("FightWorkRougePowerLimitChange", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.MagicLimit)

	FightModel.instance:setRougeExData(FightEnum.ExIndexForRouge.MagicLimit, var_1_0 + arg_1_0.actEffectData.effectNum)
	FightController.instance:dispatchEvent(FightEvent.RougeMagicLimitChange)
	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
