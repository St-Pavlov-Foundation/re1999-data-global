module("modules.logic.survival.view.shelter.SurvivalMonsterEventViewContainer", package.seeall)

local var_0_0 = class("SurvivalMonsterEventViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalMonsterEventView.New()
	}
end

return var_0_0
