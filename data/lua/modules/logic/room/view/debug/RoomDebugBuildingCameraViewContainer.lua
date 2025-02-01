module("modules.logic.room.view.debug.RoomDebugBuildingCameraViewContainer", package.seeall)

slot0 = class("RoomDebugBuildingCameraViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomDebugBuildingCameraView.New())

	return slot1
end

return slot0
