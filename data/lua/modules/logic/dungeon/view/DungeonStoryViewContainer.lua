module("modules.logic.dungeon.view.DungeonStoryViewContainer", package.seeall)

slot0 = class("DungeonStoryViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, DungeonStoryView.New())

	return slot1
end

return slot0
