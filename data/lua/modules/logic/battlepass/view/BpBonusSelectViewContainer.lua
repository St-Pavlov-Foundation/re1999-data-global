module("modules.logic.battlepass.view.BpBonusSelectViewContainer", package.seeall)

local var_0_0 = class("BpBonusSelectViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		BpBonusSelectView.New()
	}
end

return var_0_0
