module("modules.logic.fight.view.FightCardDescViewContainer", package.seeall)

local var_0_0 = class("FightCardDescViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightCardDescView.New()
	}
end

return var_0_0
