module("modules.logic.survival.view.map.SurvivalLogViewContainer", package.seeall)

local var_0_0 = class("SurvivalLogViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalLogView.New()
	}
end

return var_0_0
