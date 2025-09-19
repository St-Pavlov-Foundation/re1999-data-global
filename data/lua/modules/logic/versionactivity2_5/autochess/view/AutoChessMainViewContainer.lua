module("modules.logic.versionactivity2_5.autochess.view.AutoChessMainViewContainer", package.seeall)

local var_0_0 = class("AutoChessMainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, AutoChessMainView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, 2807003)

		return {
			arg_2_0.navigateView
		}
	end
end

return var_0_0
