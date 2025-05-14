module("modules.logic.bossrush.view.FightActionBarPopViewContainer", package.seeall)

local var_0_0 = class("FightActionBarPopViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightActionBarPopView.New()
	}
end

return var_0_0
