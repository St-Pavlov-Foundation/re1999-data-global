module("modules.logic.fight.system.work.FightWorkMaxHpChange", package.seeall)

local var_0_0 = class("FightWorkMaxHpChange", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0:_startChangeMaxHp()
end

function var_0_0.beforePlayEffectData(arg_2_0)
	arg_2_0._entityId = arg_2_0.actEffectData.targetId
	arg_2_0._entityMO = FightDataHelper.entityMgr:getById(arg_2_0._entityId)
	arg_2_0._oldValue = arg_2_0._entityMO and arg_2_0._entityMO.attrMO.hp
end

function var_0_0._startChangeMaxHp(arg_3_0)
	if not FightHelper.getEntity(arg_3_0._entityId) then
		arg_3_0:onDone(true)

		return
	end

	if not arg_3_0._entityMO then
		arg_3_0:onDone(true)

		return
	end

	arg_3_0._newValue = arg_3_0._entityMO and arg_3_0._entityMO.attrMO.hp

	FightController.instance:dispatchEvent(FightEvent.OnMaxHpChange, arg_3_0.actEffectData.targetId, arg_3_0._oldValue, arg_3_0._newValue)
	arg_3_0:_onDone()
end

function var_0_0._onDone(arg_4_0)
	arg_4_0:clearWork()
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	return
end

return var_0_0
