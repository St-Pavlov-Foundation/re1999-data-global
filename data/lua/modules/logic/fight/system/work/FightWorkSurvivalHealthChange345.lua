module("modules.logic.fight.system.work.FightWorkSurvivalHealthChange345", package.seeall)

local var_0_0 = class("FightWorkSurvivalHealthChange345", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	arg_1_0.oldHealth = FightHelper.getSurvivalEntityHealth(arg_1_0.actEffectData.targetId)
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = FightHelper.getSurvivalEntityHealth(arg_2_0.actEffectData.targetId)
	local var_2_1 = arg_2_0.actEffectData.effectNum

	FightController.instance:dispatchEvent(FightEvent.HeroHealthValueChange, arg_2_0.actEffectData.targetId, arg_2_0.oldHealth, var_2_0, var_2_1)

	return arg_2_0:onDone(true)
end

return var_0_0
