module("modules.logic.room.view.critter.summon.RoomCritterSummonResultViewContainer", package.seeall)

slot0 = class("RoomCritterSummonResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomCritterSummonResultView.New())

	return slot1
end

return slot0
