module("modules.logic.versionactivity2_0.dungeon.view.map.VersionActivity2_0DungeonMapViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_0DungeonMapViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.mapScene = VersionActivity2_0DungeonMapScene.New()
	arg_1_0.mapSceneElements = VersionActivity2_0DungeonMapSceneElements.New()
	arg_1_0.mapView = VersionActivity2_0DungeonMapView.New()
	arg_1_0.mapEpisodeView = VersionActivity2_0DungeonMapEpisodeView.New()
	arg_1_0.interactView = VersionActivity2_0DungeonMapInteractView.New()
	arg_1_0.mapElementReward = DungeonMapElementReward.New()

	return {
		VersionActivity2_0DungeonMapHoleView.New(),
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
	if VersionActivity2_0DungeonModel.instance:checkIsShowInteractView() then
		return
	end

	if VersionActivity2_0DungeonModel.instance:getOpenGraffitiEntranceState() then
		Activity161Controller.instance:dispatchEvent(Activity161Event.CloseRestaurantWithEffect)

		return
	end

	arg_3_0:closeThis()
end

function var_0_0.onClickHome(arg_4_0)
	if VersionActivity2_0DungeonModel.instance:checkIsShowInteractView() then
		return
	end

	NavigateButtonsView.homeClick()
end

function var_0_0.onContainerInit(arg_5_0)
	arg_5_0.versionActivityDungeonBaseMo = VersionActivity2_0DungeonMo.New()

	arg_5_0.versionActivityDungeonBaseMo:init(VersionActivity2_0Enum.ActivityId.Dungeon, arg_5_0.viewParam.chapterId, arg_5_0.viewParam.episodeId)
	arg_5_0.versionActivityDungeonBaseMo:setLayoutClass(VersionActivity2_0DungeonMapChapterLayout)
	arg_5_0.versionActivityDungeonBaseMo:setMapEpisodeItemClass(VersionActivity2_0DungeonMapEpisodeItem)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._views) do
		iter_5_1.activityDungeonMo = arg_5_0.versionActivityDungeonBaseMo
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	VersionActivity2_0DungeonModel.instance:setDungeonBaseMo(arg_5_0.versionActivityDungeonBaseMo)
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
