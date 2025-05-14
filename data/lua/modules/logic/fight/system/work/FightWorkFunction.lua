module("modules.logic.fight.system.work.FightWorkFunction", package.seeall)

local var_0_0 = class("FightWorkFunction", FightWorkItem)

function var_0_0.onAwake(arg_1_0, arg_1_1, arg_1_2, ...)
	arg_1_0._func = arg_1_1
	arg_1_0._target = arg_1_2
	arg_1_0._param = {
		...
	}
	arg_1_0._paramCount = select("#", ...)
end

function var_0_0.onStart(arg_2_0)
	arg_2_0._func(arg_2_0._target, unpack(arg_2_0._param, 1, arg_2_0._paramCount))
	arg_2_0:onDone(true)
end

return var_0_0
