module("modules.logic.fight.system.work.FightWorkFightStep", package.seeall)

local var_0_0 = class("FightWorkFightStep", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if not arg_1_0._workFlow then
		arg_1_0._workFlow = FightWorkFlowSequence.New()
		FightStepBuilder.lastEffect = nil

		FightStepBuilder.addEffectWork(arg_1_0._workFlow, arg_1_0.actEffectData.fightStep)

		FightStepBuilder.lastEffect = nil
	end

	arg_1_0._workFlow:addWork(Work2FightWork.New(FightWorkShowEquipSkillEffect, arg_1_0.actEffectData.fightStep))

	if arg_1_0.actEffectData.fightStep.actType == FightEnum.ActType.SKILL and not FightHelper.isTimelineStep(arg_1_0.actEffectData.fightStep) then
		arg_1_0._workFlow:addWork(Work2FightWork.New(FightNonTimelineSkillStep, arg_1_0.actEffectData.fightStep))
	end

	arg_1_0:cancelFightWorkSafeTimer()
	arg_1_0._workFlow:registFinishCallback(arg_1_0._onFlowDone, arg_1_0)

	return arg_1_0._workFlow:start()
end

function var_0_0.setFlow(arg_2_0, arg_2_1)
	arg_2_0._workFlow = arg_2_1
end

function var_0_0._onFlowDone(arg_3_0)
	return arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0._workFlow then
		arg_4_0._workFlow:disposeSelf()

		arg_4_0._workFlow = nil
	end
end

return var_0_0
