module("modules.logic.versionactivity.view.VersionActivityDungeonMapViewContainer", package.seeall)

slot0 = class("VersionActivityDungeonMapViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.mapScene = VersionActivityDungeonMapScene.New()
	slot0.mapView = VersionActivityDungeonMapView.New()
	slot0.mapEpisodeView = VersionActivityDungeonMapEpisodeView.New()

	table.insert(slot1, slot0.mapView)
	table.insert(slot1, VersionActivityDungeonMapSceneElements.New())
	table.insert(slot1, slot0.mapScene)
	table.insert(slot1, slot0.mapEpisodeView)
	table.insert(slot1, DungeonMapElementReward.New())
	table.insert(slot1, VersionActivityDungeonAudioView.New())
	table.insert(slot1, TabViewGroup.New(1, "top_left"))

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
	ActivityEnterMgr.instance:enterActivity(VersionActivityEnum.ActivityId.Act113)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivityEnum.ActivityId.Act113
	})

	slot0.versionActivityDungeonBaseMo = VersionActivityDungeonBaseMo.New()

	slot0.versionActivityDungeonBaseMo:init(VersionActivityEnum.ActivityId.Act113, slot0.viewParam.chapterId, slot0.viewParam.episodeId)
	slot0.versionActivityDungeonBaseMo:setLayoutClass(VersionActivityDungeonMapChapterLayout)
	slot0.versionActivityDungeonBaseMo:setMapEpisodeItemClass(VersionActivityMapEpisodeItem)
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
	slot0.mapScene:setVisible(true)
	slot0.versionActivityDungeonBaseMo:update(slot0.viewParam.chapterId, slot0.viewParam.episodeId)
end

function slot0.setVisibleInternal(slot0, slot1)
	uv0.super.setVisibleInternal(slot0, slot1)
	slot0.mapScene:setVisible(slot1)
end

return slot0
