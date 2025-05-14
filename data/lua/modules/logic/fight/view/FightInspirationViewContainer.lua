module("modules.logic.fight.view.FightInspirationViewContainer", package.seeall)

local var_0_0 = class("FightInspirationViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightInspirationView.New()
	}
end

return var_0_0
