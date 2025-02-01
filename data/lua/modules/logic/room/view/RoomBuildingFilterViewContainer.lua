module("modules.logic.room.view.RoomBuildingFilterViewContainer", package.seeall)

slot0 = class("RoomBuildingFilterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomBuildingFilterView.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
