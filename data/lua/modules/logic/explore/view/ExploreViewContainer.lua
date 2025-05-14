module("modules.logic.explore.view.ExploreViewContainer", package.seeall)

local var_0_0 = class("ExploreViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		ExploreView.New(),
		ExploreSmallMapView.New()
	}
end

return var_0_0
