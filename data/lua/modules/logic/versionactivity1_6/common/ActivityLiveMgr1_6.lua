module("modules.logic.versionactivity1_6.common.ActivityLiveMgr1_6", package.seeall)

local var_0_0 = class("ActivityLiveMgr1_6")

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.getActId2ViewList(arg_2_0)
	return {
		[VersionActivity1_6Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity1_6EnterView
		},
		[VersionActivity1_6Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity1_6DungeonMapView,
			ViewName.VersionActivity1_6TaskView,
			ViewName.VersionActivity1_6DungeonMapLevelView,
			ViewName.VersionActivity1_6SkillView,
			ViewName.VersionActivity1_6DungeonBossView
		},
		[VersionActivity1_6Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity1_6StoreView,
			ViewName.VersionActivity1_6NormalStoreGoodsView
		},
		[VersionActivity1_6Enum.ActivityId.Reactivity] = {
			ViewName.VersionActivityMainView,
			ViewName.VersionActivityNewsView,
			ViewName.VersionActivityPuzzleView,
			ViewName.VersionActivityDungeonMapView,
			ViewName.VersionActivityDungeonMapLevelView,
			ViewName.ReactivityTaskView,
			ViewName.ReactivityRuleView
		},
		[VersionActivity1_6Enum.ActivityId.ReactivityStore] = {
			ViewName.ReactivityStoreView
		},
		[VersionActivity1_6Enum.ActivityId.Cachot] = {
			ViewName.V1a6_CachotMainView,
			ViewName.V1a6_CachotRoomView,
			ViewName.V1a6_CachotRewardView,
			ViewName.V1a6_CachotEndingView,
			ViewName.V1a6_CachotFinishView,
			ViewName.V1a6_CachotStoreView,
			ViewName.V1a6_CachotRewardView,
			ViewName.V1a6_CachotEpisodeView,
			ViewName.V1a6_CachotInteractView,
			ViewName.V1a6_CachotCollectionSelectView,
			ViewName.V1a6_CachotUpgradeView,
			ViewName.V1a6_CachotRoleRecoverView,
			ViewName.V1a6_CachotRoleRevivalView,
			ViewName.V1a6_CachotTipsView
		},
		[VersionActivity1_6Enum.ActivityId.Season] = SeasonViewHelper.getAllSeasonViewList(Activity104Model.instance:getCurSeasonId()),
		[VersionActivity1_6Enum.ActivityId.SeasonStore] = {
			SeasonViewHelper.getViewName(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.StoreView)
		}
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
