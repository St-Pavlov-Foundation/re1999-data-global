module("modules.logic.room.view.manufacture.RoomManufactureGetViewContainer", package.seeall)

slot0 = class("RoomManufactureGetViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomManufactureGetView.New())

	return slot1
end

return slot0
