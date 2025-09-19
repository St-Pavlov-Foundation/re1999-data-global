module("modules.logic.survival.view.map.SurvivalMapEventViewContainer", package.seeall)

local var_0_0 = class("SurvivalMapEventViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalMapEventView.New(),
		SurvivalShrinkView.New()
	}
end

return var_0_0
