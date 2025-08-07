module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_9DungeonMapViewContainer", VersionActivityFixedDungeonMapViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.mapScene = VersionActivityFixedHelper.getVersionActivityDungeonMapScene().New()
	arg_1_0.mapSceneElements = VersionActivityFixedHelper.getVersionActivityDungeonMapSceneElements().New()
	arg_1_0.mapView = VersionActivityFixedHelper.getVersionActivityDungeonMapView().New()
	arg_1_0.mapEpisodeView = VersionActivityFixedHelper.getVersionActivityDungeonMapEpisodeView().New()
	arg_1_0.interactView = VersionActivityFixedHelper.getVersionActivityDungeonMapInteractView().New()
	arg_1_0.mapElementReward = VersionActivity2_9DungeonMapElementReward.New()
	arg_1_0.director = VersionActivity2_9DungeonMapDirector.New()

	local var_1_0 = {
		VersionActivityFixedHelper.getVersionActivityDungeonMapHoleView().New(),
		arg_1_0.mapSceneElements,
		arg_1_0.mapScene,
		arg_1_0.mapView,
		arg_1_0.mapEpisodeView,
		arg_1_0.interactView,
		arg_1_0.mapElementReward,
		arg_1_0.director,
		VersionActivity2_9DungeonMapExtraView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}

	if isDebugBuild then
		table.insert(var_1_0, VersionActivity2_9DungeonMapEditView.New())
	end

	return var_1_0
end

function var_0_0.playCloseTransition(arg_2_0)
	ZProj.ProjAnimatorPlayer.Get(arg_2_0.viewGO):Play("to_game", arg_2_0.onPlayCloseTransitionFinish, arg_2_0)
end

return var_0_0
