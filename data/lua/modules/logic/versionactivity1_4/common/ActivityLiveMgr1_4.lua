module("modules.logic.versionactivity1_4.common.ActivityLiveMgr1_4", package.seeall)

local var_0_0 = class("ActivityLiveMgr1_4")

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.getActId2ViewList(arg_2_0)
	return {
		[VersionActivity1_4Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity1_4EnterView
		},
		[VersionActivity1_4Enum.ActivityId.Role37] = {
			ViewName.Activity130LevelView,
			ViewName.Activity130GameView,
			ViewName.Activity130DialogView,
			ViewName.Activity130CollectView,
			ViewName.Activity130TaskView
		},
		[VersionActivity1_4Enum.ActivityId.Role6] = {
			ViewName.Activity131LevelView,
			ViewName.Activity131GameView,
			ViewName.Activity131DialogView,
			ViewName.Activity131CollectView,
			ViewName.Activity131TaskView
		},
		[VersionActivity1_4Enum.ActivityId.ShipRepair] = {
			ViewName.Activity133View,
			ViewName.Activity133TaskView
		}
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
