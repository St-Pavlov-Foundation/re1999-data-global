module("modules.logic.fight.view.FightCardDeckViewContainer", package.seeall)

local var_0_0 = class("FightCardDeckViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightCardDeckView.New()
	}
end

return var_0_0
