module("modules.logic.versionactivity.view.VersionActivityMainViewContainer", package.seeall)

slot0 = class("VersionActivityMainViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivityMainView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	slot0.navigateView:setOverrideClose(slot0.overClose, slot0)

	return {
		slot0.navigateView
	}
end

function slot0.overClose(slot0)
	slot0:closeThis()
	ViewMgr.instance:closeView(ViewName.VersionActivityDungeonMapView)
end

return slot0
