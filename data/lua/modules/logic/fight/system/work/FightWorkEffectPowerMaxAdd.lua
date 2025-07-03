module("modules.logic.fight.system.work.FightWorkEffectPowerMaxAdd", package.seeall)

local var_0_0 = class("FightWorkEffectPowerMaxAdd", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0.actEffectData.targetId
	local var_1_1 = FightHelper.getEntity(var_1_0)

	if not var_1_1 then
		arg_1_0:onDone(true)

		return
	end

	local var_1_2 = var_1_1:getMO()

	if not var_1_2 then
		arg_1_0:onDone(true)

		return
	end

	local var_1_3 = arg_1_0.actEffectData.configEffect

	if var_1_2:getPowerInfo(var_1_3) then
		FightController.instance:dispatchEvent(FightEvent.PowerMaxChange, var_1_0, var_1_3, arg_1_0.actEffectData.effectNum)
	end

	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
