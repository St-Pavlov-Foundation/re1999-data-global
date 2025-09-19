module("modules.logic.survival.view.map.SurvivalLoadingViewContainer", package.seeall)

local var_0_0 = class("SurvivalLoadingViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalLoadingView.New()
	}
end

return var_0_0
