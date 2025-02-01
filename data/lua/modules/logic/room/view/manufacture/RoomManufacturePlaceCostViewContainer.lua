module("modules.logic.room.view.manufacture.RoomManufacturePlaceCostViewContainer", package.seeall)

slot0 = class("RoomManufacturePlaceCostViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomManufacturePlaceCostView.New())

	return slot1
end

return slot0
