module("modules.logic.battlepass.flow.BpWaitSecWork", package.seeall)

slot0 = class("BpWaitSecWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._sec = slot1 or 1
end

function slot0.onStart(slot0)
	TaskDispatcher.runDelay(slot0._delay, slot0, slot0._sec)
end

function slot0._delay(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delay, slot0)
end

return slot0
