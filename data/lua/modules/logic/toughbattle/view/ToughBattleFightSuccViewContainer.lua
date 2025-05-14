module("modules.logic.toughbattle.view.ToughBattleFightSuccViewContainer", package.seeall)

local var_0_0 = class("ToughBattleFightSuccViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		ToughBattleFightSuccView.New()
	}
end

return var_0_0
