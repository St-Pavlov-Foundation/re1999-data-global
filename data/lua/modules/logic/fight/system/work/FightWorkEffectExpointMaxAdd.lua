module("modules.logic.fight.system.work.FightWorkEffectExpointMaxAdd", package.seeall)

local var_0_0 = class("FightWorkEffectExpointMaxAdd", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0.actEffectData.targetId

	FightController.instance:dispatchEvent(FightEvent.OnExpointMaxAdd, var_1_0, arg_1_0.actEffectData.effectNum)
	arg_1_0:onDone(true)
end

function var_0_0._startAddExpointMax(arg_2_0)
	local var_2_0 = arg_2_0.actEffectData.targetId
	local var_2_1 = FightHelper.getEntity(var_2_0)

	if not var_2_1 then
		arg_2_0:onDone(true)

		return
	end

	local var_2_2 = var_2_1:getMO()

	if not var_2_2 then
		arg_2_0:onDone(true)

		return
	end

	if var_2_2:hasBuffFeature(FightEnum.BuffType_SpExPointMaxAdd) then
		arg_2_0:onDone(true)

		return
	end

	var_2_2:changeExpointMaxAdd(arg_2_0.actEffectData.effectNum)
	FightController.instance:dispatchEvent(FightEvent.OnExpointMaxAdd, var_2_0, arg_2_0.actEffectData.effectNum)
	arg_2_0:_onDone()
end

function var_0_0._onDone(arg_3_0)
	arg_3_0:clearWork()
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	return
end

return var_0_0
