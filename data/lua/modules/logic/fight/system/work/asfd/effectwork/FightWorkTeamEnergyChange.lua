module("modules.logic.fight.system.work.asfd.effectwork.FightWorkTeamEnergyChange", package.seeall)

local var_0_0 = class("FightWorkTeamEnergyChange", FightEffectBase)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.SAFETIME = 1
end

function var_0_0.beforePlayEffectData(arg_2_0)
	local var_2_0 = arg_2_0.actEffectData.effectNum

	arg_2_0.beforeEnergy = FightDataHelper.ASFDDataMgr:getEnergy(var_2_0) or 0
end

var_0_0.WaitTime = 0.2

function var_0_0.onStart(arg_3_0)
	local var_3_0 = arg_3_0.actEffectData.effectNum
	local var_3_1 = FightDataHelper.ASFDDataMgr:getEnergy(var_3_0)

	FightController.instance:dispatchEvent(FightEvent.ASFD_TeamEnergyChange, var_3_0, arg_3_0.beforeEnergy, var_3_1)

	local var_3_2 = var_0_0.WaitTime / FightModel.instance:getSpeed()

	arg_3_0:com_registTimer(arg_3_0._delayDone, var_3_2)
end

return var_0_0
