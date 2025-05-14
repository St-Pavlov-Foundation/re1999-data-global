module("modules.logic.weekwalk.view.WeekWalkRuleViewContainer", package.seeall)

local var_0_0 = class("WeekWalkRuleViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		WeekWalkRuleView.New()
	}
end

return var_0_0
