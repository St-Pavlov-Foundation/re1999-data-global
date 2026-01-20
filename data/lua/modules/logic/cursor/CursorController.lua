-- chunkname: @modules/logic/cursor/CursorController.lua

module("modules.logic.cursor.CursorController", package.seeall)

local CursorController = class("CursorController", BaseController)

function CursorController:onInit()
	if BootNativeUtil.isWindows() then
		-- block empty
	end
end

function CursorController:onInitFinish()
	return
end

function CursorController:addConstEvents()
	return
end

function CursorController:reInit()
	return
end

function CursorController:setUp()
	local go = gohelper.create2d(ViewMgr.instance:getUILayer(UILayerName.IDCanvasPopUp), "CursorItem")

	self._cursor = MonoHelper.addLuaComOnceToGo(go, CursorItem)
end

CursorController.instance = CursorController.New()

return CursorController
