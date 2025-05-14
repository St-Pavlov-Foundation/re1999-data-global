module("modules.logic.room.mgr.RoomEditorMgr", package.seeall)

local var_0_0 = class("RoomEditorMgr")

function var_0_0.start(arg_1_0)
	RoomController.instance:setEditorMode(true)
	ViewMgr.instance:openView(ViewName.RoomDebugEntranceView)
end

function var_0_0.exit(arg_2_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
