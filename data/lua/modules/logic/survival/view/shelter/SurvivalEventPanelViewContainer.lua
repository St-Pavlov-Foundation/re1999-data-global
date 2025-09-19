module("modules.logic.survival.view.shelter.SurvivalEventPanelViewContainer", package.seeall)

local var_0_0 = class("SurvivalEventPanelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalEventPanelView.New()
	}
end

return var_0_0
