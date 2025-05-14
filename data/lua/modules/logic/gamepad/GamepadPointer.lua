module("modules.logic.gamepad.GamepadPointer", package.seeall)

local var_0_0 = class("GamepadPointer", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0:__onInit()

	arg_1_0._go = gohelper.create2d(ViewMgr.instance:getUILayer("Adaption"), "GamepadPointer")
	arg_1_0._resLoader = PrefabInstantiate.Create(arg_1_0._go)

	arg_1_0._resLoader:startLoad("ui/viewres/gamepad/gamepadpointer.prefab", arg_1_0._onResLoaded, arg_1_0)

	arg_1_0._x = 0
	arg_1_0._y = 0
	arg_1_0._trans = arg_1_0._go.transform
	arg_1_0._moveScale = 25

	recthelper.setAnchor(arg_1_0._trans, 0, 0)
	arg_1_0:_onScreenResize()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, arg_1_0._onScreenResize, arg_1_0)
end

function var_0_0.getPos(arg_2_0)
	return arg_2_0._x, arg_2_0._y
end

function var_0_0.getScreenPos(arg_3_0)
	local var_3_0 = CameraMgr.instance:getUICamera()

	if var_3_0 then
		local var_3_1 = var_3_0:WorldToScreenPoint(arg_3_0._trans.position)

		return var_3_1.x, var_3_1.y
	end
end

function var_0_0.setAnchor(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._x = arg_4_1
	arg_4_0._y = arg_4_2

	arg_4_0:_updatePos()
end

function var_0_0.updateX(arg_5_0, arg_5_1)
	arg_5_0._x = arg_5_0._x + arg_5_1 * arg_5_0._moveScale

	arg_5_0:_updatePos()
end

function var_0_0.updateY(arg_6_0, arg_6_1)
	arg_6_0._y = arg_6_0._y + arg_6_1 * arg_6_0._moveScale

	arg_6_0:_updatePos()
end

function var_0_0._onScreenResize(arg_7_0)
	arg_7_0._screenWidth = 1920

	local var_7_0 = UnityEngine.Screen.width / UnityEngine.Screen.height

	if var_7_0 > 1.7777777777777777 then
		arg_7_0._screenWidth = 1080 * var_7_0
	end

	arg_7_0._halfScreenWidth = arg_7_0._screenWidth / 2
	arg_7_0._halfScreenWidthMinus = -arg_7_0._halfScreenWidth
	arg_7_0._realHalfScreenHeight = UnityEngine.Screen.height / 2
	arg_7_0._halfScreenHeight = 540
	arg_7_0._halfScreenHeightMinus = -540

	arg_7_0:_updatePos()
end

function var_0_0._updatePos(arg_8_0)
	arg_8_0._x = math.max(arg_8_0._halfScreenWidthMinus, arg_8_0._x)
	arg_8_0._x = math.min(arg_8_0._halfScreenWidth, arg_8_0._x)
	arg_8_0._y = math.max(arg_8_0._halfScreenHeightMinus, arg_8_0._y)
	arg_8_0._y = math.min(arg_8_0._halfScreenHeight, arg_8_0._y)

	recthelper.setAnchor(arg_8_0._trans, arg_8_0._x, arg_8_0._y)
end

function var_0_0._onResLoaded(arg_9_0)
	return
end

function var_0_0.onDestroy(arg_10_0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, arg_10_0._onScreenResize, arg_10_0)

	if arg_10_0._resLoader then
		arg_10_0._resLoader:dispose()

		arg_10_0._resLoader = nil
	end

	arg_10_0:__onDispose()
end

return var_0_0
