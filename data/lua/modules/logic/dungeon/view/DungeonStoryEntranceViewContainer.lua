module("modules.logic.dungeon.view.DungeonStoryEntranceViewContainer", package.seeall)

slot0 = class("DungeonStoryEntranceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, DungeonStoryEntranceView.New())

	return slot1
end

return slot0
