module("modules.logic.room.view.critter.RoomTrainAccelerateViewContainer", package.seeall)

slot0 = class("RoomTrainAccelerateViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomTrainAccelerateView.New())

	return slot1
end

return slot0
