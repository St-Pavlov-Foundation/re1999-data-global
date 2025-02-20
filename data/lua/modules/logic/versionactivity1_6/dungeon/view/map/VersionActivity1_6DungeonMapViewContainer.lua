module("modules.logic.versionactivity1_6.dungeon.view.map.VersionActivity1_6DungeonMapViewContainer", package.seeall)

slot0 = class("VersionActivity1_6DungeonMapViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.mapScene = VersionActivity1_6DungeonMapScene.New()
	slot0.mapView = VersionActivity1_6DungeonMapView.New()
	slot0.mapEpisodeView = VersionActivity1_6DungeonMapEpisodeView.New()
	slot0.mapSceneElements = VersionActivity1_6DungeonMapSceneElements.New()

	table.insert(slot1, slot0.mapView)
	table.insert(slot1, slot0.mapSceneElements)
	table.insert(slot1, slot0.mapScene)
	table.insert(slot1, slot0.mapEpisodeView)
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
	}, nil, , slot0.homeCallback, nil, slot0)

	return {
		slot0.navigateView
	}
end

function slot0.onContainerInit(slot0)
	slot0.versionActivityDungeonBaseMo = VersionActivityDungeonBaseMo.New()
	slot5 = slot0.viewParam.chapterId

	slot0.versionActivityDungeonBaseMo:init(VersionActivity1_6Enum.ActivityId.Dungeon, slot5, slot0.viewParam.episodeId)
	slot0.versionActivityDungeonBaseMo:setLayoutClass(VersionActivity1_6DungeonMapChapterLayout)

	slot4 = VersionActivity1_6DungeonMapEpisodeItem

	slot0.versionActivityDungeonBaseMo:setMapEpisodeItemClass(slot4)

	for slot4, slot5 in ipairs(slot0._views) do
		slot5.activityDungeonMo = slot0.versionActivityDungeonBaseMo
	end
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
end

return slot0
