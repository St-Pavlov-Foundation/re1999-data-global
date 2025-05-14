module("modules.logic.fight.view.FightFocusCameraAdjustViewContainer", package.seeall)

local var_0_0 = class("FightFocusCameraAdjustViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightFocusCameraAdjustView.New()
	}
end

return var_0_0
