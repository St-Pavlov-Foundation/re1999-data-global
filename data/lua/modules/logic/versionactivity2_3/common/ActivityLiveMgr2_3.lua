module("modules.logic.versionactivity2_3.common.ActivityLiveMgr2_3", package.seeall)

slot0 = class("ActivityLiveMgr2_3")

function slot0.init(slot0)
end

function slot0.getActId2ViewList(slot0)
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

slot0.instance = slot0.New()

return slot0
