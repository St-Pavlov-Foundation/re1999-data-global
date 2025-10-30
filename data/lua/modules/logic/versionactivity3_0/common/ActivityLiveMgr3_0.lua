module("modules.logic.versionactivity3_0.common.ActivityLiveMgr3_0", package.seeall)

local var_0_0 = class("ActivityLiveMgr3_0")

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.getActId2ViewList(arg_2_0)
	return {
		[VersionActivity3_0Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity3_0EnterView
		},
		[VersionActivity3_0Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_8StoreView
		},
		[VersionActivity3_0Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity2_8TaskView
		},
		[VersionActivity3_0Enum.ActivityId.Season] = {
			ViewName.Season166MainView,
			ViewName.Season166TeachView,
			ViewName.Season166HeroGroupFightView
		},
		[VersionActivity3_0Enum.ActivityId.ReactivityStore] = {
			ViewName.ReactivityStoreView
		}
	}
end

function var_0_0.getActIdCheckCloseList(arg_3_0)
	return {
		[VersionActivity3_0Enum.ActivityId.Dungeon] = DungeonController.closePreviewChapterDungeonMapViewActEnd
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
