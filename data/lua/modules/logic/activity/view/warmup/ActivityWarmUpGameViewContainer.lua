module("modules.logic.activity.view.warmup.ActivityWarmUpGameViewContainer", package.seeall)

local var_0_0 = class("ActivityWarmUpGameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, ActivityWarmUpGameView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0.navigationView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		arg_2_0.navigationView
	}
end

return var_0_0
