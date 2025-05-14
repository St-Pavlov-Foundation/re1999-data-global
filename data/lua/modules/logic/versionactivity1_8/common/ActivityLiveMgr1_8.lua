module("modules.logic.versionactivity1_8.common.ActivityLiveMgr1_8", package.seeall)

local var_0_0 = class("ActivityLiveMgr1_8")

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.getActId2ViewList(arg_2_0)
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

var_0_0.instance = var_0_0.New()

return var_0_0
