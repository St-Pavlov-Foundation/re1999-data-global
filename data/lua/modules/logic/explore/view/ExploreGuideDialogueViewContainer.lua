module("modules.logic.explore.view.ExploreGuideDialogueViewContainer", package.seeall)

slot0 = class("ExploreGuideDialogueViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ExploreGuideDialogueView.New()
	}
end

return slot0
