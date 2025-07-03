module("modules.logic.versionactivity2_7.dungeon.view.map.VersionActivity2_7DungeonMapViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_7DungeonMapViewContainer", VersionActivityFixedDungeonMapViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.mapScene = VersionActivity2_7DungeonMapScene.New()
	arg_1_0.mapSceneElements = VersionActivityFixedHelper.getVersionActivityDungeonMapSceneElements().New()
	arg_1_0.mapView = VersionActivityFixedHelper.getVersionActivityDungeonMapView().New()
	arg_1_0.mapEpisodeView = VersionActivityFixedHelper.getVersionActivityDungeonMapEpisodeView().New()
	arg_1_0.interactView = VersionActivityFixedHelper.getVersionActivityDungeonMapInteractView().New()
	arg_1_0.mapElementReward = DungeonMapElementReward.New()

	return {
		VersionActivityFixedHelper.getVersionActivityDungeonMapHoleView().New(),
		arg_1_0.mapScene,
		arg_1_0.mapSceneElements,
		arg_1_0.mapView,
		arg_1_0.mapEpisodeView,
		arg_1_0.interactView,
		arg_1_0.mapElementReward,
		TabViewGroup.New(1, "#go_topleft")
	}
end

return var_0_0
