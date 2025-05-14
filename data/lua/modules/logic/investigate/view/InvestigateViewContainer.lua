module("modules.logic.investigate.view.InvestigateViewContainer", package.seeall)

local var_0_0 = class("InvestigateViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		InvestigateView.New(),
		TabViewGroup.New(1, "root/#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0.navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		arg_2_0.navigateView
	}
end

return var_0_0
