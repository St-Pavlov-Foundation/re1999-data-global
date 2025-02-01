module("modules.logic.room.view.layout.RoomLayoutCopyViewContainer", package.seeall)

slot0 = class("RoomLayoutCopyViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomLayoutCopyView.New())

	return slot1
end

return slot0
