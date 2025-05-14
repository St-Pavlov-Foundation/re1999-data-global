module("modules.logic.rouge.map.map.itemcomp.RougeMapBaseItem", package.seeall)

local var_0_0 = class("RougeMapBaseItem", UserDataDispose)

function var_0_0.init(arg_1_0)
	arg_1_0:__onInit()

	arg_1_0.id = nil
	arg_1_0.scenePos = nil
end

function var_0_0.setId(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1
end

function var_0_0.getScenePos(arg_3_0)
	return arg_3_0.scenePos
end

function var_0_0.getMapPos(arg_4_0)
	return 0, 0, 0
end

function var_0_0.getActorPos(arg_5_0)
	return 0, 0, 0
end

function var_0_0.getUiPos(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getScenePos()

	return recthelper.worldPosToAnchorPos2(var_6_0, arg_6_1)
end

function var_0_0.getClickArea(arg_7_0)
	return Vector4(100, 100, 0, 0)
end

function var_0_0.checkInClickArea(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_0:isActive() then
		return
	end

	local var_8_0, var_8_1 = arg_8_0:getUiPos(arg_8_3)
	local var_8_2 = arg_8_0:getClickArea()
	local var_8_3 = var_8_2.x / 2
	local var_8_4 = var_8_2.y / 2
	local var_8_5 = var_8_0 + var_8_2.z
	local var_8_6 = var_8_1 + var_8_2.w

	if arg_8_1 >= var_8_5 - var_8_3 and arg_8_1 <= var_8_5 + var_8_3 and arg_8_2 >= var_8_6 - var_8_4 and arg_8_2 <= var_8_6 + var_8_4 then
		return true
	end
end

function var_0_0.onClick(arg_9_0)
	return
end

function var_0_0.isActive(arg_10_0)
	return true
end

function var_0_0.destroy(arg_11_0)
	arg_11_0:__onDispose()
end

return var_0_0
