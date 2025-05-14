module("modules.logic.fight.view.FightFailTipsViewContainer", package.seeall)

local var_0_0 = class("FightFailTipsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightFailTipsView.New()
	}
end

return var_0_0
