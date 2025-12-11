module("modules.logic.survival.view.rewardinherit.survivalrewardselect.SurvivalRewardSelectViewContainer", package.seeall)

local var_0_0 = class("SurvivalRewardSelectViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalRewardSelectView.New()
	}
end

return var_0_0
