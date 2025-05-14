module("modules.logic.explore.view.ExploreBlackViewContainer", package.seeall)

local var_0_0 = class("ExploreBlackViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		ExploreBlackView.New()
	}
end

return var_0_0
