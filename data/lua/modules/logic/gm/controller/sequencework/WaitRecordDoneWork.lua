module("modules.logic.gm.controller.sequencework.WaitRecordDoneWork", package.seeall)

slot0 = class("WaitRecordDoneWork", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0)
	if not PerformanceRecorder.instance:isRecording() then
		slot0:onDone(true)

		return
	end

	PerformanceRecorder.instance:registerCallback(PerformanceRecordEvent.onRecordDone, slot0.onRecordDone, slot0)
end

function slot0.onRecordDone(slot0)
	PerformanceRecorder.instance:unregisterCallback(PerformanceRecordEvent.onRecordDone, slot0.onRecordDone, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	PerformanceRecorder.instance:unregisterCallback(PerformanceRecordEvent.onRecordDone, slot0.onRecordDone, slot0)
end

return slot0
