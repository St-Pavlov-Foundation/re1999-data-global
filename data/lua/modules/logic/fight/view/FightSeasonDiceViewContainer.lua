module("modules.logic.fight.view.FightSeasonDiceViewContainer", package.seeall)

local var_0_0 = class("FightSeasonDiceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightSeasonDiceView.New()
	}
end

return var_0_0
