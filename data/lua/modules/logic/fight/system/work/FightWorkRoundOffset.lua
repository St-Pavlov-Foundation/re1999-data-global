module("modules.logic.fight.system.work.FightWorkRoundOffset", package.seeall)

local var_0_0 = class("FightWorkRoundOffset", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightModel.instance:getMaxRound()
	local var_1_1 = arg_1_0.actEffectData.effectNum

	FightModel.instance.maxRound = var_1_0 + var_1_1

	FightModel.instance:setRoundOffset(var_1_1)
	FightController.instance:dispatchEvent(FightEvent.RefreshUIRound)

	return arg_1_0:onDone(true)
end

return var_0_0
