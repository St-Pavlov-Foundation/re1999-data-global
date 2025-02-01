module("framework.core.workflow.work.impl.WorkWaitSeconds", package.seeall)

slot0 = class("WorkWaitSeconds", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._waitSeconds = slot1 or 0.01
end

function slot0.onStart(slot0)
	slot0._startTime = Time.realtimeSinceStartup

	TaskDispatcher.runDelay(slot0._onTimeEnd, slot0, slot0._waitSeconds)
end

function slot0.onStop(slot0)
	slot0._waitSeconds = Time.realtimeSinceStartup - slot0._startTime

	TaskDispatcher.cancelTask(slot0._onTimeEnd, slot0)
end

function slot0.onResume(slot0)
	if slot0._waitSeconds > 0 then
		TaskDispatcher.runDelay(slot0._onTimeEnd, slot0, slot0._waitSeconds)
	else
		slot0:onDone(true)
	end
end

function slot0.onReset(slot0)
	TaskDispatcher.cancelTask(slot0._onTimeEnd, slot0)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._onTimeEnd, slot0)
end

function slot0._onTimeEnd(slot0)
	slot0:onDone(true)
end

return slot0
