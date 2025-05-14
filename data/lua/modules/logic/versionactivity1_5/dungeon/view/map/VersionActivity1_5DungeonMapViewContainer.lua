module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_5DungeonMapViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.mapScene = VersionActivity1_5DungeonMapScene.New()
	arg_1_0.mapView = VersionActivity1_5DungeonMapView.New()
	arg_1_0.mapEpisodeView = VersionActivity1_5DungeonMapEpisodeView.New()
	arg_1_0.mapSceneElements = VersionActivity1_5DungeonMapSceneElements.New()
	arg_1_0.interactView = VersionActivity1_5DungeonMapInteractView.New()

	table.insert(var_1_0, arg_1_0.mapView)
	table.insert(var_1_0, arg_1_0.mapSceneElements)
	table.insert(var_1_0, arg_1_0.mapScene)
	table.insert(var_1_0, arg_1_0.mapEpisodeView)
	table.insert(var_1_0, VersionActivity1_5DungeonMapHeroIconView.New())
	table.insert(var_1_0, arg_1_0.interactView)
	table.insert(var_1_0, VersionActivity1_5DungeonMapHoleView.New())
	table.insert(var_1_0, VersionActivity1_5DungeonSceneEffectView.New())
	table.insert(var_1_0, DungeonMapElementReward.New())
	table.insert(var_1_0, VersionActivity1_5DungeonMapAudioView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

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
	})

	arg_3_0.navigateView:setOverrideClose(arg_3_0.onClickClose, arg_3_0)
	arg_3_0.navigateView:setOverrideHome(arg_3_0.onClickHome, arg_3_0)

	return {
		arg_3_0.navigateView
	}
end

function var_0_0.onClickClose(arg_4_0)
	if VersionActivity1_5DungeonModel.instance:checkIsShowInteractView() then
		return
	end

	arg_4_0:closeThis()
end

function var_0_0.onClickHome(arg_5_0)
	if VersionActivity1_5DungeonModel.instance:checkIsShowInteractView() then
		return
	end

	NavigateButtonsView.homeClick()
end

function var_0_0.onContainerInit(arg_6_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_5Enum.ActivityId.Dungeon)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_5Enum.ActivityId.Dungeon
	})

	arg_6_0.versionActivityDungeonBaseMo = VersionActivity1_5DungeonMo.New()

	arg_6_0.versionActivityDungeonBaseMo:init(VersionActivity1_5Enum.ActivityId.Dungeon, arg_6_0.viewParam.chapterId, arg_6_0.viewParam.episodeId)
	arg_6_0.versionActivityDungeonBaseMo:setLayoutClass(VersionActivity1_5DungeonMapChapterLayout)
	arg_6_0.versionActivityDungeonBaseMo:setMapEpisodeItemClass(VersionActivity1_5DungeonMapEpisodeItem)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._views) do
		iter_6_1.activityDungeonMo = arg_6_0.versionActivityDungeonBaseMo
	end

	TaskDispatcher.runRepeat(arg_6_0.everySecondCall, arg_6_0, 1)
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
	VersionActivity1_5RevivalTaskModel.instance:clear()
	TaskDispatcher.cancelTask(arg_10_0.everySecondCall, arg_10_0)
end

function var_0_0.everySecondCall(arg_11_0)
	VersionActivity1_5DungeonModel.instance:checkDispatchFinish()
end

return var_0_0
