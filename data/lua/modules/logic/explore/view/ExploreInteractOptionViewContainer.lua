module("modules.logic.explore.view.ExploreInteractOptionViewContainer", package.seeall)

slot0 = class("ExploreInteractOptionViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ExploreInteractOptionView.New()
	}
end

return slot0
