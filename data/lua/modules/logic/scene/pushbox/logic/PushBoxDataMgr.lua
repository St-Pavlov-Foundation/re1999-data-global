module("modules.logic.scene.pushbox.logic.PushBoxDataMgr", package.seeall)

local var_0_0 = class("PushBoxDataMgr", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0._game_mgr = arg_1_1
	arg_1_0._scene = arg_1_1._scene
	arg_1_0._scene_root = arg_1_1._scene_root
end

function var_0_0.init(arg_2_0)
	arg_2_0.warning = 0
end

function var_0_0.setWarning(arg_3_0, arg_3_1)
	arg_3_0.warning = arg_3_1
end

function var_0_0.getCurWarning(arg_4_0)
	return arg_4_0.warning
end

function var_0_0.changeWarning(arg_5_0, arg_5_1)
	arg_5_0.warning = arg_5_0.warning + arg_5_1
end

function var_0_0.gameOver(arg_6_0)
	return arg_6_0.warning >= 100
end

function var_0_0.releaseSelf(arg_7_0)
	arg_7_0:__onDispose()
end

return var_0_0
