module("modules.logic.explore.view.ExploreInteractViewContainer", package.seeall)

slot0 = class("ExploreInteractViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ExploreInteractView.New()
	}
end

return slot0
