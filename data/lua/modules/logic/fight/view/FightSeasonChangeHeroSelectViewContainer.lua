module("modules.logic.fight.view.FightSeasonChangeHeroSelectViewContainer", package.seeall)

local var_0_0 = class("FightSeasonChangeHeroSelectViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightSeasonChangeHeroSelectView.New()
	}
end

return var_0_0
