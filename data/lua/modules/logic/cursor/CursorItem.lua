-- chunkname: @modules/logic/cursor/CursorItem.lua

module("modules.logic.cursor.CursorItem", package.seeall)

local CursorItem = class("CursorItem", LuaCompBase)

CursorItem.Cursor = UnityEngine.Cursor
CursorItem.Cursor = UnityEngine.Cursor

function CursorItem:init(go)
	self:__onInit()

	self._adaptionLayerGo = ViewMgr.instance:getUILayer(UILayerName.IDCanvasPopUp)
	self._adaptionLayerTrans = self._adaptionLayerGo.transform
	self._go = go
	self._visible = false
	CursorItem.Cursor.visible = true
	self._resLoader = PrefabInstantiate.Create(go)

	self._resLoader:startLoad("ui/viewres/gamepad/gamepadpointer.prefab", self._onResLoaded, self)

	self._trans = go.transform

	self:onUpdate()
end

function CursorItem:_onResLoaded()
	ZenFulcrum.EmbeddedBrowser.CursorRendererOS.cursorNormallyVisible = false
	CursorItem.Cursor.visible = false
	self._curorGo = self._resLoader:getInstGO()

	gohelper.setActive(self._curorGo, self._visible)
end

function CursorItem:onUpdate()
	if CursorItem.Cursor.visible == self._visible then
		self._visible = CursorItem.Cursor.visible == false

		gohelper.setActive(self._curorGo, self._visible)
	end

	if self._visible and CameraMgr.instance:getMainCamera() then
		local width = recthelper.getWidth(self._adaptionLayerTrans)
		local height = recthelper.getHeight(self._adaptionLayerTrans)
		local screenWidth = UnityEngine.Screen.width
		local screenHeight = UnityEngine.Screen.height
		local perX = UnityEngine.Input.mousePosition.x / screenWidth - 0.5
		local perY = UnityEngine.Input.mousePosition.y / screenHeight - 0.5

		recthelper.setAnchor(self._trans, width * perX, height * perY)
	end
end

return CursorItem
