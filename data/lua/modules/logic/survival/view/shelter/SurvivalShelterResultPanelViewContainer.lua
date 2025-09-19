module("modules.logic.survival.view.shelter.SurvivalShelterResultPanelViewContainer", package.seeall)

local var_0_0 = class("SurvivalShelterResultPanelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalShelterResultPanelView.New()
	}
end

return var_0_0
