module("modules.logic.fight.system.work.FightWorkWaitDialog", package.seeall)

slot0 = class("FightWorkWaitDialog", BaseWork)

function slot0.onStart(slot0)
	if gohelper.find("UIRoot/HUD/FightView/root/#go_dialogcontainer") and slot1.activeInHierarchy then
		TaskDispatcher.runDelay(slot0._delayDone, slot0, 60)
		FightController.instance:registerCallback(FightEvent.FightDialogShow, slot0._onFightDialogShow, slot0)
		FightController.instance:registerCallback(FightEvent.FightDialogEnd, slot0._onFightDialogEnd, slot0)
	else
		slot0:onDone(true)
	end
end

function slot0._onFightDialogShow(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 60)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0._onFightDialogEnd(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.FightDialogShow, slot0._onFightDialogShow, slot0)
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, slot0._onFightDialogEnd, slot0)
end

return slot0
