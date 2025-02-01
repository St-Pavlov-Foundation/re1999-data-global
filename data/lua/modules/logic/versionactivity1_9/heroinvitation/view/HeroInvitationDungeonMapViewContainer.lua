module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationDungeonMapViewContainer", package.seeall)

slot0 = class("HeroInvitationDungeonMapViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.mapView = HeroInvitationDungeonMapView.New()
	slot0.mapSceneElements = HeroInvitationDungeonMapSceneElements.New()
	slot0.mapScene = HeroInvitationDungeonMapScene.New()

	table.insert(slot1, HeroInvitationDungeonMapHoleView.New())
	table.insert(slot1, slot0.mapView)
	table.insert(slot1, slot0.mapSceneElements)
	table.insert(slot1, slot0.mapScene)
	table.insert(slot1, DungeonMapElementReward.New())
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

	return {
		slot0.navigateView
	}
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

function slot0.setVisibleInternal(slot0, slot1)
	uv0.super.setVisibleInternal(slot0, slot1)

	if ViewMgr.instance:isOpen(ViewName.StoryBackgroundView) then
		slot1 = true
	end

	if slot0.mapScene then
		slot0.mapScene:setSceneVisible(slot1)
	end
end

return slot0
