module("modules.logic.survival.view.map.SurvivalShopViewContainer", package.seeall)

local var_0_0 = class("SurvivalShopViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalShopView.New()
	}
end

return var_0_0
