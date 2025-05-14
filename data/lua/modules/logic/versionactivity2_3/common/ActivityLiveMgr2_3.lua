module("modules.logic.versionactivity2_3.common.ActivityLiveMgr2_3", package.seeall)

local var_0_0 = class("ActivityLiveMgr2_3")

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.getActId2ViewList(arg_2_0)
	return {
		[VersionActivity2_3Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity2_3EnterView
		},
		[VersionActivity2_3Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_3StoreView
		},
		[VersionActivity2_3Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity2_3TaskView
		},
		[VersionActivity2_3Enum.ActivityId.DuDuGu] = {
			ViewName.DuDuGuLevelView
		},
		[ActivityEnum.Activity.Tower] = {
			ViewName.TowerMainEntryView
		}
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
