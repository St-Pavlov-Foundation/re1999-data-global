module("modules.logic.room.view.critter.summon.RoomCritterSummonRuleTipsViewContainer", package.seeall)

slot0 = class("RoomCritterSummonRuleTipsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomCritterSummonRuleTipsView.New())

	return slot1
end

return slot0
