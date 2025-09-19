module("modules.logic.survival.view.map.SurvivalToastViewContainer", package.seeall)

local var_0_0 = class("SurvivalToastViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalToastView.New()
	}
end

return var_0_0
