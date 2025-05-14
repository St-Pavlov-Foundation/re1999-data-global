module("modules.logic.fight.view.FightTechniqueTipsViewContainer", package.seeall)

local var_0_0 = class("FightTechniqueTipsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightTechniqueTipsView.New()
	}
end

return var_0_0
