module("modules.logic.fight.view.FightBuffTipsViewContainer", package.seeall)

local var_0_0 = class("FightBuffTipsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightBuffTipsView.New()
	}
end

return var_0_0
