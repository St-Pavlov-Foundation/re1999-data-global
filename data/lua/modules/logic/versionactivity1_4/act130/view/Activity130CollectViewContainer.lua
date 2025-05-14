module("modules.logic.versionactivity1_4.act130.view.Activity130CollectViewContainer", package.seeall)

local var_0_0 = class("Activity130CollectViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Activity130CollectView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		arg_2_0._navigateButtonView
	}
end

return var_0_0
