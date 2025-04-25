module("modules.logic.fight.system.work.asfd.FightWorkASFDDone", package.seeall)

slot0 = class("FightWorkASFDDone", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.stepMo = slot1
	slot0._fightStepMO = slot1
end

function slot0.onStart(slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 3)

	if FightHelper.getASFDMgr() then
		slot1:onASFDFlowDone(slot0.stepMo)
	end

	FightController.instance:dispatchEvent(FightEvent.ASFD_OnDone, slot0.stepMo and slot0.stepMo.cardIndex)

	return slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

function slot0._delayDone(slot0)
	logError("奥术飞弹 Done 超时了")

	return slot0:onDone(true)
end

return slot0
