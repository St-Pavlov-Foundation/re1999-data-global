module("modules.logic.versionactivity2_2.common.ActivityLiveMgr2_2", package.seeall)

local var_0_0 = class("ActivityLiveMgr2_2")

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.getActId2ViewList(arg_2_0)
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

var_0_0.instance = var_0_0.New()

return var_0_0
