module("modules.logic.cursor.CursorItem", package.seeall)

local var_0_0 = class("CursorItem", LuaCompBase)

var_0_0.Cursor = UnityEngine.Cursor
var_0_0.Cursor = UnityEngine.Cursor

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0._adaptionLayerGo = ViewMgr.instance:getUILayer(UILayerName.IDCanvasPopUp)
	arg_1_0._adaptionLayerTrans = arg_1_0._adaptionLayerGo.transform
	arg_1_0._go = arg_1_1
	arg_1_0._visible = false
	var_0_0.Cursor.visible = true
	arg_1_0._resLoader = PrefabInstantiate.Create(arg_1_1)

	arg_1_0._resLoader:startLoad("ui/viewres/gamepad/gamepadpointer.prefab", arg_1_0._onResLoaded, arg_1_0)

	arg_1_0._trans = arg_1_1.transform

	arg_1_0:onUpdate()
end

function var_0_0._onResLoaded(arg_2_0)
	ZenFulcrum.EmbeddedBrowser.CursorRendererOS.cursorNormallyVisible = false
	var_0_0.Cursor.visible = false
	arg_2_0._curorGo = arg_2_0._resLoader:getInstGO()

	gohelper.setActive(arg_2_0._curorGo, arg_2_0._visible)
end

function var_0_0.onUpdate(arg_3_0)
	if var_0_0.Cursor.visible == arg_3_0._visible then
		arg_3_0._visible = var_0_0.Cursor.visible == false

		gohelper.setActive(arg_3_0._curorGo, arg_3_0._visible)
	end

	if arg_3_0._visible and CameraMgr.instance:getMainCamera() then
		local var_3_0 = recthelper.getWidth(arg_3_0._adaptionLayerTrans)
		local var_3_1 = recthelper.getHeight(arg_3_0._adaptionLayerTrans)
		local var_3_2 = UnityEngine.Screen.width
		local var_3_3 = UnityEngine.Screen.height
		local var_3_4 = UnityEngine.Input.mousePosition.x / var_3_2 - 0.5
		local var_3_5 = UnityEngine.Input.mousePosition.y / var_3_3 - 0.5

		recthelper.setAnchor(arg_3_0._trans, var_3_0 * var_3_4, var_3_1 * var_3_5)
	end
end

return var_0_0
