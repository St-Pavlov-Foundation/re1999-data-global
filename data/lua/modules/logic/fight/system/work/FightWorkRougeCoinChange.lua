module("modules.logic.fight.system.work.FightWorkRougeCoinChange", package.seeall)

local var_0_0 = class("FightWorkRougeCoinChange", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.Coin)

	FightModel.instance:setRougeExData(FightEnum.ExIndexForRouge.Coin, var_1_0 + arg_1_0.actEffectData.effectNum)
	FightController.instance:dispatchEvent(FightEvent.RougeCoinChange, arg_1_0.actEffectData.effectNum)
	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
