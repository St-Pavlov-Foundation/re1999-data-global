module("modules.logic.explore.view.ExploreEnterViewContainer", package.seeall)

slot0 = class("ExploreEnterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ExploreEnterView.New()
	}
end

return slot0
