module("modules.logic.room.view.manufacture.RoomManufactureAccelerateViewContainer", package.seeall)

slot0 = class("RoomManufactureAccelerateViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomManufactureAccelerateView.New())

	return slot1
end

return slot0
