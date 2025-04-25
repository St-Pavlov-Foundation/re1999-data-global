module("modules.logic.room.view.critter.RoomCritterRenameViewContainer", package.seeall)

slot0 = class("RoomCritterRenameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomCritterRenameView.New())

	return slot1
end

return slot0
