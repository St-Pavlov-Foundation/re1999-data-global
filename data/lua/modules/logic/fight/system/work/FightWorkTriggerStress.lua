module("modules.logic.fight.system.work.FightWorkTriggerStress", package.seeall)

local var_0_0 = class("FightWorkTriggerStress", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0.actEffectData.targetId

	if not FightDataHelper.entityMgr:getById(var_1_0) then
		return arg_1_0:onDone(true)
	end

	local var_1_1 = arg_1_0.actEffectData.effectNum
	local var_1_2 = FightEnum.StressBehaviourConstId[var_1_1]
	local var_1_3 = var_1_2 and lua_stress_const.configDict[var_1_2]

	if not var_1_3 then
		return arg_1_0:onDone(true)
	end

	if arg_1_0:checkNeedWaitTimeLineHandle(arg_1_0.actEffectData) then
		FightModel.instance:recordDelayHandleStressBehaviour(arg_1_0.actEffectData)
	else
		local var_1_4 = tonumber(var_1_3.value)
		local var_1_5 = var_1_3.value2

		FightFloatMgr.instance:float(var_1_0, FightEnum.FloatType.stress, var_1_5, var_1_4)
		FightController.instance:dispatchEvent(FightEvent.TriggerStressBehaviour, var_1_0, var_1_1)
	end

	return arg_1_0:onDone(true)
end

function var_0_0.checkNeedWaitTimeLineHandle(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.configEffect
	local var_2_1 = var_2_0 and lua_stress_rule.configDict[var_2_0]

	return var_2_1 and var_2_1.type == "triggerSkill"
end

return var_0_0
