module("modules.logic.fight.view.FightCardDeckGMViewContainer", package.seeall)

local var_0_0 = class("FightCardDeckGMViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightCardDeckGMView.New()
	}
end

return var_0_0
