module("modules.logic.versionactivity1_8.dungeon.view.map.VersionActivity1_8DungeonMapViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_8DungeonMapViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.mapScene = VersionActivity1_8DungeonMapScene.New()
	arg_1_0.mapSceneElements = VersionActivity1_8DungeonMapSceneElements.New()
	arg_1_0.mapView = VersionActivity1_8DungeonMapView.New()
	arg_1_0.mapEpisodeView = VersionActivity1_8DungeonMapEpisodeView.New()
	arg_1_0.interactView = VersionActivity1_8DungeonMapInteractView.New()

	return {
		arg_1_0.mapScene,
		arg_1_0.mapSceneElements,
		arg_1_0.mapView,
		arg_1_0.mapEpisodeView,
		arg_1_0.interactView,
		VersionActivity1_8DungeonMapHoleView.New(),
		DungeonMapElementReward.New(),
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
	if VersionActivity1_8DungeonModel.instance:checkIsShowInteractView() then
		return
	end

	arg_3_0:closeThis()
end

function var_0_0.onClickHome(arg_4_0)
	if VersionActivity1_8DungeonModel.instance:checkIsShowInteractView() then
		return
	end

	NavigateButtonsView.homeClick()
end

function var_0_0.onContainerInit(arg_5_0)
	arg_5_0.versionActivityDungeonBaseMo = VersionActivity1_8DungeonMo.New()

	arg_5_0.versionActivityDungeonBaseMo:init(VersionActivity1_8Enum.ActivityId.Dungeon, arg_5_0.viewParam.chapterId, arg_5_0.viewParam.episodeId)
	arg_5_0.versionActivityDungeonBaseMo:setLayoutClass(VersionActivity1_8DungeonMapChapterLayout)
	arg_5_0.versionActivityDungeonBaseMo:setMapEpisodeItemClass(VersionActivity1_8DungeonMapEpisodeItem)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._views) do
		iter_5_1.activityDungeonMo = arg_5_0.versionActivityDungeonBaseMo
	end

	TaskDispatcher.runRepeat(arg_5_0.everySecondCall, arg_5_0, 1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function var_0_0.everySecondCall(arg_6_0)
	DispatchModel.instance:checkDispatchFinish()
end

function var_0_0.onUpdateParamInternal(arg_7_0, arg_7_1)
	arg_7_0.viewParam = arg_7_1

	arg_7_0:onContainerUpdateParam()
	arg_7_0:_setVisible(true)

	if arg_7_0._views then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._views) do
			iter_7_1.viewParam = arg_7_1

			iter_7_1:onUpdateParamInternal()
		end
	end
end

function var_0_0.onContainerUpdateParam(arg_8_0)
	arg_8_0.versionActivityDungeonBaseMo:update(arg_8_0.viewParam.chapterId, arg_8_0.viewParam.episodeId)
	arg_8_0:setVisibleInternal(true)
end

function var_0_0.setVisibleInternal(arg_9_0, arg_9_1)
	var_0_0.super.setVisibleInternal(arg_9_0, arg_9_1)

	if arg_9_0.mapScene then
		arg_9_0.mapScene:setVisible(arg_9_1)
	end
end

function var_0_0.onContainerClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.everySecondCall, arg_10_0)
end

function var_0_0.getMapScene(arg_11_0)
	return arg_11_0.mapScene
end

return var_0_0
