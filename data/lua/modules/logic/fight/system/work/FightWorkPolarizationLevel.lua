module("modules.logic.fight.system.work.FightWorkPolarizationLevel", package.seeall)

local var_0_0 = class("FightWorkPolarizationLevel", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	FightRoundSequence.roundTempData.PolarizationLevel = FightRoundSequence.roundTempData.PolarizationLevel or {}
	FightRoundSequence.roundTempData.PolarizationLevel[arg_1_0.actEffectData.configEffect] = arg_1_0.actEffectData

	FightController.instance:dispatchEvent(FightEvent.PolarizationLevel, arg_1_0.actEffectData.effectNum)
	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
