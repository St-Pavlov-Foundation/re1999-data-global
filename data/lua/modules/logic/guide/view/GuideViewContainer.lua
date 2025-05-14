module("modules.logic.guide.view.GuideViewContainer", package.seeall)

local var_0_0 = class("GuideViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		GuideView.New(),
		GuideMaskView.New(),
		GuideTipsView.New(),
		GuideStoryView.New(),
		GuideDialogueView.New()
	}
end

return var_0_0
