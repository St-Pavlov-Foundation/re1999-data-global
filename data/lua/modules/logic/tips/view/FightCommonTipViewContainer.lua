module("modules.logic.tips.view.FightCommonTipViewContainer", package.seeall)

local var_0_0 = class("FightCommonTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightCommonTipView.New()
	}
end

return var_0_0
