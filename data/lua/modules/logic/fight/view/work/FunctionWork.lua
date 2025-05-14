module("modules.logic.fight.view.work.FunctionWork", package.seeall)

local var_0_0 = class("FunctionWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0:setParam(arg_1_1, arg_1_2, arg_1_3)
end

function var_0_0.setParam(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._func = arg_2_1
	arg_2_0._target = arg_2_2
	arg_2_0._param = arg_2_3
end

function var_0_0.onStart(arg_3_0)
	arg_3_0._func(arg_3_0._target, arg_3_0._param)
	arg_3_0:onDone(true)
end

return var_0_0
