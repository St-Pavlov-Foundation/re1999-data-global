module("modules.logic.fight.system.work.asfd.FightWorkWaitASFDEffectFlowDone", package.seeall)

slot0 = class("FightWorkWaitASFDEffectFlowDone", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.stepMo = slot1
	slot0._fightStepMO = slot1
end

function slot0.onStart(slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, FightASFDFlow.DelayWaitTime)
	FightController.instance:registerCallback(FightEvent.ASFD_OnASFDEffectFlowDone, slot0.onASFDEffectFlowDone, slot0)
end

function slot0.onASFDEffectFlowDone(slot0)
	return slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.ASFD_OnASFDEffectFlowDone, slot0.onASFDEffectFlowDone, slot0)
end

function slot0._delayDone(slot0)
	logError("奥术飞弹 wait effect 超时了")

	return slot0:onDone(true)
end

return slot0
