module("modules.logic.scene.room.fsm.action.RoomBaseFsmAction", package.seeall)

local var_0_0 = class("RoomBaseFsmAction")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.fsmTransition = arg_1_1
end

function var_0_0.start(arg_2_0, arg_2_1)
	arg_2_0._scene = GameSceneMgr.instance:getCurScene()

	arg_2_0:onStart(arg_2_1)
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	return
end

function var_0_0.stop(arg_4_0)
	return
end

function var_0_0.clear(arg_5_0)
	return
end

return var_0_0
