module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapViewContainer", package.seeall)

slot0 = class("VersionActivity1_5DungeonMapViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.mapScene = VersionActivity1_5DungeonMapScene.New()
	slot0.mapView = VersionActivity1_5DungeonMapView.New()
	slot0.mapEpisodeView = VersionActivity1_5DungeonMapEpisodeView.New()
	slot0.mapSceneElements = VersionActivity1_5DungeonMapSceneElements.New()
	slot0.interactView = VersionActivity1_5DungeonMapInteractView.New()

	table.insert(slot1, slot0.mapView)
	table.insert(slot1, slot0.mapSceneElements)
	table.insert(slot1, slot0.mapScene)
	table.insert(slot1, slot0.mapEpisodeView)
	table.insert(slot1, VersionActivity1_5DungeonMapHeroIconView.New())
	table.insert(slot1, slot0.interactView)
	table.insert(slot1, VersionActivity1_5DungeonMapHoleView.New())
	table.insert(slot1, VersionActivity1_5DungeonSceneEffectView.New())
	table.insert(slot1, DungeonMapElementReward.New())
	table.insert(slot1, VersionActivity1_5DungeonMapAudioView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
end

function slot0.getMapScene(slot0)
	return slot0.mapScene
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
	if VersionActivity1_5DungeonModel.instance:checkIsShowInteractView() then
		return
	end

	slot0:closeThis()
end

function slot0.onClickHome(slot0)
	if VersionActivity1_5DungeonModel.instance:checkIsShowInteractView() then
		return
	end

	NavigateButtonsView.homeClick()
end

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_5Enum.ActivityId.Dungeon)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_5Enum.ActivityId.Dungeon
	})

	slot0.versionActivityDungeonBaseMo = VersionActivity1_5DungeonMo.New()
	slot4 = slot0.viewParam.chapterId
	slot5 = slot0.viewParam.episodeId

	slot0.versionActivityDungeonBaseMo:init(VersionActivity1_5Enum.ActivityId.Dungeon, slot4, slot5)
	slot0.versionActivityDungeonBaseMo:setLayoutClass(VersionActivity1_5DungeonMapChapterLayout)
	slot0.versionActivityDungeonBaseMo:setMapEpisodeItemClass(VersionActivity1_5DungeonMapEpisodeItem)

	for slot4, slot5 in ipairs(slot0._views) do
		slot5.activityDungeonMo = slot0.versionActivityDungeonBaseMo
	end

	TaskDispatcher.runRepeat(slot0.everySecondCall, slot0, 1)
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
	VersionActivity1_5RevivalTaskModel.instance:clear()
	TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)
end

function slot0.everySecondCall(slot0)
	VersionActivity1_5DungeonModel.instance:checkDispatchFinish()
end

return slot0
