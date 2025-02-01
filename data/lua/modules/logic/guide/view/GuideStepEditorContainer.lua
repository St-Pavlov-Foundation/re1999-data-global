module("modules.logic.guide.view.GuideStepEditorContainer", package.seeall)

slot0 = class("GuideStepEditorContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		GuideStepEditor.New(),
		GuideMaskView.New(),
		GuideTipsView.New(),
		GuideStoryView.New(),
		GuideDialogueView.New()
	}
end

return slot0
