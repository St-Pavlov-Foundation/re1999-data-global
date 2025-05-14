module("modules.logic.versionactivity1_7.common.ActivityLiveMgr1_7", package.seeall)

local var_0_0 = class("ActivityLiveMgr1_7")

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.getActId2ViewList(arg_2_0)
	return {
		[VersionActivity1_7Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity1_7EnterView
		},
		[VersionActivity1_7Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity1_7StoreView
		},
		[VersionActivity1_7Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity1_7TaskView
		},
		[VersionActivity1_7Enum.ActivityId.ReactivityStore] = {
			ViewName.ReactivityStoreView
		},
		[VersionActivity1_7Enum.ActivityId.Reactivity] = {
			ViewName.VersionActivity1_2DungeonView,
			ViewName.ReactivityTaskView,
			ViewName.ReactivityRuleView
		}
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
