module("modules.logic.survival.view.SurvivalItemInfoViewContainer", package.seeall)

local var_0_0 = class("SurvivalItemInfoViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalItemInfoView.New()
	}
end

return var_0_0
