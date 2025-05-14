module("modules.logic.guide.view.GuideStepEditorContainer", package.seeall)

local var_0_0 = class("GuideStepEditorContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		GuideStepEditor.New(),
		GuideMaskView.New(),
		GuideTipsView.New(),
		GuideStoryView.New(),
		GuideDialogueView.New()
	}
end

return var_0_0
