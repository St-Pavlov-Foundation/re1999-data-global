module("modules.logic.playercard.view.PlayerCardLayoutViewContainer", package.seeall)

local var_0_0 = class("PlayerCardLayoutViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.layoutView = PlayerCardLayoutView.New()

	table.insert(var_1_0, arg_1_0.layoutView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_2_0.navigateView:setOverrideClose(arg_2_0._closeFunc, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0._closeFunc(arg_3_0)
	if arg_3_0.layoutView then
		arg_3_0.layoutView:playCloseAnim()
	end
end

return var_0_0
