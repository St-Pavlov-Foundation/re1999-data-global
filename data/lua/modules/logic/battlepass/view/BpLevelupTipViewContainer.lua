module("modules.logic.battlepass.view.BpLevelupTipViewContainer", package.seeall)

local var_0_0 = class("BpLevelupTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		BpLevelupTipView.New()
	}
end

return var_0_0
