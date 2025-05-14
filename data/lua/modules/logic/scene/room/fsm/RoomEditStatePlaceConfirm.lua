module("modules.logic.scene.room.fsm.RoomEditStatePlaceConfirm", package.seeall)

local var_0_0 = class("RoomEditStatePlaceConfirm", SimpleFSMBaseState)

function var_0_0.start(arg_1_0)
	arg_1_0._scene = GameSceneMgr.instance:getCurScene()
end

function var_0_0.onEnter(arg_2_0)
	var_0_0.super.onEnter(arg_2_0)
end

function var_0_0.onLeave(arg_3_0)
	var_0_0.super.onLeave(arg_3_0)
end

function var_0_0.stop(arg_4_0)
	return
end

function var_0_0.clear(arg_5_0)
	return
end

return var_0_0
