module("modules.logic.survival.view.map.SurvivalMapResultPanelViewContainer", package.seeall)

local var_0_0 = class("SurvivalMapResultPanelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalMapResultPanelView.New()
	}
end

return var_0_0
