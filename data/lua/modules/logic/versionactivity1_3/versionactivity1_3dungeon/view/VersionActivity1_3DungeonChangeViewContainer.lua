module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonChangeViewContainer", package.seeall)

slot0 = class("VersionActivity1_3DungeonChangeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, VersionActivity1_3DungeonChangeView.New())

	return slot1
end

return slot0
