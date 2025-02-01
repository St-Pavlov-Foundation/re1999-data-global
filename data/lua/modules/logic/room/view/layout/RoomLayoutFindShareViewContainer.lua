module("modules.logic.room.view.layout.RoomLayoutFindShareViewContainer", package.seeall)

slot0 = class("RoomLayoutFindShareViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomLayoutFindShareView.New())

	return slot1
end

return slot0
