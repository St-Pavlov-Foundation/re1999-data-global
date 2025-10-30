module("modules.logic.fight.system.work.FightWorkBuffDelReason352", package.seeall)

local var_0_0 = class("FightWorkBuffDelReason352", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0.actEffectData.targetId
	local var_1_1 = arg_1_0.actEffectData.reserveId
	local var_1_2 = arg_1_0.actEffectData.effectNum

	FightController.instance:dispatchEvent(FightEvent.OnPushBuffDeleteReason, var_1_0, var_1_1, var_1_2)

	return arg_1_0:onDone(true)
end

return var_0_0
