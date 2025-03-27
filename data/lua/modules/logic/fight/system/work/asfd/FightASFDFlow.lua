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
		slot5:addWork(FightWorkWaitASFDExplosionDone.New(slot1))
		slot5:addWork(FightWorkWaitASFDEffectFlowDone.New(slot1))
	else
		slot5:addWork(FightWorkWaitASFDEffectFlowDone.New(slot1))
	end

	slot5:addWork(slot4)
	slot0._sequence:addWork(slot5)

	if slot0:checkNeedAddWaitDoneWork(slot2) then
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

function slot0.addDelayDoneWork(slot0)
	TaskDispatcher.runDelay(slot0.delayDone, slot0, uv0.DelayWaitTime + 10)
end

function slot0.cancelDelayDoneWork(slot0)
	TaskDispatcher.cancelTask(slot0.delayDone, slot0)
end

function slot0.onStart(slot0)
	FightController.instance:registerCallback(FightEvent.FightDialogShow, slot0.onFightDialogShow, slot0)
	FightController.instance:registerCallback(FightEvent.FightDialogEnd, slot0.onFightDialogEnd, slot0)
	slot0:addDelayDoneWork()
	slot0._sequence:registerDoneListener(slot0._flowDone, slot0)
	slot0._sequence:start()
end

function slot0.delayDone(slot0)
	logError("奥术飞弹flow超时了")
	slot0:onDone(true)
end

function slot0.onFightDialogShow(slot0)
	slot0:cancelDelayDoneWork()
	slot0:addDelayDoneWork()
end

function slot0.onFightDialogEnd(slot0)
	slot0:addDelayDoneWork()
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

	slot0:cancelDelayDoneWork()
	FightController.instance:unregisterCallback(FightEvent.FightDialogShow, slot0.onFightDialogShow, slot0)
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, slot0.onFightDialogEnd, slot0)
end

return slot0
