module("modules.logic.survival.view.SurvivalCurrencyTipViewContainer", package.seeall)

local var_0_0 = class("SurvivalCurrencyTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalCurrencyTipView.New()
	}
end

return var_0_0
