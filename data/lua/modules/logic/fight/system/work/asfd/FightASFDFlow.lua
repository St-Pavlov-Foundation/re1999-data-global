module("modules.logic.fight.system.work.asfd.FightASFDFlow", package.seeall)

slot0 = class("FightASFDFlow", BaseFlow)
slot0.DelayWaitTime = 61

function slot0.ctor(slot0, slot1, slot2, slot3)
	slot0.stepMo = slot1
	slot0.curIndex = slot3
	slot0._sequence = FlowSequence.New()

	slot0._sequence:addWork(FightWorkCreateASFDEmitter.New(slot1))
	FlowSequence.New():addWork(FightWorkMissileASFD.New(slot1, slot0.curIndex))

	slot5 = FlowParallel.New()

	if slot0:checkNeedAddWaitDoneWork(slot2) then
		slot4:addWork(FightWorkMissileASFDDone.New(slot1))
		slot5:addWork(FightWorkWaitASFDArrivedDone.New(slot1))
	end

	slot5:addWork(slot4)
	slot0._sequence:addWork(slot5)
	slot0._sequence:addWork(FightWorkASFDEffectFlow.New(slot1))

	if slot6 then
		slot0._sequence:addWork(FightWorkASFDDone.New(slot1))
	else
		slot0._sequence:addWork(FightWorkASFDContinueDone.New(slot1))
	end
end

function slot0.checkNeedAddWaitDoneWork(slot0, slot1)
	if slot0:checkHasMonsterChangeEffectType(slot0.stepMo) then
		return true
	end

	if not slot1 then
		return true
	end

	if not FightHelper.isASFDSkill(slot1.actId) then
		return true
	end

	return false
end

function slot0.checkHasMonsterChangeEffectType(slot0, slot1)
	if not slot1 then
		return false
	end

	for slot5, slot6 in ipairs(slot1.actEffectMOs) do
		if slot6.effectType == FightEnum.EffectType.MONSTERCHANGE then
			return true
		end

		if slot6.effectType == FightEnum.EffectType.FIGHTSTEP and slot0:checkHasMonsterChangeEffectType(slot6.cus_stepMO) then
			return true
		end
	end

	return false
end

function slot0.onStart(slot0)
	slot0._sequence:registerDoneListener(slot0._flowDone, slot0)
	slot0._sequence:start()
end

function slot0.hasDone(slot0)
	return not slot0._sequence or slot0._sequence.status ~= WorkStatus.Running
end

function slot0.stopSkillFlow(slot0)
	if slot0._sequence and slot0._sequence.status == WorkStatus.Running then
		slot0._sequence:stop()
		slot0._sequence:unregisterDoneListener(slot0._flowDone, slot0)

		slot0._sequence = nil
	end
end

function slot0._flowDone(slot0)
	if slot0._sequence then
		slot0._sequence:unregisterDoneListener(slot0._flowDone, slot0)

		slot0._sequence = nil
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._sequence then
		slot0._sequence:stop()
		slot0._sequence:unregisterDoneListener(slot0._flowDone, slot0)

		slot0._sequence = nil
	end
end

return slot0
