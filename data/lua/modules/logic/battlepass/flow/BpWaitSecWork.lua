module("modules.logic.battlepass.flow.BpWaitSecWork", package.seeall)

local var_0_0 = class("BpWaitSecWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._sec = arg_1_1 or 1
end

function var_0_0.onStart(arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._delay, arg_2_0, arg_2_0._sec)
end

function var_0_0._delay(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delay, arg_4_0)
end

return var_0_0
