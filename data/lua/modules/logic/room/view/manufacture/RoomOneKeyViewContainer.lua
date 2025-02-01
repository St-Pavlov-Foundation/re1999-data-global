module("modules.logic.room.view.manufacture.RoomOneKeyViewContainer", package.seeall)

slot0 = class("RoomOneKeyViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomOneKeyView.New())

	return slot1
end

return slot0
