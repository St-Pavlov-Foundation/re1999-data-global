module("modules.logic.activity.view.V2a9_FreeMonthCard_PanelViewContainer", package.seeall)

local var_0_0 = class("V2a9_FreeMonthCard_PanelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, V2a9_FreeMonthCard_PanelView.New())

	return var_1_0
end

return var_0_0
