module("modules.logic.summon.view.luckybag.SummonLuckyBagChoiceContainer", package.seeall)

local var_0_0 = class("SummonLuckyBagChoiceContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SummonLuckyBagChoice.New()
	}
end

return var_0_0
