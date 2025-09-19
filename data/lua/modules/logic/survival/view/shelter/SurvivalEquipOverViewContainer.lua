module("modules.logic.survival.view.shelter.SurvivalEquipOverViewContainer", package.seeall)

local var_0_0 = class("SurvivalEquipOverViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalEquipOverView.New()
	}
end

return var_0_0
