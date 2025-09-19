module("modules.logic.survival.view.map.SurvivalNPCSelectViewContainer", package.seeall)

local var_0_0 = class("SurvivalNPCSelectViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalNPCSelectView.New()
	}
end

return var_0_0
