module("modules.logic.activity.view.V2a9_FreeMonthCard_FullViewContainer", package.seeall)

local var_0_0 = class("V2a9_FreeMonthCard_FullViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, V2a9_FreeMonthCard_FullView.New())

	return var_1_0
end

return var_0_0
