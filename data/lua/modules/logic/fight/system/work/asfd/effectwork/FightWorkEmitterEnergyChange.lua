module("modules.logic.fight.system.work.asfd.effectwork.FightWorkEmitterEnergyChange", package.seeall)

local var_0_0 = class("FightWorkEmitterEnergyChange", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	local var_1_0 = arg_1_0.actEffectData.effectNum

	arg_1_0.beforeEnergy = FightDataHelper.ASFDDataMgr:getEmitterEnergy(var_1_0)
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = arg_2_0.actEffectData.effectNum
	local var_2_1 = FightDataHelper.ASFDDataMgr:getEmitterEnergy(var_2_0)

	FightController.instance:dispatchEvent(FightEvent.ASFD_EmitterEnergyChange, var_2_0, arg_2_0.beforeEnergy, var_2_1)

	return arg_2_0:onDone(true)
end

return var_0_0
