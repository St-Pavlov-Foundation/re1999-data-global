module("modules.logic.explore.view.ExploreBlackViewContainer", package.seeall)

slot0 = class("ExploreBlackViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ExploreBlackView.New()
	}
end

return slot0
