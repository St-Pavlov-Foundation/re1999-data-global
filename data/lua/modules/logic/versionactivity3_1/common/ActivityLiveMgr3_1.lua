module("modules.logic.versionactivity3_1.common.ActivityLiveMgr3_1", package.seeall)

local var_0_0 = class("ActivityLiveMgr3_1")

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.getActId2ViewList(arg_2_0)
	return {
		[VersionActivity3_1Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity3_1EnterView
		},
		[VersionActivity3_1Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity3_1StoreView
		},
		[VersionActivity3_1Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity3_1TaskView
		},
		[VersionActivity3_1Enum.ActivityId.Survival] = {
			ViewName.SurvivalMainView,
			ViewName.SurvivalMapView
		},
		[VersionActivity3_1Enum.ActivityId.Reactivity] = {
			ViewName.VersionActivity2_4DungeonMapView,
			ViewName.VersionActivity2_4DungeonMapLevelView,
			ViewName.ReactivityTaskView
		},
		[ActivityEnum.Activity.Tower] = {
			ViewName.TowerMainEntryView
		}
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
