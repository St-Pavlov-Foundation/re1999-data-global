module("modules.logic.explore.view.ExploreFinishViewContainer", package.seeall)

slot0 = class("ExploreFinishViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ExploreFinishView.New()
	}
end

return slot0
