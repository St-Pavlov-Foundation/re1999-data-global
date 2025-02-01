module("modules.logic.versionactivity2_2.common.ActivityLiveMgr2_2", package.seeall)

slot0 = class("ActivityLiveMgr2_2")

function slot0.init(slot0)
end

function slot0.getActId2ViewList(slot0)
	return {
		[VersionActivity2_2Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity2_2EnterView
		},
		[VersionActivity2_2Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_2StoreView
		},
		[VersionActivity2_2Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity2_2TaskView
		},
		[VersionActivity2_2Enum.ActivityId.TianShiNaNa] = {
			ViewName.TianShiNaNaMainView,
			ViewName.TianShiNaNaLevelView
		},
		[VersionActivity2_2Enum.ActivityId.Lopera] = {
			ViewName.LoperaMainView,
			ViewName.LoperaLevelView
		},
		[VersionActivity2_2Enum.ActivityId.Season] = {
			ViewName.Season166MainView,
			ViewName.Season166TeachView,
			ViewName.Season166HeroGroupFightView
		}
	}
end

slot0.instance = slot0.New()

return slot0
