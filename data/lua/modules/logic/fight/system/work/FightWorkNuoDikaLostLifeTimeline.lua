module("modules.logic.fight.system.work.FightWorkNuoDikaLostLifeTimeline", package.seeall)

local var_0_0 = class("FightWorkNuoDikaLostLifeTimeline", FightWorkItem)

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.actEffectData = arg_1_1
	arg_1_0.fightStepData = arg_1_2
	arg_1_0.timelineName = arg_1_3
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = arg_2_0.actEffectData
	local var_2_1 = var_2_0.targetId
	local var_2_2 = arg_2_0.fightStepData

	FightDataHelper.playEffectData(var_2_0)

	local var_2_3 = FightEnum.FloatType.damage

	if var_2_0.effectType == FightEnum.EffectType.CRIT then
		var_2_3 = FightEnum.FloatType.crit_damage
	end

	local var_2_4 = FightHelper.getEntity(var_2_1)

	if var_2_4 then
		local var_2_5 = var_2_0.effectNum

		if var_2_5 > 0 then
			local var_2_6 = var_2_4:isMySide() and -var_2_5 or var_2_5

			FightFloatMgr.instance:float(var_2_4.id, var_2_3, var_2_6)

			if var_2_4.nameUI then
				var_2_4.nameUI:addHp(-var_2_5)
			end

			FightController.instance:dispatchEvent(FightEvent.OnHpChange, var_2_4, -var_2_5)
		end
	end

	local var_2_7 = var_2_1

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.fightStepData.actEffect) do
		if iter_2_1.configEffect == 60216 then
			var_2_7 = iter_2_1.targetId

			break
		end
	end

	local var_2_8 = FightStepData.New(FightDef_pb.FightStep())

	var_2_8.isFakeStep = true
	var_2_8.fromId = var_2_1
	var_2_8.toId = var_2_7
	var_2_8.actType = FightEnum.ActType.SKILL
	var_2_0.targetId = var_2_7

	table.insert(var_2_8.actEffect, var_2_0)

	local var_2_9 = var_2_4.skill:registTimelineWork(arg_2_0.timelineName, var_2_8)

	arg_2_0:playWorkAndDone(var_2_9)
end

return var_0_0
