module("modules.logic.room.mgr.RoomEditorMgr", package.seeall)

slot0 = class("RoomEditorMgr")

function slot0.start(slot0)
	RoomController.instance:setEditorMode(true)
	ViewMgr.instance:openView(ViewName.RoomDebugEntranceView)
end

function slot0.exit(slot0)
end

slot0.instance = slot0.New()

return slot0
