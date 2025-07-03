module("modules.logic.tips.view.FightBloodPoolTipViewContainer", package.seeall)

local var_0_0 = class("FightBloodPoolTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightBloodPoolTipView.New()
	}
end

return var_0_0
