module("modules.logic.fight.system.work.FightWorkSaveFightRecordUpdate", package.seeall)

local var_0_0 = class("FightWorkSaveFightRecordUpdate", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	local var_1_0 = arg_1_0.actEffectData.entity and arg_1_0.actEffectData.entity.uid
	local var_1_1 = var_1_0 and FightHelper.getEntity(var_1_0)
	local var_1_2 = var_1_1 and var_1_1:getMO()

	arg_1_0.beforeHp = var_1_2 and var_1_2.currentHp or 0
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = arg_2_0.actEffectData.entity and arg_2_0.actEffectData.entity.uid
	local var_2_1 = var_2_0 and FightHelper.getEntity(var_2_0)

	if not var_2_1 then
		return
	end

	if var_2_1.nameUI then
		var_2_1.nameUI:resetHp()
	end

	local var_2_2 = var_2_1 and var_2_1:getMO()
	local var_2_3 = var_2_2 and var_2_2.currentHp or 0

	FightController.instance:dispatchEvent(FightEvent.OnHpChange, var_2_1, var_2_3 - arg_2_0.beforeHp)

	return arg_2_0:onDone(true)
end

return var_0_0
