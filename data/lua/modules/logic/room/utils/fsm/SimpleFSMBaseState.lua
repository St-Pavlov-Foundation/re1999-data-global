module("modules.logic.room.utils.fsm.SimpleFSMBaseState", package.seeall)

local var_0_0 = class("SimpleFSMBaseState")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.name = arg_1_1
	arg_1_0.fsm = nil
	arg_1_0.context = nil
end

function var_0_0.register(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.fsm = arg_2_1
	arg_2_0.context = arg_2_2
end

function var_0_0.start(arg_3_0)
	return
end

function var_0_0.onEnter(arg_4_0)
	RoomMapController.instance:dispatchEvent(RoomEvent.FSMEnterState, arg_4_0.name)
end

function var_0_0.onLeave(arg_5_0)
	RoomMapController.instance:dispatchEvent(RoomEvent.FSMLeaveState, arg_5_0.name)
end

function var_0_0.stop(arg_6_0)
	return
end

function var_0_0.clear(arg_7_0)
	return
end

return var_0_0
