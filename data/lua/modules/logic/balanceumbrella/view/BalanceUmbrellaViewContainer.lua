module("modules.logic.balanceumbrella.view.BalanceUmbrellaViewContainer", package.seeall)

local var_0_0 = class("BalanceUmbrellaViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		BalanceUmbrellaView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		arg_2_0.navigateView
	}
end

return var_0_0
