module("modules.logic.survival.view.map.SurvivalGetRewardViewContainer", package.seeall)

local var_0_0 = class("SurvivalGetRewardViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalGetRewardView.New()
	}
end

return var_0_0
