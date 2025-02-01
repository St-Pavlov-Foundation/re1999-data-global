module("modules.logic.room.view.debug.RoomDebugBuildingAreaViewContainer", package.seeall)

slot0 = class("RoomDebugBuildingAreaViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomDebugBuildingAreaView.New())

	return slot1
end

return slot0
