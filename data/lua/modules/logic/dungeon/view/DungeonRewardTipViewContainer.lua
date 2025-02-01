module("modules.logic.dungeon.view.DungeonRewardTipViewContainer", package.seeall)

slot0 = class("DungeonRewardTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, DungeonRewardTipView.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
