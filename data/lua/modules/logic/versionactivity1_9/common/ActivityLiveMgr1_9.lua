module("modules.logic.versionactivity1_9.common.ActivityLiveMgr1_9", package.seeall)

local var_0_0 = class("ActivityLiveMgr1_9")

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.getActId2ViewList(arg_2_0)
	return {
		[VersionActivity1_9Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity1_9EnterView
		},
		[VersionActivity1_9Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity1_9StoreView
		},
		[VersionActivity1_9Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity1_9TaskView
		},
		[VersionActivity1_9Enum.ActivityId.ToughBattle] = {
			ViewName.ToughBattleActEnterView,
			ViewName.ToughBattleActMapView,
			ViewName.ToughBattleActLoadingView
		}
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
