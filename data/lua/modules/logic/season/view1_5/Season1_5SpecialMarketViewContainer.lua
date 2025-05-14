module("modules.logic.season.view1_5.Season1_5SpecialMarketViewContainer", package.seeall)

local var_0_0 = class("Season1_5SpecialMarketViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Season1_5SpecialMarketView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, arg_2_0._closeCallback, arg_2_0._homeCallback, nil, arg_2_0)

	return {
		arg_2_0._navigateButtonView
	}
end

function var_0_0._closeCallback(arg_3_0)
	arg_3_0:closeThis()
end

function var_0_0._homeCallback(arg_4_0)
	arg_4_0:closeThis()
end

return var_0_0
