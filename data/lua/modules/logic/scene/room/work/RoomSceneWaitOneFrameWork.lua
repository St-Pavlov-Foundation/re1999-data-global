module("modules.logic.scene.room.work.RoomSceneWaitOneFrameWork", package.seeall)

local var_0_0 = class("RoomSceneWaitOneFrameWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._scene = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._oneFrame, arg_2_0, 0)
end

function var_0_0._oneFrame(arg_3_0)
	arg_3_0._scene = nil

	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	arg_4_0._scene = nil
end

return var_0_0
