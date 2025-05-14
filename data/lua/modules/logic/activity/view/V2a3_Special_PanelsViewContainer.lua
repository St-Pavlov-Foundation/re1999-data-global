module("modules.logic.activity.view.V2a3_Special_PanelsViewContainer", package.seeall)

local var_0_0 = class("V2a3_Special_PanelsViewContainer", V2a3_Special_SignItemViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._view = V2a3_Special_PanelsView.New()

	table.insert(var_1_0, arg_1_0._view)

	return var_1_0
end

function var_0_0.view(arg_2_0)
	return arg_2_0._view
end

return var_0_0
