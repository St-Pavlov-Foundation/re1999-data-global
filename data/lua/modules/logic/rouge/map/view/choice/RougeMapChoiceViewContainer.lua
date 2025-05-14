module("modules.logic.rouge.map.view.choice.RougeMapChoiceViewContainer", package.seeall)

local var_0_0 = class("RougeMapChoiceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RougeMapChoiceView.New())
	table.insert(var_1_0, RougeMapChoiceTipView.New())
	table.insert(var_1_0, RougeMapEntrustView.New())
	table.insert(var_1_0, RougeMapCoinView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
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
