module("modules.logic.versionactivity1_9.common.ActivityLiveMgr1_9", package.seeall)

slot0 = class("ActivityLiveMgr1_9")

function slot0.init(slot0)
end

function slot0.getActId2ViewList(slot0)
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

slot0.instance = slot0.New()

return slot0
