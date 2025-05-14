module("modules.logic.fight.view.FightLoadingViewContainer", package.seeall)

local var_0_0 = class("FightLoadingViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightLoadingView.New()
	}
end

return var_0_0
