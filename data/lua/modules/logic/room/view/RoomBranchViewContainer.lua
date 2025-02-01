module("modules.logic.room.view.RoomBranchViewContainer", package.seeall)

slot0 = class("RoomBranchViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomBranchView.New())

	return slot1
end

return slot0
