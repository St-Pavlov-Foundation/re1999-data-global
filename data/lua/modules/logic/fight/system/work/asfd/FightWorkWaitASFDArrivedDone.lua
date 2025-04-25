module("modules.logic.fight.system.work.asfd.FightWorkWaitASFDArrivedDone", package.seeall)

slot0 = class("FightWorkWaitASFDArrivedDone", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.stepMo = slot1
	slot0._fightStepMO = slot1
end

function slot0.onStart(slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 5)
	FightController.instance:registerCallback(FightEvent.ASFD_OnASFDArrivedDone, slot0.onASFDArrivedDone, slot0)
end

function slot0.onASFDArrivedDone(slot0)
	return slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.ASFD_OnASFDArrivedDone, slot0.onASFDArrivedDone, slot0)
end

function slot0._delayDone(slot0)
	logError("奥术飞弹 wait arrived 超时了")

	return slot0:onDone(true)
end

return slot0
