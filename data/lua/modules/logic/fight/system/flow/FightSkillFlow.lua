module("modules.logic.fight.system.flow.FightSkillFlow", package.seeall)

local var_0_0 = class("FightSkillFlow", BaseFlow)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.fightStepData = arg_1_1
	arg_1_0._sequence = FlowSequence.New()

	arg_1_0._sequence:addWork(FightWorkSkillSwitchSpine.New(arg_1_1))

	local var_1_0 = FlowParallel.New()

	arg_1_0._sequence:addWork(var_1_0)
	var_1_0:addWork(FightWorkStepSkill.New(arg_1_1))

	local var_1_1

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.actEffect) do
		if iter_1_1.effectType == FightEnum.EffectType.DEAD then
			local var_1_2 = FightWork2Work.New(FightWorkEffectDeadPerformance, arg_1_1, iter_1_1, true)

			var_1_1 = var_1_1 or FlowParallel.New()

			var_1_1:addWork(var_1_2)
		end
	end

	if var_1_1 then
		var_1_0:addWork(var_1_1)
	end

	local var_1_3

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.actEffect) do
		if (iter_1_3.effectType == FightEnum.EffectType.HEAL or iter_1_3.effectType == FightEnum.EffectType.HEALCRIT) and iter_1_3.effectNum > 0 then
			if not var_1_3 then
				var_1_3 = FightWorkSkillFinallyHeal.New(arg_1_1)

				var_1_0:addWork(var_1_3)
			end

			var_1_3:addActEffectData(iter_1_3)
		end
	end
end

function var_0_0.onStart(arg_2_0)
	FightController.instance:registerCallback(FightEvent.ParallelPlayNextSkillDoneThis, arg_2_0._parallelDoneThis, arg_2_0)
	FightController.instance:registerCallback(FightEvent.ForceEndSkillStep, arg_2_0._forceEndSkillStep, arg_2_0)
	FightController.instance:registerCallback(FightEvent.FightWorkStepSkillTimeout, arg_2_0._onFightWorkStepSkillTimeout, arg_2_0)
	arg_2_0._sequence:registerDoneListener(arg_2_0._skillFlowDone, arg_2_0)
	arg_2_0._sequence:start({})
end

function var_0_0._onFightWorkStepSkillTimeout(arg_3_0, arg_3_1)
	if arg_3_1 == arg_3_0.fightStepData then
		if arg_3_0._sequence then
			arg_3_0._sequence:stop()
		end

		arg_3_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_4_0)
	FightController.instance:dispatchEvent(FightEvent.OnSkillTimeLineDone, arg_4_0.fightStepData)
	FightController.instance:unregisterCallback(FightEvent.ParallelPlayNextSkillDoneThis, arg_4_0._parallelDoneThis, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.ForceEndSkillStep, arg_4_0._forceEndSkillStep, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.FightWorkStepSkillTimeout, arg_4_0._onFightWorkStepSkillTimeout, arg_4_0)
end

function var_0_0.onDestroy(arg_5_0)
	if arg_5_0._sequence then
		arg_5_0._sequence:stop()
		arg_5_0._sequence:unregisterDoneListener(arg_5_0._skillFlowDone, arg_5_0)

		arg_5_0._sequence = nil
	end

	var_0_0.super.onDestroy(arg_5_0)
end

function var_0_0.addAfterSkillEffects(arg_6_0, arg_6_1)
	arg_6_0._sequence:addWork(FightWorkSkillSwitchSpineEnd.New(arg_6_0.fightStepData))

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		arg_6_0._sequence:addWork(iter_6_1)
	end
end

function var_0_0.hasDone(arg_7_0)
	if arg_7_0._sequence and arg_7_0._sequence.status == WorkStatus.Running then
		return false
	end

	return true
end

function var_0_0.stopSkillFlow(arg_8_0)
	if arg_8_0._sequence and arg_8_0._sequence.status == WorkStatus.Running then
		arg_8_0._sequence:stop()
		arg_8_0._sequence:unregisterDoneListener(arg_8_0._skillFlowDone, arg_8_0)

		arg_8_0._sequence = nil
	end

	FightController.instance:unregisterCallback(FightEvent.ParallelPlayNextSkillDoneThis, arg_8_0._parallelDoneThis, arg_8_0)
end

function var_0_0._skillFlowDone(arg_9_0)
	if arg_9_0._sequence then
		arg_9_0._sequence:unregisterDoneListener(arg_9_0._skillFlowDone, arg_9_0)

		arg_9_0._sequence = nil

		if arg_9_0._parallelDone or arg_9_0._forceEndDone then
			return
		end

		arg_9_0:onDone(true)
	end
end

function var_0_0._parallelDoneThis(arg_10_0, arg_10_1)
	if arg_10_0.fightStepData == arg_10_1 then
		arg_10_0._parallelDone = true

		arg_10_0:onDone(true)
	end
end

function var_0_0._forceEndSkillStep(arg_11_0, arg_11_1)
	if arg_11_1 == arg_11_0.fightStepData then
		arg_11_0._forceEndDone = true

		arg_11_0:onDone(true)
	end
end

return var_0_0
