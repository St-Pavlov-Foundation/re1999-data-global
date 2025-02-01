module("modules.logic.versionactivity1_7.common.ActivityLiveMgr1_7", package.seeall)

slot0 = class("ActivityLiveMgr1_7")

function slot0.init(slot0)
end

function slot0.getActId2ViewList(slot0)
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

slot0.instance = slot0.New()

return slot0
