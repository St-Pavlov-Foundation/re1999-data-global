module("modules.logic.versionactivity2_1.common.ActivityLiveMgr2_1", package.seeall)

local var_0_0 = class("ActivityLiveMgr2_1")

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.getActId2ViewList(arg_2_0)
	return {
		[VersionActivity2_1Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity2_1EnterView
		},
		[VersionActivity2_1Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity2_1StoreView
		},
		[VersionActivity2_1Enum.ActivityId.LanShouPa] = {
			ViewName.LanShouPaMapView,
			ViewName.LanShouPaGameView
		}
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
