module("modules.logic.versionactivity2_4.common.ActivityLiveMgr2_4", package.seeall)

slot0 = class("ActivityLiveMgr2_4")

function slot0.init(slot0)
end

function slot0.getActId2ViewList(slot0)
	return {
		[VersionActivity2_4Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity2_4EnterView
		},
		[VersionActivity2_4Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_4StoreView
		},
		[VersionActivity2_4Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity2_4TaskView
		},
		[VersionActivity2_4Enum.ActivityId.Pinball] = {
			ViewName.PinballCityView,
			ViewName.PinballGameView,
			ViewName.PinballTaskView
		},
		[VersionActivity2_4Enum.ActivityId.MusicGame] = {
			ViewName.VersionActivity2_4MusicChapterView,
			ViewName.VersionActivity2_4MusicTaskView,
			ViewName.VersionActivity2_4MusicBeatView,
			ViewName.VersionActivity2_4MusicFreeView
		},
		[VersionActivity2_4Enum.ActivityId.Season] = {
			ViewName.Season166MainView,
			ViewName.Season166TeachView,
			ViewName.Season166HeroGroupFightView
		},
		[VersionActivity2_4Enum.ActivityId.Reactivity] = {
			ViewName.VersionActivity1_8DungeonMapView,
			ViewName.VersionActivity1_8DungeonMapLevelView,
			ViewName.ReactivityTaskView
		},
		[VersionActivity2_4Enum.ActivityId.ReactivityStore] = {
			ViewName.ReactivityStoreView
		},
		[VersionActivity2_4Enum.ActivityId.ReactivityFactory] = {
			ViewName.VersionActivity1_8FactoryMapView,
			ViewName.VersionActivity1_8FactoryBlueprintView,
			ViewName.VersionActivity1_8FactoryRepairView,
			ViewName.VersionActivity1_8FactoryCompositeView
		}
	}
end

slot0.instance = slot0.New()

return slot0
