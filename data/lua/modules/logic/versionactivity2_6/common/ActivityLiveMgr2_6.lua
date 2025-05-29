module("modules.logic.versionactivity2_6.common.ActivityLiveMgr2_6", package.seeall)

local var_0_0 = class("ActivityLiveMgr2_6")

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.getActId2ViewList(arg_2_0)
	return {
		[VersionActivity2_6Enum.ActivityId.ReactivityFactory] = {
			ViewName.VersionActivity1_8FactoryMapView,
			ViewName.VersionActivity1_8FactoryBlueprintView,
			ViewName.VersionActivity1_8FactoryRepairView,
			ViewName.VersionActivity1_8FactoryCompositeView
		},
		[VersionActivity2_6Enum.ActivityId.ReactivityStore] = {
			ViewName.ReactivityStoreView
		},
		[VersionActivity2_6Enum.ActivityId.Reactivity] = {
			ViewName.VersionActivity1_8DungeonMapView,
			ViewName.VersionActivity1_8DungeonMapLevelView,
			ViewName.ReactivityTaskView
		},
		[VersionActivity2_6Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity2_6EnterView
		},
		[VersionActivity2_6Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_6StoreView
		},
		[VersionActivity2_6Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity2_6TaskView
		},
		[VersionActivity2_6Enum.ActivityId.Season] = {
			ViewName.Season166MainView,
			ViewName.Season166TeachView,
			ViewName.Season166HeroGroupFightView
		}
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
