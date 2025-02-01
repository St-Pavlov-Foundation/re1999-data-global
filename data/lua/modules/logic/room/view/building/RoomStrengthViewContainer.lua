module("modules.logic.room.view.building.RoomStrengthViewContainer", package.seeall)

slot0 = class("RoomStrengthViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomStrengthView.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
