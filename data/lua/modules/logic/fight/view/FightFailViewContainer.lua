module("modules.logic.fight.view.FightFailViewContainer", package.seeall)

local var_0_0 = class("FightFailViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightFailView.New()
	}
end

return var_0_0
