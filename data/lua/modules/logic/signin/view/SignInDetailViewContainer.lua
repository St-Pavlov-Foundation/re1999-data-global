module("modules.logic.signin.view.SignInDetailViewContainer", package.seeall)

local var_0_0 = class("SignInDetailViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))
	table.insert(var_1_0, SignInDetailView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			false,
			false,
			false
		})

		var_2_0:setOverrideClose(arg_2_0.overrideOnCloseClick, arg_2_0)

		return {
			var_2_0
		}
	end
end

function var_0_0.overrideOnCloseClick(arg_3_0)
	SignInController.instance:dispatchEvent(SignInEvent.CloseSignInDetailView)
end

return var_0_0
