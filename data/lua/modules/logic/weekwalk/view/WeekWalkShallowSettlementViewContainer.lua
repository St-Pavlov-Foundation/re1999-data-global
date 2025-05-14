module("modules.logic.weekwalk.view.WeekWalkShallowSettlementViewContainer", package.seeall)

local var_0_0 = class("WeekWalkShallowSettlementViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		WeekWalkShallowSettlementView.New()
	}
end

return var_0_0
