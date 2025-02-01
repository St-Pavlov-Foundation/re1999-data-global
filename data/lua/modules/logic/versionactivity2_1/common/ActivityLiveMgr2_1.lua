module("modules.logic.versionactivity2_1.common.ActivityLiveMgr2_1", package.seeall)

slot0 = class("ActivityLiveMgr2_1")

function slot0.init(slot0)
end

function slot0.getActId2ViewList(slot0)
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

slot0.instance = slot0.New()

return slot0
