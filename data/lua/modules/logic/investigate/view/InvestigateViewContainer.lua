module("modules.logic.investigate.view.InvestigateViewContainer", package.seeall)

slot0 = class("InvestigateViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		InvestigateView.New(),
		TabViewGroup.New(1, "root/#go_topleft")
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		slot0.navigateView
	}
end

return slot0
