module("framework.core.workflow.work.impl.WorkWaitSeconds", package.seeall)

local var_0_0 = class("WorkWaitSeconds", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._waitSeconds = arg_1_1 or 0.01
end

function var_0_0.onStart(arg_2_0)
	arg_2_0._startTime = Time.realtimeSinceStartup

	TaskDispatcher.runDelay(arg_2_0._onTimeEnd, arg_2_0, arg_2_0._waitSeconds)
end

function var_0_0.onStop(arg_3_0)
	arg_3_0._waitSeconds = Time.realtimeSinceStartup - arg_3_0._startTime

	TaskDispatcher.cancelTask(arg_3_0._onTimeEnd, arg_3_0)
end

function var_0_0.onResume(arg_4_0)
	if arg_4_0._waitSeconds > 0 then
		TaskDispatcher.runDelay(arg_4_0._onTimeEnd, arg_4_0, arg_4_0._waitSeconds)
	else
		arg_4_0:onDone(true)
	end
end

function var_0_0.onReset(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._onTimeEnd, arg_5_0)
end

function var_0_0.onDestroy(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._onTimeEnd, arg_6_0)
end

function var_0_0._onTimeEnd(arg_7_0)
	arg_7_0:onDone(true)
end

return var_0_0
