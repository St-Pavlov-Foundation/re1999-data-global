module("modules.logic.explore.view.ExploreMapViewContainer", package.seeall)

slot0 = class("ExploreMapViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ExploreMapView.New()
	}
end

return slot0
