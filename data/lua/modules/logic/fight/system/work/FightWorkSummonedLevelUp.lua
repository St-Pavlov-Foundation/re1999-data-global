module("modules.logic.fight.system.work.FightWorkSummonedLevelUp", package.seeall)

local var_0_0 = class("FightWorkSummonedLevelUp", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	arg_1_0._entityId = arg_1_0.actEffectData.targetId
	arg_1_0._uid = arg_1_0.actEffectData.reserveId
	arg_1_0._entityMO = FightDataHelper.entityMgr:getById(arg_1_0._entityId)

	local var_1_0 = arg_1_0._entityMO and arg_1_0._entityMO:getSummonedInfo()

	arg_1_0._summonedData = var_1_0 and var_1_0:getData(arg_1_0._uid)
	arg_1_0._oldLevel = arg_1_0._summonedData and arg_1_0._summonedData.level
end

function var_0_0.onStart(arg_2_0)
	if not arg_2_0._summonedData then
		arg_2_0:onDone(true)

		return
	end

	arg_2_0._newLevel = arg_2_0._summonedData.level

	local var_2_0 = FightConfig.instance:getSummonedConfig(arg_2_0._summonedData.summonedId, arg_2_0._summonedData.level)

	if var_2_0 then
		arg_2_0:com_registTimer(arg_2_0._delayDone, var_2_0.enterTime / 1000 / FightModel.instance:getSpeed())
		FightController.instance:dispatchEvent(FightEvent.SummonedLevelChange, arg_2_0._entityId, arg_2_0._uid, arg_2_0._oldLevel, arg_2_0._newLevel)

		return
	end

	logError("挂件表找不到id:" .. arg_2_0._summonedData.summonedId .. "  等级:" .. arg_2_0._summonedData.level)
	arg_2_0:onDone(true)
end

function var_0_0._delayDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	return
end

return var_0_0
