module("modules.logic.versionactivity1_2.trade.view.ActivityTradeSuccessViewContainer", package.seeall)

local var_0_0 = class("ActivityTradeSuccessViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, ActivityTradeSuccessView.New())

	return var_1_0
end

return var_0_0
