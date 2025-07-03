module("modules.logic.fight.system.work.FightWorkEffectPowerChange", package.seeall)

local var_0_0 = class("FightWorkEffectPowerChange", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	arg_1_0._entityId = arg_1_0.actEffectData.targetId
	arg_1_0._entityMO = FightDataHelper.entityMgr:getById(arg_1_0._entityId)
	arg_1_0._powerId = arg_1_0.actEffectData.configEffect
	arg_1_0._powerData = arg_1_0._entityMO and arg_1_0._entityMO:getPowerInfo(arg_1_0._powerId)
	arg_1_0._oldValue = arg_1_0._powerData and arg_1_0._powerData.num
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = arg_2_0.actEffectData.targetId

	if not FightHelper.getEntity(var_2_0) then
		arg_2_0:onDone(true)

		return
	end

	if not arg_2_0._entityMO then
		arg_2_0:onDone(true)

		return
	end

	arg_2_0._powerData = arg_2_0._entityMO and arg_2_0._entityMO:getPowerInfo(arg_2_0._powerId)

	if not arg_2_0._powerData then
		logError(string.format("找不到灵光数据,灵光id:%s, 角色或怪物id:%s, 步骤类型:%s, actId:%s", arg_2_0._powerId, arg_2_0._entityMO.modelId, arg_2_0.fightStepData.actType, arg_2_0.fightStepData.actId))
		arg_2_0:onDone(true)

		return
	end

	arg_2_0._newValue = arg_2_0._powerData and arg_2_0._powerData.num

	if arg_2_0._oldValue ~= arg_2_0._newValue then
		FightController.instance:dispatchEvent(FightEvent.PowerChange, arg_2_0.actEffectData.targetId, arg_2_0._powerId, arg_2_0._oldValue, arg_2_0._newValue)
	end

	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
