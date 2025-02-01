module("modules.logic.explore.view.ExploreGuideViewContainer", package.seeall)

slot0 = class("ExploreGuideViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ExploreGuideView.New()
	}
end

return slot0
