module("modules.logic.cursor.CursorController", package.seeall)

slot0 = class("CursorController", BaseController)

function slot0.onInit(slot0)
	if BootNativeUtil.isWindows() then
		-- Nothing
	end
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.setUp(slot0)
	slot0._cursor = MonoHelper.addLuaComOnceToGo(gohelper.create2d(ViewMgr.instance:getUILayer(UILayerName.IDCanvasPopUp), "CursorItem"), CursorItem)
end

slot0.instance = slot0.New()

return slot0
