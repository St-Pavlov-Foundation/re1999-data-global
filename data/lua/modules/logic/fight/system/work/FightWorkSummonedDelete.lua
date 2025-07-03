module("modules.logic.fight.system.work.FightWorkSummonedDelete", package.seeall)

local var_0_0 = class("FightWorkSummonedDelete", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	arg_1_0._entityId = arg_1_0.actEffectData.targetId
	arg_1_0._uid = arg_1_0.actEffectData.reserveId
	arg_1_0._entityMO = FightDataHelper.entityMgr:getById(arg_1_0._entityId)

	local var_1_0 = arg_1_0._entityMO and arg_1_0._entityMO:getSummonedInfo()

	arg_1_0._oldValue = var_1_0 and var_1_0:getData(arg_1_0._uid)
end

function var_0_0.onStart(arg_2_0)
	if not arg_2_0._oldValue then
		arg_2_0:onDone(true)

		return
	end

	local var_2_0 = FightConfig.instance:getSummonedConfig(arg_2_0._oldValue.summonedId, arg_2_0._oldValue.level)

	if var_2_0 then
		arg_2_0:com_registTimer(arg_2_0._delayDone, var_2_0.closeTime / 1000 / FightModel.instance:getSpeed())
		FightController.instance:dispatchEvent(FightEvent.PlayRemoveSummoned, arg_2_0._entityId, arg_2_0._uid)

		return
	end

	logError("挂件表找不到id:" .. arg_2_0._oldValue.summonedId .. "  等级:" .. arg_2_0._oldValue.level)
	arg_2_0:onDone(true)
end

function var_0_0._delayDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	FightController.instance:dispatchEvent(FightEvent.SummonedDelete, arg_4_0._entityId, arg_4_0._uid)
end

return var_0_0
