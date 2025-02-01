module("modules.logic.guide.view.GuideViewContainer", package.seeall)

slot0 = class("GuideViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		GuideView.New(),
		GuideMaskView.New(),
		GuideTipsView.New(),
		GuideStoryView.New(),
		GuideDialogueView.New()
	}
end

return slot0
