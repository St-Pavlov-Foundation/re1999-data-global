module("modules.logic.versionactivity1_3.common.ActivityLiveMgr1_3", package.seeall)

local var_0_0 = class("ActivityLiveMgr1_3")

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.getActId2ViewList(arg_2_0)
	return {
		[VersionActivity1_3Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity1_3EnterView
		},
		[VersionActivity1_3Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity1_3DungeonMapView
		},
		[VersionActivity1_3Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity1_3StoreView
		},
		[VersionActivity1_3Enum.ActivityId.Act310] = {
			ViewName.VersionActivity1_3AstrologyView,
			VersionActivity1_3BuffView
		},
		[VersionActivity1_3Enum.ActivityId.Act306] = {
			ViewName.JiaLaBoNaStoryView,
			ViewName.JiaLaBoNaTaskView,
			ViewName.JiaLaBoNaGameResultView,
			ViewName.JiaLaBoNaGameView,
			ViewName.JiaLaBoNaMapView
		},
		[VersionActivity1_3Enum.ActivityId.Act305] = {
			ViewName.ArmPuzzlePipeView,
			ViewName.ArmRewardView,
			ViewName.ArmMainView
		},
		[VersionActivity1_3Enum.ActivityId.Act304] = {
			ViewName.Activity1_3ChessStoryView,
			ViewName.Activity1_3ChessTaskView,
			ViewName.Activity1_3ChessResultView,
			ViewName.Activity1_3ChessGameView,
			ViewName.Activity1_3ChessMapView
		},
		[VersionActivity1_3Enum.ActivityId.Act307] = {
			ViewName.Activity1_3_119View
		},
		[VersionActivity1_3Enum.ActivityId.Season] = SeasonViewHelper.getAllSeasonViewList(Activity104Model.instance:getCurSeasonId()),
		[VersionActivity1_3Enum.ActivityId.SeasonStore] = {
			SeasonViewHelper.getViewName(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.StoreView)
		}
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
