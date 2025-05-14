module("modules.logic.advance.view.testtask.TestTaskViewContainer", package.seeall)

local var_0_0 = class("TestTaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TestTaskView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

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
