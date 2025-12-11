module("modules.logic.versionactivity2_7.act191.view.Act191CollectionChangeViewContainer", package.seeall)

local var_0_0 = class("Act191CollectionChangeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Act191CollectionChangeView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0)
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
