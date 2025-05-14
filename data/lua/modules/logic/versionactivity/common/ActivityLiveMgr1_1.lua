module("modules.logic.versionactivity.common.ActivityLiveMgr1_1", package.seeall)

local var_0_0 = class("ActivityLiveMgr1_1")

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.getActId2ViewList(arg_2_0)
	return {
		[VersionActivityEnum.ActivityId.Act105] = {
			ViewName.VersionActivityEnterView
		},
		[VersionActivityEnum.ActivityId.Act113] = {
			ViewName.VersionActivityMainView,
			ViewName.VersionActivityNewsView,
			ViewName.VersionActivityPuzzleView,
			ViewName.VersionActivityDungeonMapView,
			ViewName.VersionActivityDungeonMapLevelView,
			ViewName.VersionActivityTaskView
		},
		[VersionActivityEnum.ActivityId.Act107] = {
			ViewName.VersionActivityStoreView
		},
		[VersionActivityEnum.ActivityId.Act104] = {
			ViewName.SeasonMainView
		},
		[VersionActivityEnum.ActivityId.Act108] = {
			ViewName.MeilanniMainView,
			ViewName.MeilanniView
		},
		[VersionActivityEnum.ActivityId.Act109] = {
			ViewName.Activity109ChessEntry,
			ViewName.ActivityChessGame
		},
		[VersionActivityEnum.ActivityId.Act111] = {
			ViewName.VersionActivityPushBoxLevelView,
			ViewName.VersionActivityPushBoxGameView
		},
		[VersionActivityEnum.ActivityId.Act112] = {
			ViewName.VersionActivityExchangeView
		},
		[VersionActivityEnum.ActivityId.Act106] = {
			ViewName.ActivityWarmUpGameView,
			ViewName.ActivityWarmUpView
		}
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
