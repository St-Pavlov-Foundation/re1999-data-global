module("modules.logic.weekwalk.view.WeekWalkLayerViewContainer", package.seeall)

local var_0_0 = class("WeekWalkLayerViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "top_left"))
	table.insert(var_1_0, WeekWalkLayerView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		true
	}, HelpEnum.HelpId.WeekWalk)

	return {
		arg_2_0._navigateButtonView
	}
end

function var_0_0.getNavBtnView(arg_3_0)
	return arg_3_0._navigateButtonView
end

return var_0_0
