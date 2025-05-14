module("modules.logic.versionactivity1_2.common.ActivityLiveMgr1_2", package.seeall)

local var_0_0 = class("ActivityLiveMgr1_2")

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.getActId2ViewList(arg_2_0)
	return {
		[VersionActivity1_2Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity1_2EnterView
		},
		[VersionActivity1_2Enum.ActivityId.JieXiKa] = {
			ViewName.Activity114View
		},
		[VersionActivity1_2Enum.ActivityId.YaXian] = {
			ViewName.YaXianMapView,
			ViewName.YaXianGameView
		},
		[VersionActivity1_2Enum.ActivityId.Trade] = {
			ViewName.ActivityTradeBargain
		},
		[VersionActivity1_2Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity1_2DungeonView
		},
		[VersionActivity1_2Enum.ActivityId.DreamTail] = {
			ViewName.Activity119View
		},
		[VersionActivity1_2Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity1_2StoreView
		}
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
