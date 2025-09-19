module("modules.logic.survival.view.map.SurvivalMapSearchViewContainer", package.seeall)

local var_0_0 = class("SurvivalMapSearchViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalMapSearchView.New()
	}
end

return var_0_0
