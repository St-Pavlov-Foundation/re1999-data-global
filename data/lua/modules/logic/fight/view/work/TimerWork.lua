module("modules.logic.fight.view.work.TimerWork", package.seeall)

local var_0_0 = class("TimerWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._time = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._onTimeout, arg_2_0, arg_2_0._time)
end

function var_0_0._onTimeout(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._onTimeout, arg_4_0)
end

return var_0_0
