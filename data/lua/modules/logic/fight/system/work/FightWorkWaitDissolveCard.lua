module("modules.logic.fight.system.work.FightWorkWaitDissolveCard", package.seeall)

slot0 = class("FightWorkWaitDissolveCard", BaseWork)

function slot0.ctor(slot0, slot1, slot2, slot3)
	slot0._fightStepMO = slot1
	slot0._fightActEffectMO = slot2
	slot0._isDeadInSkill = slot3
end

function slot0.onStart(slot0)
	if FightModel.instance:getVersion() >= 1 then
		slot0:onDone(true)

		return
	end

	if not FightDataHelper.entityMgr:getById(slot0._fightActEffectMO.targetId) or slot2.side ~= FightEnum.EntitySide.MySide then
		slot0:onDone(true)

		return
	end

	if slot0._isDeadInSkill then
		FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	else
		TaskDispatcher.runDelay(slot0._waitForCardDissolveStart, slot0, 0.5 / Mathf.Clamp(FightModel.instance:getUISpeed(), 0.01, 100))
	end
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2, slot3, slot4)
	if slot3 == slot0._fightStepMO then
		FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
		TaskDispatcher.runDelay(slot0._waitForCardDissolveStart, slot0, 0.5 / Mathf.Clamp(FightModel.instance:getUISpeed(), 0.01, 100))
	end
end

function slot0._waitForCardDissolveStart(slot0)
	if FightCardModel.instance:isDissolving() then
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, slot0._onCombineCardEnd, slot0)
		TaskDispatcher.runDelay(slot0._timeOut, slot0, 10 / Mathf.Clamp(FightModel.instance:getUISpeed(), 0.01, 100))
	else
		slot0:onDone(true)
	end
end

function slot0._onCombineCardEnd(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, slot0._onCombineCardEnd, slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.1 / FightModel.instance:getUISpeed())
end

function slot0._timeOut(slot0)
	logNormal("FightWorkWaitDissolveCard 奇怪，超时结束 done")
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, slot0._onCombineCardEnd, slot0)
	TaskDispatcher.cancelTask(slot0._waitForCardDissolveStart, slot0)
	TaskDispatcher.cancelTask(slot0._timeOut, slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
