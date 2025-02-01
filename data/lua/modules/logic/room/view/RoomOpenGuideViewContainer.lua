module("modules.logic.room.view.RoomOpenGuideViewContainer", package.seeall)

slot0 = class("RoomOpenGuideViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomOpenGuideView.New())

	return slot1
end

return slot0
