module("modules.logic.fight.view.FightQuitTipViewContainer", package.seeall)

local var_0_0 = class("FightQuitTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightQuitTipView.New(),
		Season166FightQuitTipView.New()
	}
end

return var_0_0
