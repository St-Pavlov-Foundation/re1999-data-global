module("modules.logic.clickuiswitch.view.ClickUISwitchInfoViewContainer", package.seeall)

local var_0_0 = class("ClickUISwitchInfoViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, ClickUISwitchInfoView.New())

	return var_1_0
end

return var_0_0
