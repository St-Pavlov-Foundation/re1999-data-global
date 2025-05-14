module("modules.logic.scene.room.compwork.RoomSceneWaitEventCompWork", package.seeall)

local var_0_0 = class("RoomSceneWaitEventCompWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._comp = arg_1_1
	arg_1_0._event = arg_1_2
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.sceneId
	local var_2_1 = arg_2_1.levelId

	if not arg_2_0._comp then
		logError("RoomSceneWaitEventCompWork: 没有comp")
		arg_2_0:onDone(true)

		return
	end

	if arg_2_0._comp.init then
		arg_2_0._comp:registerCallback(arg_2_0._event, arg_2_0._onEvent, arg_2_0)
		arg_2_0._comp:init(var_2_0, var_2_1)
	else
		logError(string.format("%s: 没有init", arg_2_0._comp.__cname))
		arg_2_0:onDone(true)
	end
end

function var_0_0._onEvent(arg_3_0)
	if not arg_3_0._comp then
		logError("RoomSceneWaitEventCompWork: 没有comp")

		return
	end

	arg_3_0._comp:unregisterCallback(arg_3_0._event, arg_3_0._onEvent, arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.onDestroy(arg_4_0)
	var_0_0.super.onDestroy(arg_4_0)

	if not arg_4_0._comp then
		logError("RoomSceneWaitEventCompWork: 没有comp")

		return
	end

	arg_4_0._comp:unregisterCallback(arg_4_0._event, arg_4_0._onEvent, arg_4_0)
end

return var_0_0
