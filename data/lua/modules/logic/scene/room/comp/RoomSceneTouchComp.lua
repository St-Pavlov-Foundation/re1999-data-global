module("modules.logic.scene.room.comp.RoomSceneTouchComp", package.seeall)

local var_0_0 = class("RoomSceneTouchComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()

	local var_2_0 = arg_2_0._scene.go.sceneGO

	arg_2_0._touchComp = MonoHelper.addLuaComOnceToGo(var_2_0, RoomTouchComp, var_2_0)
end

function var_0_0.setUIDragScreenScroll(arg_3_0, arg_3_1)
	if arg_3_0._touchComp then
		arg_3_0._touchComp:setUIDragScreenScroll(arg_3_1)
	end
end

function var_0_0.onSceneClose(arg_4_0)
	arg_4_0._touchComp = nil
end

return var_0_0
