module("modules.logic.dungeon.view.DungeonCumulativeRewardsViewContainer", package.seeall)

slot0 = class("DungeonCumulativeRewardsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, DungeonCumulativeRewardsView.New())

	return slot1
end

return slot0
