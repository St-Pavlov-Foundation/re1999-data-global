module("modules.logic.summon.view.custompick.SummonCustomPickChoiceContainer", package.seeall)

local var_0_0 = class("SummonCustomPickChoiceContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SummonCustomPickChoice.New(),
		SummonCustomPickChoiceList.New()
	}
end

return var_0_0
