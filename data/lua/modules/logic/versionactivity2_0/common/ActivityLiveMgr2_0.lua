module("modules.logic.versionactivity2_0.common.ActivityLiveMgr2_0", package.seeall)

slot0 = class("ActivityLiveMgr2_0")

function slot0.init(slot0)
end

function slot0.getActId2ViewList(slot0)
	return {
		[VersionActivity2_0Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity2_0EnterView
		},
		[VersionActivity2_0Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_0StoreView
		},
		[VersionActivity2_0Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity2_0TaskView,
			ViewName.VersionActivity2_0DungeonMapView,
			ViewName.VersionActivity2_0DungeonMapLevelView,
			ViewName.VersionActivity2_0DungeonMapGraffitiEnterView
		},
		[VersionActivity2_0Enum.ActivityId.DungeonGraffiti] = {
			ViewName.VersionActivity2_0DungeonGraffitiDrawView,
			ViewName.VersionActivity2_0DungeonGraffitiView
		}
	}
end

slot0.instance = slot0.New()

return slot0
