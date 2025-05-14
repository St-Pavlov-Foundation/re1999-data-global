module("modules.logic.scene.room.compwork.RoomSceneCommonCompWork", package.seeall)

local var_0_0 = class("RoomSceneCommonCompWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._comp = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.sceneId
	local var_2_1 = arg_2_1.levelId

	if not arg_2_0._comp then
		logError("RoomSceneCommonCompWork: 没有comp")
		arg_2_0:onDone(true)

		return
	end

	if arg_2_0._comp.init then
		arg_2_0._comp:init(var_2_0, var_2_1)
		arg_2_0:onDone(true)
	else
		logError(string.format("%s: 没有init", arg_2_0._comp.__cname))
		arg_2_0:onDone(true)
	end
end

return var_0_0
