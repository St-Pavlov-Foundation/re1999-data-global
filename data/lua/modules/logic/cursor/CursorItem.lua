module("modules.logic.cursor.CursorItem", package.seeall)

slot0 = class("CursorItem", LuaCompBase)
slot0.Cursor = UnityEngine.Cursor
slot0.Cursor = UnityEngine.Cursor

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0._adaptionLayerGo = ViewMgr.instance:getUILayer(UILayerName.IDCanvasPopUp)
	slot0._adaptionLayerTrans = slot0._adaptionLayerGo.transform
	slot0._go = slot1
	slot0._visible = false
	uv0.Cursor.visible = true
	slot0._resLoader = PrefabInstantiate.Create(slot1)

	slot0._resLoader:startLoad("ui/viewres/gamepad/gamepadpointer.prefab", slot0._onResLoaded, slot0)

	slot0._trans = slot1.transform

	slot0:onUpdate()
end

function slot0._onResLoaded(slot0)
	ZenFulcrum.EmbeddedBrowser.CursorRendererOS.cursorNormallyVisible = false
	uv0.Cursor.visible = false
	slot0._curorGo = slot0._resLoader:getInstGO()

	gohelper.setActive(slot0._curorGo, slot0._visible)
end

function slot0.onUpdate(slot0)
	if uv0.Cursor.visible == slot0._visible then
		slot0._visible = uv0.Cursor.visible == false

		gohelper.setActive(slot0._curorGo, slot0._visible)
	end

	if slot0._visible and CameraMgr.instance:getMainCamera() then
		recthelper.setAnchor(slot0._trans, recthelper.getWidth(slot0._adaptionLayerTrans) * (UnityEngine.Input.mousePosition.x / UnityEngine.Screen.width - 0.5), recthelper.getHeight(slot0._adaptionLayerTrans) * (UnityEngine.Input.mousePosition.y / UnityEngine.Screen.height - 0.5))
	end
end

return slot0
