module("modules.logic.versionactivity2_0.dungeon.view.map.VersionActivity2_0DungeonMapGraffitiEnterViewContainer", package.seeall)

slot0 = class("VersionActivity2_0DungeonMapGraffitiEnterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, VersionActivity2_0DungeonMapGraffitiEnterView.New())

	return slot1
end

return slot0
