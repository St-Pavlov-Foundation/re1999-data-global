module("modules.logic.fight.system.work.FightWorkFightStep", package.seeall)

slot0 = class("FightWorkFightStep", FightEffectBase)

function slot0.onStart(slot0)
	if not slot0._workFlow then
		slot0._workFlow = FightWorkFlowSequence.New()
		FightStepBuilder.lastEffect = nil

		FightStepBuilder.addEffectWork(slot0._workFlow, slot0._actEffectMO.cus_stepMO)

		FightStepBuilder.lastEffect = nil
	end

	slot0._workFlow:addWork(Work2FightWork.New(FightWorkShowEquipSkillEffect, slot0._actEffectMO.cus_stepMO))

	if slot0._actEffectMO.cus_stepMO.actType == FightEnum.ActType.SKILL and not FightHelper.isTimelineStep(slot0._actEffectMO.cus_stepMO) then
		slot0._workFlow:addWork(Work2FightWork.New(FightNonTimelineSkillStep, slot0._actEffectMO.cus_stepMO))
	end

	slot0:cancelFightWorkSafeTimer()
	slot0._workFlow:registFinishCallback(slot0._onFlowDone, slot0)

	return slot0._workFlow:start()
end

function slot0.setFlow(slot0, slot1)
	slot0._workFlow = slot1
end

function slot0._onFlowDone(slot0)
	return slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._workFlow then
		slot0._workFlow:disposeSelf()

		slot0._workFlow = nil
	end
end

return slot0
