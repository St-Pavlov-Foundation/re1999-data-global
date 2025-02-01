module("modules.logic.room.view.manufacture.RoomManufactureBuildingLevelUpTipsViewContainer", package.seeall)

slot0 = class("RoomManufactureBuildingLevelUpTipsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomManufactureBuildingLevelUpTipsView.New())

	return slot1
end

return slot0
