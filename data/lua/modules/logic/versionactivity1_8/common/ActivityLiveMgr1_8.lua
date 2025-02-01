module("modules.logic.versionactivity1_8.common.ActivityLiveMgr1_8", package.seeall)

slot0 = class("ActivityLiveMgr1_8")

function slot0.init(slot0)
end

function slot0.getActId2ViewList(slot0)
	return {
		[VersionActivity1_8Enum.ActivityId.EnterView] = {
			ViewName.VersionActivity1_8EnterView
		},
		[VersionActivity1_8Enum.ActivityId.Dungeon] = {
			ViewName.VersionActivity1_8DungeonMapView,
			ViewName.VersionActivity1_8TaskView,
			ViewName.VersionActivity1_8DungeonMapLevelView,
			ViewName.VersionActivity1_8FactoryMapView,
			ViewName.VersionActivity1_8FactoryBlueprintView,
			ViewName.VersionActivity1_8FactoryRepairView,
			ViewName.VersionActivity1_8FactoryCompositeView
		},
		[VersionActivity1_8Enum.ActivityId.DungeonStore] = {
			ViewName.VersionActivity1_8StoreView,
			ViewName.VersionActivity1_6NormalStoreGoodsView
		},
		[VersionActivity1_8Enum.ActivityId.DungeonReturnToWork] = {
			ViewName.VersionActivity1_8FactoryMapView,
			ViewName.VersionActivity1_8FactoryBlueprintView,
			ViewName.VersionActivity1_8FactoryRepairView,
			ViewName.VersionActivity1_8FactoryCompositeView
		}
	}
end

slot0.instance = slot0.New()

return slot0
