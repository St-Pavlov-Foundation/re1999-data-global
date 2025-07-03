module("modules.logic.fight.system.work.fightparamwork.FightParamChangeWork9", package.seeall)

local var_0_0 = class("FightParamChangeWork9", FightParamWorkBase)

function var_0_0.onStart(arg_1_0)
	FightController.instance:dispatchEvent(FightEvent.UpdateFightParam, arg_1_0.keyId, arg_1_0.oldValue, arg_1_0.currValue, arg_1_0.offset)
	arg_1_0:onDone(true)
end

return var_0_0
