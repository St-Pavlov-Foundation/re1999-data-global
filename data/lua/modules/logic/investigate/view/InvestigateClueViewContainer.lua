module("modules.logic.investigate.view.InvestigateClueViewContainer", package.seeall)

local var_0_0 = class("InvestigateClueViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		InvestigateClueView.New()
	}
end

return var_0_0
