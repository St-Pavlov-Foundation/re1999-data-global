module("modules.logic.fight.view.work.TimerWork", package.seeall)

slot0 = class("TimerWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._time = slot1
end

function slot0.onStart(slot0)
	TaskDispatcher.runDelay(slot0._onTimeout, slot0, slot0._time)
end

function slot0._onTimeout(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._onTimeout, slot0)
end

return slot0
