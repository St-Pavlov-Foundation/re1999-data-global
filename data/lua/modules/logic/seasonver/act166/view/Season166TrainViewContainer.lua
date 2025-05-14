module("modules.logic.seasonver.act166.view.Season166TrainViewContainer", package.seeall)

local var_0_0 = class("Season166TrainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Season166TrainView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Season166TrainHelp)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.setOverrideCloseClick(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.navigateView:setOverrideClose(arg_3_1, arg_3_2)
end

return var_0_0
