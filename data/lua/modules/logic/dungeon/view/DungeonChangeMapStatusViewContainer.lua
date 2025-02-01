module("modules.logic.dungeon.view.DungeonChangeMapStatusViewContainer", package.seeall)

slot0 = class("DungeonChangeMapStatusViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, DungeonChangeMapStatusView.New())

	return slot1
end

return slot0
