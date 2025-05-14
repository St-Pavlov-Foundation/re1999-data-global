module("modules.logic.help.view.HelpViewContainer", package.seeall)

local var_0_0 = class("HelpViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		HelpView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0._navigateButtonsView = NavigateButtonsView.New({
		false,
		false,
		false
	})

	return {
		arg_2_0._navigateButtonsView
	}
end

function var_0_0.setBtnShow(arg_3_0, arg_3_1)
	if arg_3_0._navigateButtonsView then
		arg_3_0._navigateButtonsView:setParam({
			arg_3_1,
			false,
			false
		})
	end
end

return var_0_0
