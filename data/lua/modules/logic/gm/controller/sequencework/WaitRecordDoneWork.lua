module("modules.logic.gm.controller.sequencework.WaitRecordDoneWork", package.seeall)

local var_0_0 = class("WaitRecordDoneWork", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0)
	if not PerformanceRecorder.instance:isRecording() then
		arg_2_0:onDone(true)

		return
	end

	PerformanceRecorder.instance:registerCallback(PerformanceRecordEvent.onRecordDone, arg_2_0.onRecordDone, arg_2_0)
end

function var_0_0.onRecordDone(arg_3_0)
	PerformanceRecorder.instance:unregisterCallback(PerformanceRecordEvent.onRecordDone, arg_3_0.onRecordDone, arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	PerformanceRecorder.instance:unregisterCallback(PerformanceRecordEvent.onRecordDone, arg_4_0.onRecordDone, arg_4_0)
end

return var_0_0
