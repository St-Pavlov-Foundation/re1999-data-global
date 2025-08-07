module("modules.logic.fight.entity.comp.skill.FightTLEventStressTrigger", package.seeall)

local var_0_0 = class("FightTLEventStressTrigger", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_1.fromId
	local var_1_1 = FightModel.instance:popNoHandledStressBehaviour(var_1_0)

	if not var_1_1 then
		logError("压力触发技能动效帧, 但是没找到触发压力的effect")

		return
	end

	local var_1_2 = var_1_1.effectNum
	local var_1_3 = FightEnum.StressBehaviourConstId[var_1_2]
	local var_1_4 = var_1_3 and lua_stress_const.configDict[var_1_3]

	if not var_1_4 then
		logError(string.format("压力行为 %s 的常量配置不存在", var_1_2))

		return
	end

	local var_1_5 = tonumber(var_1_4.value)
	local var_1_6 = var_1_4.value2

	FightFloatMgr.instance:float(var_1_0, FightEnum.FloatType.stress, var_1_6, var_1_5, false)
	FightController.instance:dispatchEvent(FightEvent.TriggerStressBehaviour, var_1_0, var_1_2)

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.actEffect) do
		if iter_1_1.effectType == FightEnum.EffectType.POWERCHANGE and iter_1_1.targetId == var_1_0 and iter_1_1.configEffect == FightEnum.PowerType.Stress then
			local var_1_7 = FightDataHelper.entityMgr:getById(var_1_0)
			local var_1_8 = var_1_7 and var_1_7:getPowerInfo(FightEnum.PowerType.Stress)
			local var_1_9 = var_1_8 and var_1_8.num

			FightDataHelper.playEffectData(iter_1_1)

			local var_1_10 = var_1_8 and var_1_8.num

			if var_1_9 and var_1_10 and var_1_9 ~= var_1_10 then
				FightController.instance:dispatchEvent(FightEvent.PowerChange, var_1_0, FightEnum.PowerType.Stress, var_1_9, var_1_10)
			end

			break
		end
	end
end

function var_0_0.onTrackEnd(arg_2_0)
	return
end

function var_0_0.onDestructor(arg_3_0)
	return
end

return var_0_0
