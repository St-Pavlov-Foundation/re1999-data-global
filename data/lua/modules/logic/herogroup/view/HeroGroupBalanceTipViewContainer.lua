module("modules.logic.herogroup.view.HeroGroupBalanceTipViewContainer", package.seeall)

local var_0_0 = class("HeroGroupBalanceTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		HeroGroupBalanceTipView.New()
	}
end

return var_0_0
