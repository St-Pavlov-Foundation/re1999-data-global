module("modules.logic.versionactivity2_1.dungeon.view.map.VersionActivity2_1DungeonMapViewContainer", package.seeall)

slot0 = class("VersionActivity2_1DungeonMapViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0.mapScene = VersionActivity2_1DungeonMapScene.New()
	slot0.mapSceneElements = VersionActivity2_1DungeonMapSceneElements.New()
	slot0.mapView = VersionActivity2_1DungeonMapView.New()
	slot0.mapEpisodeView = VersionActivity2_1DungeonMapEpisodeView.New()
	slot0.interactView = VersionActivity2_1DungeonMapInteractView.New()
	slot0.mapElementReward = DungeonMapElementReward.New()

	return {
		VersionActivity2_1DungeonMapHoleView.New(),
		slot0.mapScene,
		slot0.mapSceneElements,
		slot0.mapView,
		slot0.mapEpisodeView,
		slot0.interactView,
		slot0.mapElementReward,
		TabViewGroup.New(1, "#go_topleft")
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	slot0.navigateView:setOverrideClose(slot0.onClickClose, slot0)
	slot0.navigateView:setOverrideHome(slot0.onClickHome, slot0)

	return {
		slot0.navigateView
	}
end

function slot0.onClickClose(slot0)
	if VersionActivity2_1DungeonModel.instance:checkIsShowInteractView() then
		return
	end

	slot0:closeThis()
end

function slot0.onClickHome(slot0)
	if VersionActivity2_1DungeonModel.instance:checkIsShowInteractView() then
		return
	end

	NavigateButtonsView.homeClick()
end

function slot0.onContainerInit(slot0)
	slot0.versionActivityDungeonBaseMo = VersionActivity2_1DungeonMo.New()
	slot5 = slot0.viewParam.chapterId

	slot0.versionActivityDungeonBaseMo:init(VersionActivity2_1Enum.ActivityId.Dungeon, slot5, slot0.viewParam.episodeId)
	slot0.versionActivityDungeonBaseMo:setLayoutClass(VersionActivity2_1DungeonMapChapterLayout)

	slot4 = VersionActivity2_1DungeonMapEpisodeItem

	slot0.versionActivityDungeonBaseMo:setMapEpisodeItemClass(slot4)

	for slot4, slot5 in ipairs(slot0._views) do
		slot5.activityDungeonMo = slot0.versionActivityDungeonBaseMo
	end

	VersionActivity2_1DungeonModel.instance:setDungeonBaseMo(slot0.versionActivityDungeonBaseMo)
	slot0.mapElementReward:setShowToastState(true)
end

function slot0.onUpdateParamInternal(slot0, slot1)
	slot0.viewParam = slot1

	slot0:onContainerUpdateParam()
	slot0:_setVisible(true)

	if slot0._views then
		for slot5, slot6 in ipairs(slot0._views) do
			slot6.viewParam = slot1

			slot6:onUpdateParamInternal()
		end
	end
end

function slot0.onContainerUpdateParam(slot0)
	slot0.versionActivityDungeonBaseMo:update(slot0.viewParam.chapterId, slot0.viewParam.episodeId)
	slot0:setVisibleInternal(true)
end

function slot0.setVisibleInternal(slot0, slot1)
	uv0.super.setVisibleInternal(slot0, slot1)

	if slot0.mapScene then
		slot0.mapScene:setVisible(slot1)
	end
end

function slot0.onContainerClose(slot0)
	TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)
end

function slot0.getMapScene(slot0)
	return slot0.mapScene
end

return slot0
