module("modules.logic.dungeon.view.DungeonCumulativeRewardPackViewContainer", package.seeall)

slot0 = class("DungeonCumulativeRewardPackViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, DungeonCumulativeRewardPackView.New())

	return slot1
end

return slot0
