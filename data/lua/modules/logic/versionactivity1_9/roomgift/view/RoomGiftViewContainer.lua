module("modules.logic.versionactivity1_9.roomgift.view.RoomGiftViewContainer", package.seeall)

slot0 = class("RoomGiftViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomGiftView.New())

	return slot1
end

return slot0
