module("modules.logic.season.view.SeasonRetailLevelInfoViewContainer", package.seeall)

local var_0_0 = class("SeasonRetailLevelInfoViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, SeasonRetailLevelInfoView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
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

function var_0_0.playOpenTransition(arg_5_0, arg_5_1)
	arg_5_1 = arg_5_1 or {}
	arg_5_1.duration = 0

	var_0_0.super.playOpenTransition(arg_5_0, arg_5_1)
end

return var_0_0
