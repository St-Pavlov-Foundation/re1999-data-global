module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapTaskViewContainer", package.seeall)

slot0 = class("VersionActivity1_5DungeonMapTaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, VersionActivity1_5DungeonMapTaskView.New())

	return slot1
end

return slot0
