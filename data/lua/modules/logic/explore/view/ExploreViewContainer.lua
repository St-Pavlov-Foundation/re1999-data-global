module("modules.logic.explore.view.ExploreViewContainer", package.seeall)

slot0 = class("ExploreViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ExploreView.New(),
		ExploreSmallMapView.New()
	}
end

return slot0
