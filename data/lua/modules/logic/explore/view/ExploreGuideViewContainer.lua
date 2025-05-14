module("modules.logic.explore.view.ExploreGuideViewContainer", package.seeall)

local var_0_0 = class("ExploreGuideViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		ExploreGuideView.New()
	}
end

return var_0_0
