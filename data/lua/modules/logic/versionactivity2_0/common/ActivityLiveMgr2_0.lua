module("modules.logic.versionactivity2_0.common.ActivityLiveMgr2_0", package.seeall)

local var_0_0 = class("ActivityLiveMgr2_0")

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.getActId2ViewList(arg_2_0)
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

var_0_0.instance = var_0_0.New()

return var_0_0
