module("modules.logic.rouge.map.view.store.RougeMapStoreViewContainer", package.seeall)

local var_0_0 = class("RougeMapStoreViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RougeMapStoreView.New())
	table.insert(var_1_0, RougeMapCoinView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0.navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	arg_2_0.navigateView:setOverrideClose(RougeMapHelper.backToMainScene)

	return {
		arg_2_0.navigateView
	}
end

return var_0_0
