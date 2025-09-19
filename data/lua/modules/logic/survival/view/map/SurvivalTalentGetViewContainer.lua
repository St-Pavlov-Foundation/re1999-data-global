module("modules.logic.survival.view.map.SurvivalTalentGetViewContainer", package.seeall)

local var_0_0 = class("SurvivalTalentGetViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalTalentGetView.New()
	}
end

return var_0_0
