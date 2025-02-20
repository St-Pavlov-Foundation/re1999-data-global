module("modules.logic.fight.system.flow.FightSkillFlow", package.seeall)

slot0 = class("FightSkillFlow", BaseFlow)

function slot0.ctor(slot0, slot1)
	slot0._fightStepMO = slot1
	slot0._sequence = FlowSequence.New()
	slot7 = slot1

	slot0._sequence:addWork(FightWorkSkillSwitchSpine.New(slot7))

	slot2 = FlowParallel.New()

	slot0._sequence:addWork(slot2)

	slot8 = slot1

	slot2:addWork(FightWorkStepSkill.New(slot8))

	slot3 = nil

	for slot7, slot8 in ipairs(slot1.actEffectMOs) do
		if slot8.effectType == FightEnum.EffectType.DEAD then
			(slot3 or FlowParallel.New()):addWork(FightWork2Work.New(FightWorkEffectDeadPerformance, slot1, slot8, true))
		end
	end

	if slot3 then
		slot2:addWork(slot3)
	end

	slot4 = nil

	for slot8, slot9 in ipairs(slot1.actEffectMOs) do
		if (slot9.effectType == FightEnum.EffectType.HEAL or slot9.effectType == FightEnum.EffectType.HEALCRIT) and slot9.effectNum > 0 then
			if not slot4 then
				slot2:addWork(FightWorkSkillFinallyHeal.New(slot1))
			end

			slot4:addActEffectMO(slot9)
		end
	end
end

function slot0.onStart(slot0)
	FightController.instance:registerCallback(FightEvent.ParallelPlayNextSkillDoneThis, slot0._parallelDoneThis, slot0)
	FightController.instance:registerCallback(FightEvent.ForceEndSkillStep, slot0._forceEndSkillStep, slot0)
	FightController.instance:registerCallback(FightEvent.FightWorkStepSkillTimeout, slot0._onFightWorkStepSkillTimeout, slot0)
	slot0._sequence:registerDoneListener(slot0._skillFlowDone, slot0)
	slot0._sequence:start({})
end

function slot0._onFightWorkStepSkillTimeout(slot0, slot1)
	if slot1 == slot0._fightStepMO then
		if slot0._sequence then
			slot0._sequence:stop()
		end

		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	FightController.instance:dispatchEvent(FightEvent.OnSkillTimeLineDone, slot0._fightStepMO)
	FightController.instance:unregisterCallback(FightEvent.ParallelPlayNextSkillDoneThis, slot0._parallelDoneThis, slot0)
	FightController.instance:unregisterCallback(FightEvent.ForceEndSkillStep, slot0._forceEndSkillStep, slot0)
	FightController.instance:unregisterCallback(FightEvent.FightWorkStepSkillTimeout, slot0._onFightWorkStepSkillTimeout, slot0)
end

function slot0.onDestroy(slot0)
	if slot0._sequence then
		slot0._sequence:stop()
		slot0._sequence:unregisterDoneListener(slot0._skillFlowDone, slot0)

		slot0._sequence = nil
	end

	uv0.super.onDestroy(slot0)
end

function slot0.addAfterSkillEffects(slot0, slot1)
	slot5 = FightWorkSkillSwitchSpineEnd.New

	slot0._sequence:addWork(slot5(slot0._fightStepMO))

	for slot5, slot6 in ipairs(slot1) do
		slot0._sequence:addWork(slot6)
	end
end

function slot0.hasDone(slot0)
	if slot0._sequence and slot0._sequence.status == WorkStatus.Running then
		return false
	end

	return true
end

function slot0.stopSkillFlow(slot0)
	if slot0._sequence and slot0._sequence.status == WorkStatus.Running then
		slot0._sequence:stop()
		slot0._sequence:unregisterDoneListener(slot0._skillFlowDone, slot0)

		slot0._sequence = nil
	end

	FightController.instance:unregisterCallback(FightEvent.ParallelPlayNextSkillDoneThis, slot0._parallelDoneThis, slot0)
end

function slot0._skillFlowDone(slot0)
	if slot0._sequence then
		slot0._sequence:unregisterDoneListener(slot0._skillFlowDone, slot0)

		slot0._sequence = nil

		if slot0._parallelDone or slot0._forceEndDone then
			return
		end

		slot0:onDone(true)
	end
end

function slot0._parallelDoneThis(slot0, slot1)
	if slot0._fightStepMO == slot1 then
		slot0._parallelDone = true

		slot0:onDone(true)
	end
end

function slot0._forceEndSkillStep(slot0, slot1)
	if slot1 == slot0._fightStepMO then
		slot0._forceEndDone = true

		slot0:onDone(true)
	end
end

return slot0
