module("modules.logic.dungeon.view.DungeonMapTaskViewContainer", package.seeall)

slot0 = class("DungeonMapTaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, DungeonMapTaskView.New())

	return slot1
end

return slot0
