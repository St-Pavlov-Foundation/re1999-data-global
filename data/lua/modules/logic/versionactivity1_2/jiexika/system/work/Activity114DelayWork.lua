module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114DelayWork", package.seeall)

local var_0_0 = class("Activity114DelayWork", Activity114BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._sec = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	if arg_2_0._sec then
		TaskDispatcher.runDelay(arg_2_0.onDelay, arg_2_0, arg_2_0._sec)
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0.onDelay(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.onDelay, arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.onDelay, arg_4_0)
end

return var_0_0
