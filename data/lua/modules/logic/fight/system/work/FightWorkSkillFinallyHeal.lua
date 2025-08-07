module("modules.logic.fight.system.work.FightWorkSkillFinallyHeal", package.seeall)

local var_0_0 = class("FightWorkSkillFinallyHeal", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.fightStepData = arg_1_1
	arg_1_0._actEffect = {}
end

function var_0_0.addActEffectData(arg_2_0, arg_2_1)
	table.insert(arg_2_0._actEffect, arg_2_1)
end

function var_0_0.onStart(arg_3_0)
	local var_3_0 = FightHelper.getEntity(arg_3_0.fightStepData.fromId)

	if not var_3_0 then
		arg_3_0:onDone(true)

		return
	end

	local var_3_1 = arg_3_0.fightStepData.actId
	local var_3_2 = var_3_0:getMO()
	local var_3_3 = var_3_2 and var_3_2.skin
	local var_3_4 = FightConfig.instance:getSkinSkillTimeline(var_3_3, var_3_1)

	if string.nilorempty(var_3_4) then
		arg_3_0:onDone(true)

		return
	end

	TaskDispatcher.runDelay(arg_3_0._delayDone, arg_3_0, 20 / FightModel.instance:getSpeed())
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_3_0._onSkillEnd, arg_3_0)
	FightController.instance:registerCallback(FightEvent.OnTimelineHeal, arg_3_0._onTimelineHeal, arg_3_0)
end

function var_0_0._delayDone(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0._onSkillEnd(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_3 ~= arg_5_0.fightStepData then
		return
	end

	arg_5_0:_removeEvents()

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._actEffect) do
		local var_5_0 = FightHelper.getEntity(iter_5_1.targetId)

		if var_5_0 and not var_5_0.isDead then
			FightDataHelper.playEffectData(iter_5_1)

			if iter_5_1.effectType == FightEnum.EffectType.HEAL then
				FightFloatMgr.instance:float(var_5_0.id, FightEnum.FloatType.heal, iter_5_1.effectNum, nil, iter_5_1.effectNum1 == 1)
			elseif iter_5_1.effectType == FightEnum.EffectType.HEALCRIT then
				FightFloatMgr.instance:float(var_5_0.id, FightEnum.FloatType.crit_heal, iter_5_1.effectNum, nil, iter_5_1.effectNum1 == 1)
			end

			if var_5_0.nameUI then
				var_5_0.nameUI:addHp(iter_5_1.effectNum)

				if not FightSkillMgr.instance:isPlayingAnyTimeline() then
					var_5_0.nameUI:setActive(true)
				end
			end

			FightController.instance:dispatchEvent(FightEvent.OnHpChange, var_5_0, iter_5_1.effectNum)
		end
	end

	arg_5_0:onDone(true)
end

function var_0_0._onTimelineHeal(arg_6_0, arg_6_1)
	tabletool.removeValue(arg_6_0._actEffect, arg_6_1)
end

function var_0_0._removeEvents(arg_7_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_7_0._onSkillEnd, arg_7_0)
	FightController.instance:unregisterCallback(FightEvent.OnTimelineHeal, arg_7_0._onTimelineHeal, arg_7_0)
end

function var_0_0.clearWork(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._delayDone, arg_8_0)
	arg_8_0:_removeEvents()
end

return var_0_0
