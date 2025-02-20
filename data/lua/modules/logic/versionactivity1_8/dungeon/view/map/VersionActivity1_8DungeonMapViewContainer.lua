module("modules.logic.versionactivity1_8.dungeon.view.map.VersionActivity1_8DungeonMapViewContainer", package.seeall)

slot0 = class("VersionActivity1_8DungeonMapViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0.mapScene = VersionActivity1_8DungeonMapScene.New()
	slot0.mapSceneElements = VersionActivity1_8DungeonMapSceneElements.New()
	slot0.mapView = VersionActivity1_8DungeonMapView.New()
	slot0.mapEpisodeView = VersionActivity1_8DungeonMapEpisodeView.New()
	slot0.interactView = VersionActivity1_8DungeonMapInteractView.New()

	return {
		slot0.mapScene,
		slot0.mapSceneElements,
		slot0.mapView,
		slot0.mapEpisodeView,
		slot0.interactView,
		VersionActivity1_8DungeonMapHoleView.New(),
		DungeonMapElementReward.New(),
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
	if VersionActivity1_8DungeonModel.instance:checkIsShowInteractView() then
		return
	end

	slot0:closeThis()
end

function slot0.onClickHome(slot0)
	if VersionActivity1_8DungeonModel.instance:checkIsShowInteractView() then
		return
	end

	NavigateButtonsView.homeClick()
end

function slot0.onContainerInit(slot0)
	slot0.versionActivityDungeonBaseMo = VersionActivity1_8DungeonMo.New()
	slot5 = slot0.viewParam.chapterId

	slot0.versionActivityDungeonBaseMo:init(VersionActivity1_8Enum.ActivityId.Dungeon, slot5, slot0.viewParam.episodeId)
	slot0.versionActivityDungeonBaseMo:setLayoutClass(VersionActivity1_8DungeonMapChapterLayout)

	slot4 = VersionActivity1_8DungeonMapEpisodeItem

	slot0.versionActivityDungeonBaseMo:setMapEpisodeItemClass(slot4)

	for slot4, slot5 in ipairs(slot0._views) do
		slot5.activityDungeonMo = slot0.versionActivityDungeonBaseMo
	end

	TaskDispatcher.runRepeat(slot0.everySecondCall, slot0, 1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function slot0.everySecondCall(slot0)
	DispatchModel.instance:checkDispatchFinish()
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
