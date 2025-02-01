module("modules.logic.dungeon.view.DungeonElementRewardViewContainer", package.seeall)

slot0 = class("DungeonElementRewardViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, DungeonElementRewardView.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
