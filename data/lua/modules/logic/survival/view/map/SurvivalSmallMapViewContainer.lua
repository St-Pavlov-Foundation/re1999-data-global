module("modules.logic.survival.view.map.SurvivalSmallMapViewContainer", package.seeall)

local var_0_0 = class("SurvivalSmallMapViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalSmallMapView.New()
	}
end

return var_0_0
