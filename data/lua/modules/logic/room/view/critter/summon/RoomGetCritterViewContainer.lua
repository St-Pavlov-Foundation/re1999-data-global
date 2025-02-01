module("modules.logic.room.view.critter.summon.RoomGetCritterViewContainer", package.seeall)

slot0 = class("RoomGetCritterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomGetCritterView.New())

	return slot1
end

return slot0
