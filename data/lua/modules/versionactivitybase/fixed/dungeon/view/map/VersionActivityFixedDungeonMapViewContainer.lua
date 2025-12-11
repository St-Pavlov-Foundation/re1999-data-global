module("modules.versionactivitybase.fixed.dungeon.view.map.VersionActivityFixedDungeonMapViewContainer", package.seeall)

local var_0_0 = class("VersionActivityFixedDungeonMapViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._bigVersion, arg_1_0._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	arg_1_0.mapScene = VersionActivityFixedHelper.getVersionActivityDungeonMapScene(arg_1_0._bigVersion, arg_1_0._smallVersion).New()
	arg_1_0.mapSceneElements = VersionActivityFixedHelper.getVersionActivityDungeonMapSceneElements(arg_1_0._bigVersion, arg_1_0._smallVersion).New()
	arg_1_0.mapView = VersionActivityFixedHelper.getVersionActivityDungeonMapView(arg_1_0._bigVersion, arg_1_0._smallVersion).New()
	arg_1_0.mapEpisodeView = VersionActivityFixedHelper.getVersionActivityDungeonMapEpisodeView(arg_1_0._bigVersion, arg_1_0._smallVersion).New()
	arg_1_0.interactView = VersionActivityFixedHelper.getVersionActivityDungeonMapInteractView(arg_1_0._bigVersion, arg_1_0._smallVersion).New()
	arg_1_0.mapElementReward = DungeonMapElementReward.New()

	return {
		VersionActivityFixedHelper.getVersionActivityDungeonMapHoleView(arg_1_0._bigVersion, arg_1_0._smallVersion).New(),
		arg_1_0.mapScene,
		arg_1_0.mapSceneElements,
		arg_1_0.mapView,
		arg_1_0.mapEpisodeView,
		arg_1_0.interactView,
		arg_1_0.mapElementReward,
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	arg_2_0.navigateView:setOverrideClose(arg_2_0.onClickClose, arg_2_0)
	arg_2_0.navigateView:setOverrideHome(arg_2_0.onClickHome, arg_2_0)

	return {
		arg_2_0.navigateView
	}
end

function var_0_0.onClickClose(arg_3_0)
	if VersionActivityFixedDungeonModel.instance:checkIsShowInteractView() then
		return
	end

	arg_3_0:closeThis()
end

function var_0_0.onClickHome(arg_4_0)
	if VersionActivityFixedDungeonModel.instance:checkIsShowInteractView() then
		return
	end

	NavigateButtonsView.homeClick()
end

function var_0_0.onContainerInit(arg_5_0)
	arg_5_0.versionActivityDungeonBaseMo = VersionActivityFixedDungeonMo.New()

	arg_5_0.versionActivityDungeonBaseMo:init(VersionActivityFixedHelper.getVersionActivityEnum(arg_5_0._bigVersion, arg_5_0._smallVersion).ActivityId.Dungeon, arg_5_0.viewParam.chapterId, arg_5_0.viewParam.episodeId)
	arg_5_0.versionActivityDungeonBaseMo:setLayoutClass(VersionActivityFixedHelper.getVersionActivityDungeonMapChapterLayout(arg_5_0._bigVersion, arg_5_0._smallVersion))
	arg_5_0.versionActivityDungeonBaseMo:setMapEpisodeItemClass(VersionActivityFixedHelper.getVersionActivityDungeonMapEpisodeItem(arg_5_0._bigVersion, arg_5_0._smallVersion))

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._views) do
		iter_5_1.activityDungeonMo = arg_5_0.versionActivityDungeonBaseMo
	end

	VersionActivityFixedDungeonModel.instance:setDungeonBaseMo(arg_5_0.versionActivityDungeonBaseMo)
	arg_5_0.mapElementReward:setShowToastState(true)
end

function var_0_0.onUpdateParamInternal(arg_6_0, arg_6_1)
	arg_6_0.viewParam = arg_6_1

	arg_6_0:onContainerUpdateParam()
	arg_6_0:_setVisible(true)

	if arg_6_0._views then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0._views) do
			iter_6_1.viewParam = arg_6_1

			iter_6_1:onUpdateParamInternal()
		end
	end
end

function var_0_0.onContainerUpdateParam(arg_7_0)
	arg_7_0.versionActivityDungeonBaseMo:update(arg_7_0.viewParam.chapterId, arg_7_0.viewParam.episodeId)
	arg_7_0:setVisibleInternal(true)
end

function var_0_0.setVisibleInternal(arg_8_0, arg_8_1)
	var_0_0.super.setVisibleInternal(arg_8_0, arg_8_1)

	if arg_8_0.mapScene then
		arg_8_0.mapScene:setVisible(arg_8_1)
	end
end

function var_0_0.onContainerClose(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.everySecondCall, arg_9_0)
end

function var_0_0.getMapScene(arg_10_0)
	return arg_10_0.mapScene
end

return var_0_0
