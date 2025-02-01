module("modules.logic.room.view.layout.RoomLayoutCreateTipsViewContainer", package.seeall)

slot0 = class("RoomLayoutCreateTipsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomLayoutCreateTipsView.New())

	return slot1
end

return slot0
