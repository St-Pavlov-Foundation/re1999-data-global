module("modules.logic.versionactivity2_7.common.ActivityLiveMgr2_7", package.seeall)

local var_0_0 = class("ActivityLiveMgr2_7")

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.getActId2ViewList(arg_2_0)
	return {
		[VersionActivity2_7Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity2_7EnterView
		},
		[VersionActivity2_7Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_7StoreView
		},
		[VersionActivity2_7Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity2_7TaskView
		},
		[VersionActivity2_7Enum.ActivityId.CooperGarland] = {
			ViewName.CooperGarlandGameView,
			ViewName.CooperGarlandLevelView,
			ViewName.CooperGarlandTaskView
		},
		[VersionActivity2_7Enum.ActivityId.Reactivity] = {
			ViewName.VersionActivity2_0DungeonMapView,
			ViewName.VersionActivity2_0DungeonMapLevelView,
			ViewName.ReactivityTaskView
		},
		[VersionActivity2_7Enum.ActivityId.DungeonGraffiti] = {
			ViewName.VersionActivity2_0DungeonGraffitiDrawView,
			ViewName.VersionActivity2_0DungeonGraffitiView
		},
		[VersionActivity2_7Enum.ActivityId.ReactivityStore] = {
			ViewName.ReactivityStoreView
		},
		[ActivityEnum.Activity.Tower] = {
			ViewName.TowerMainEntryView
		}
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
