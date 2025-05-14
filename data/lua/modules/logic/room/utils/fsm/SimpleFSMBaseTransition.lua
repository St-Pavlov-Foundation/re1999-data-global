module("modules.logic.room.utils.fsm.SimpleFSMBaseTransition", package.seeall)

local var_0_0 = class("SimpleFSMBaseTransition")

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.name = string.format("%s_to_%s_by_%s", arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.fromStateName = arg_1_1
	arg_1_0.toStateName = arg_1_2
	arg_1_0.eventId = arg_1_3
	arg_1_0.fsm = nil
	arg_1_0.context = nil
end

function var_0_0.register(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.fsm = arg_2_1
	arg_2_0.context = arg_2_2
end

function var_0_0.onDone(arg_3_0)
	arg_3_0.fsm:endTransition(arg_3_0.toStateName)
end

function var_0_0.start(arg_4_0)
	return
end

function var_0_0.check(arg_5_0)
	return true
end

function var_0_0.onStart(arg_6_0, arg_6_1)
	arg_6_0:onDone()
end

function var_0_0.stop(arg_7_0)
	return
end

function var_0_0.clear(arg_8_0)
	return
end

return var_0_0
