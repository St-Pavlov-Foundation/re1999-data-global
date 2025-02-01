module("modules.logic.critter.view.RoomCritterFilterViewContainer", package.seeall)

slot0 = class("RoomCritterFilterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomCritterFilterView.New())

	return slot1
end

return slot0
