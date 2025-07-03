module("modules.logic.fight.system.work.FightWorkUpdateStoredExPoint", package.seeall)

local var_0_0 = class("FightWorkUpdateStoredExPoint", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	arg_1_0._entityId = arg_1_0.actEffectData.targetId
	arg_1_0._entityMO = FightDataHelper.entityMgr:getById(arg_1_0._entityId)
	arg_1_0._oldValue = arg_1_0._entityMO and arg_1_0._entityMO:getStoredExPoint()
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = arg_2_0.actEffectData.targetId

	if not FightDataHelper.entityMgr:getById(var_2_0) then
		arg_2_0:onDone(true)

		return
	end

	arg_2_0._newValue = arg_2_0._entityMO and arg_2_0._entityMO:getStoredExPoint()

	FightController.instance:dispatchEvent(FightEvent.OnStoreExPointChange, arg_2_0._entityId, arg_2_0._oldValue)
	arg_2_0:onDone(true)
end

return var_0_0
