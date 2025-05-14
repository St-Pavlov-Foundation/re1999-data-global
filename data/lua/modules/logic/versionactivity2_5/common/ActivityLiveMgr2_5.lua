module("modules.logic.versionactivity2_5.common.ActivityLiveMgr2_5", package.seeall)

local var_0_0 = class("ActivityLiveMgr2_5")

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.getActId2ViewList(arg_2_0)
	return {
		[VersionActivity2_5Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity2_5EnterView
		},
		[VersionActivity2_5Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_5StoreView
		},
		[VersionActivity2_5Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity2_5TaskView
		},
		[VersionActivity2_5Enum.ActivityId.Reactivity] = {
			ViewName.VersionActivity1_6DungeonMapView,
			ViewName.VersionActivity1_6DungeonMapLevelView,
			ViewName.ReactivityTaskView
		},
		[VersionActivity2_5Enum.ActivityId.ReactivityStore] = {
			ViewName.ReactivityStoreView
		},
		[VersionActivity2_5Enum.ActivityId.FeiLinShiDuo] = {
			ViewName.FeiLinShiDuoEpisodeLevelView,
			ViewName.FeiLinShiDuoGameView,
			ViewName.FeiLinShiDuoTaskView
		},
		[VersionActivity2_5Enum.ActivityId.LiangYue] = {
			ViewName.LiangYueLevelView,
			ViewName.LiangYueGameView,
			ViewName.LiangYueTaskView
		},
		[ActivityEnum.Activity.Tower] = {
			ViewName.TowerMainEntryView
		},
		[VersionActivity2_5Enum.ActivityId.Act186] = {
			ViewName.Activity186View,
			ViewName.Activity186TaskView
		},
		[VersionActivity2_5Enum.ActivityId.Act186Sign] = {
			ViewName.Activity186SignView
		}
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
