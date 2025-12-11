module("modules.logic.survival.view.map.SurvivalCommonTipsViewContainer", package.seeall)

local var_0_0 = class("SurvivalCommonTipsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalCommonTipsView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0
