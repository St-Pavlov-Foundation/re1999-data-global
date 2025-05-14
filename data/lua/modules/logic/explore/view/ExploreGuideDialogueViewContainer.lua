module("modules.logic.explore.view.ExploreGuideDialogueViewContainer", package.seeall)

local var_0_0 = class("ExploreGuideDialogueViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		ExploreGuideDialogueView.New()
	}
end

return var_0_0
