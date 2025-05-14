module("modules.logic.toughbattle.view.ToughBattleLoadingViewContainer", package.seeall)

local var_0_0 = class("ToughBattleLoadingViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		ToughBattleLoadingView.New()
	}
end

return var_0_0
