module("modules.logic.room.view.RoomGuideViewContainer", package.seeall)

slot0 = class("RoomGuideViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomGuideView.New())

	return slot1
end

return slot0
