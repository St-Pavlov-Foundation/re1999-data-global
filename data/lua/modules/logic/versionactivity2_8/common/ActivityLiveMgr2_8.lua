module("modules.logic.versionactivity2_8.common.ActivityLiveMgr2_8", package.seeall)

local var_0_0 = class("ActivityLiveMgr2_8")

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.getActId2ViewList(arg_2_0)
	return {
		[VersionActivity2_8Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity2_8EnterView
		},
		[VersionActivity2_8Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_8StoreView
		},
		[VersionActivity2_8Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity2_8TaskView,
			ViewName.DungeonMapView
		},
		[VersionActivity2_8Enum.ActivityId.DungeonBoss] = {
			ViewName.VersionActivity2_8BossActEnterView
		},
		[VersionActivity2_8Enum.ActivityId.Survival] = {
			ViewName.SurvivalMainView,
			ViewName.SurvivalMapView
		},
		[VersionActivity2_8Enum.ActivityId.Season] = {
			ViewName.Season166MainView,
			ViewName.Season166TeachView,
			ViewName.Season166HeroGroupFightView
		}
	}
end

function var_0_0.getActIdCheckCloseList(arg_3_0)
	return {
		[VersionActivity2_8Enum.ActivityId.Dungeon] = DungeonController.closePreviewChapterDungeonMapViewActEnd
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
