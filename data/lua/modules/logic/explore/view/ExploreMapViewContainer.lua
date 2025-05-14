module("modules.logic.explore.view.ExploreMapViewContainer", package.seeall)

local var_0_0 = class("ExploreMapViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		ExploreMapView.New()
	}
end

return var_0_0
