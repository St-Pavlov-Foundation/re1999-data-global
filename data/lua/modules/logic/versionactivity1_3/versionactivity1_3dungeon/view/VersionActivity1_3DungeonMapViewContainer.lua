module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonMapViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_3DungeonMapViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.mapScene = VersionActivity1_3DungeonMapScene.New()
	arg_1_0.mapView = VersionActivity1_3DungeonMapView.New()
	arg_1_0.mapEpisodeView = VersionActivity1_3DungeonMapEpisodeView.New()
	arg_1_0.mapSceneElements = VersionActivity1_3DungeonMapSceneElements.New()

	table.insert(var_1_0, arg_1_0.mapView)
	table.insert(var_1_0, arg_1_0.mapSceneElements)
	table.insert(var_1_0, arg_1_0.mapScene)
	table.insert(var_1_0, arg_1_0.mapEpisodeView)
	table.insert(var_1_0, DungeonMapElementReward.New())
	table.insert(var_1_0, VersionActivity1_3DungeonAudioView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "top_left"))

	return var_1_0
end

function var_0_0.getMapScene(arg_2_0)
	return arg_2_0.mapScene
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	arg_3_0.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	}, nil, nil, arg_3_0.homeCallback, nil, arg_3_0)

	return {
		arg_3_0.navigateView
	}
end

function var_0_0.onContainerInit(arg_4_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_3Enum.ActivityId.Dungeon)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_3Enum.ActivityId.Dungeon
	})

	arg_4_0.versionActivityDungeonBaseMo = VersionActivityDungeonBaseMo.New()

	arg_4_0.versionActivityDungeonBaseMo:init(VersionActivity1_3Enum.ActivityId.Dungeon, arg_4_0.viewParam.chapterId, arg_4_0.viewParam.episodeId)
	arg_4_0.versionActivityDungeonBaseMo:setLayoutClass(VersionActivity1_3DungeonMapChapterLayout)
	arg_4_0.versionActivityDungeonBaseMo:setMapEpisodeItemClass(VersionActivity1_3MapEpisodeItem)
end

function var_0_0.onUpdateParamInternal(arg_5_0, arg_5_1)
	arg_5_0.viewParam = arg_5_1

	arg_5_0:onContainerUpdateParam()
	arg_5_0:_setVisible(true)

	if arg_5_0._views then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0._views) do
			iter_5_1.viewParam = arg_5_1

			iter_5_1:onUpdateParamInternal()
		end
	end
end

function var_0_0.onContainerUpdateParam(arg_6_0)
	arg_6_0.versionActivityDungeonBaseMo:update(arg_6_0.viewParam.chapterId, arg_6_0.viewParam.episodeId)
	arg_6_0:setVisibleInternal(true)
end

function var_0_0.setVisibleInternal(arg_7_0, arg_7_1)
	var_0_0.super.setVisibleInternal(arg_7_0, arg_7_1)

	if arg_7_0.mapScene then
		arg_7_0.mapScene:setVisible(arg_7_1)
	end
end

return var_0_0
