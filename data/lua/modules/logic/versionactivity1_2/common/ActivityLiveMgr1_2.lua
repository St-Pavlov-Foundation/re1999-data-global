module("modules.logic.versionactivity1_2.common.ActivityLiveMgr1_2", package.seeall)

slot0 = class("ActivityLiveMgr1_2")

function slot0.init(slot0)
end

function slot0.getActId2ViewList(slot0)
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

slot0.instance = slot0.New()

return slot0
