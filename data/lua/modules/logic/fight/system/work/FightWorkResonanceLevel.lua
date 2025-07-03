module("modules.logic.fight.system.work.FightWorkResonanceLevel", package.seeall)

local var_0_0 = class("FightWorkResonanceLevel", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	FightRoundSequence.roundTempData.ResonanceLevel = arg_1_0.actEffectData.effectNum

	FightController.instance:dispatchEvent(FightEvent.ResonanceLevel, arg_1_0.actEffectData.effectNum)
	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
