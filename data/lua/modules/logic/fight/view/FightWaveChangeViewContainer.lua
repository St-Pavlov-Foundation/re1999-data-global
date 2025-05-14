module("modules.logic.fight.view.FightWaveChangeViewContainer", package.seeall)

local var_0_0 = class("FightWaveChangeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightWaveChangeView.New()
	}
end

return var_0_0
