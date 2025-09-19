module("modules.logic.survival.view.shelter.SurvivalReportViewContainer", package.seeall)

local var_0_0 = class("SurvivalReportViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalReportView.New()
	}
end

return var_0_0
