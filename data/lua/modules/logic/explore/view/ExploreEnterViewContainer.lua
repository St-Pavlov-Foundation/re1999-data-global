module("modules.logic.explore.view.ExploreEnterViewContainer", package.seeall)

local var_0_0 = class("ExploreEnterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		ExploreEnterView.New()
	}
end

return var_0_0
