module("modules.logic.survival.view.map.SurvivalMapResultViewContainer", package.seeall)

local var_0_0 = class("SurvivalMapResultViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalMapResultView.New()
	}
end

return var_0_0
