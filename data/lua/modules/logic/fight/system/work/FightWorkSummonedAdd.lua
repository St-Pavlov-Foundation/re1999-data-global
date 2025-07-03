module("modules.logic.fight.system.work.FightWorkSummonedAdd", package.seeall)

local var_0_0 = class("FightWorkSummonedAdd", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0._targetId = arg_1_0.actEffectData.targetId

	local var_1_0 = FightDataHelper.entityMgr:getById(arg_1_0._targetId)

	if var_1_0 and arg_1_0.actEffectData.summoned then
		local var_1_1 = var_1_0:getSummonedInfo():getData(arg_1_0.actEffectData.summoned.uid)
		local var_1_2 = FightConfig.instance:getSummonedConfig(var_1_1.summonedId, var_1_1.level)

		if var_1_2 then
			arg_1_0:com_registTimer(arg_1_0._delayDone, var_1_2.enterTime / 1000 / FightModel.instance:getSpeed())
			FightController.instance:dispatchEvent(FightEvent.SummonedAdd, arg_1_0._targetId, var_1_1)

			return
		end

		logError("挂件表找不到id:" .. var_1_1.summonedId .. "  等级:" .. var_1_1.level)
	end

	arg_1_0:_delayDone()
end

function var_0_0._delayDone(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
