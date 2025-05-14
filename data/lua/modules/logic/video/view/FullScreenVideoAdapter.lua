module("modules.logic.video.view.FullScreenVideoAdapter", package.seeall)

local var_0_0 = class("FullScreenVideoAdapter", LuaCompBase)
local var_0_1 = 2.4

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.tr = arg_2_1.transform

	local var_2_0 = arg_2_1:GetComponent(typeof(ZProj.UIBgSelfAdapter))

	if var_2_0 then
		var_2_0.enabled = false

		local var_2_1
	end

	arg_2_0:_onScreenResize(UnityEngine.Screen.width, UnityEngine.Screen.height)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_3_0._onScreenResize, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_4_0._onScreenResize, arg_4_0)
end

function var_0_0._onScreenResize(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1 / arg_5_2

	if var_5_0 > var_0_1 then
		local var_5_1 = var_5_0 / var_0_1

		transformhelper.setLocalScale(arg_5_0.tr, var_5_1, var_5_1, var_5_1)
	else
		transformhelper.setLocalScale(arg_5_0.tr, 1, 1, 1)
	end
end

return var_0_0
