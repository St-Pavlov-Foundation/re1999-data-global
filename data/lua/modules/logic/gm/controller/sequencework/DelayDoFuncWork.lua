module("modules.logic.gm.controller.sequencework.DelayDoFuncWork", package.seeall)

local var_0_0 = class("DelayDoFuncWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._func = arg_1_1
	arg_1_0._target = arg_1_2
	arg_1_0._delayTime = arg_1_3
	arg_1_0._param = arg_1_4
end

function var_0_0.onStart(arg_2_0)
	if not arg_2_0._delayTime or arg_2_0._delayTime == 0 then
		arg_2_0.hadDelayTask = false

		arg_2_0._func(arg_2_0._target, arg_2_0._param)
		arg_2_0:onDone(true)
	else
		arg_2_0.hadDelayTask = true

		TaskDispatcher.runDelay(arg_2_0._delayDoFunc, arg_2_0, arg_2_0._delayTime)
	end
end

function var_0_0._delayDoFunc(arg_3_0)
	arg_3_0._func(arg_3_0._target, arg_3_0._param)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	var_0_0.super.clearWork(arg_4_0)

	if arg_4_0.hadDelayTask then
		TaskDispatcher.cancelTask(arg_4_0._delayDoFunc, arg_4_0)
	end
end

return var_0_0
