module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessMallViewContainer", package.seeall)

local var_0_0 = class("AutoChessMallViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.mallView = AutoChessMallView.New()

	table.insert(var_1_0, arg_1_0.mallView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, 2807003)

		arg_2_0.navigateView:setOverrideClose(arg_2_0.mallView._overrideClose, arg_2_0.mallView)

		return {
			arg_2_0.navigateView
		}
	end
end

return var_0_0
