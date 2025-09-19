module("modules.logic.survival.view.shelter.SurvivalBossInvadeViewContainer", package.seeall)

local var_0_0 = class("SurvivalBossInvadeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalBossInvadeView.New()
	}
end

return var_0_0
