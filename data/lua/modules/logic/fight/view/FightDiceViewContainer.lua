module("modules.logic.fight.view.FightDiceViewContainer", package.seeall)

local var_0_0 = class("FightDiceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightDiceView.New()
	}
end

return var_0_0
