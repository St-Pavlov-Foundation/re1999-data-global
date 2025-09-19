module("modules.logic.survival.view.SurvivalTalentOverViewContainer", package.seeall)

local var_0_0 = class("SurvivalTalentOverViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalTalentOverView.New()
	}
end

return var_0_0
