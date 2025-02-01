module("modules.logic.explore.view.ExploreArchivesDetailViewContainer", package.seeall)

slot0 = class("ExploreArchivesDetailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ExploreArchivesDetailView.New()
	}
end

return slot0
