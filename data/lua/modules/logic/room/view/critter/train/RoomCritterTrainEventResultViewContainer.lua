module("modules.logic.room.view.critter.train.RoomCritterTrainEventResultViewContainer", package.seeall)

slot0 = class("RoomCritterTrainEventResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomCritterTrainEventResultView.New())

	return slot1
end

return slot0
