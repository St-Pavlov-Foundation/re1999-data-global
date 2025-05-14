module("modules.logic.versionactivity1_5.common.ActivityLiveMgr1_5", package.seeall)

local var_0_0 = class("ActivityLiveMgr1_5")

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.getActId2ViewList(arg_2_0)
	return {
		[VersionActivity1_5Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity1_5EnterView
		},
		[VersionActivity1_5Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity1_5DungeonMapView,
			ViewName.VersionActivity1_5TaskView,
			ViewName.VersionActivity1_5DungeonMapLevelView
		},
		[VersionActivity1_5Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity1_5StoreView,
			ViewName.VersionActivity1_5NormalStoreGoodsView
		},
		[VersionActivity1_5Enum.ActivityId.Activity142] = {
			ViewName.Activity142MapView,
			ViewName.Activity142TaskView,
			ViewName.Activity142CollectView,
			ViewName.Activity142StoryView,
			ViewName.Activity142GameView,
			ViewName.Activity142GetCollectionView,
			ViewName.Activity142ResultView
		},
		[VersionActivity1_5Enum.ActivityId.PeaceUlu] = {
			ViewName.PeaceUluView,
			ViewName.PeaceUluMainView,
			ViewName.PeaceUluGameView,
			ViewName.PeaceUluResultView
		},
		[VersionActivity1_5Enum.ActivityId.AiZiLa] = {
			ViewName.AiZiLaMapView,
			ViewName.AiZiLaGameView,
			ViewName.AiZiLaGameResultView,
			ViewName.AiZiLaGameOpenEffectView,
			ViewName.AiZiLaTaskView
		}
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
