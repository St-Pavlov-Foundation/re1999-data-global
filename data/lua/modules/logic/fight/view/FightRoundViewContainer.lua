module("modules.logic.fight.view.FightRoundViewContainer", package.seeall)

local var_0_0 = class("FightRoundViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightRoundView.New()
	}
end

return var_0_0
