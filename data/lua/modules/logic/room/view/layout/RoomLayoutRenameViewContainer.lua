module("modules.logic.room.view.layout.RoomLayoutRenameViewContainer", package.seeall)

slot0 = class("RoomLayoutRenameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomLayoutRenameView.New())

	return slot1
end

return slot0
