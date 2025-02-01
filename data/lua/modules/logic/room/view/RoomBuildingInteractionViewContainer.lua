module("modules.logic.room.view.RoomBuildingInteractionViewContainer", package.seeall)

slot0 = class("RoomBuildingInteractionViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomBuildingInteractionView.New())

	return slot1
end

return slot0
