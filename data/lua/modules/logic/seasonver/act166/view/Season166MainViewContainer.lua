module("modules.logic.seasonver.act166.view.Season166MainViewContainer", package.seeall)

local var_0_0 = class("Season166MainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.Season166MainSceneView = Season166MainSceneView.New()

	table.insert(var_1_0, arg_1_0.Season166MainSceneView)
	table.insert(var_1_0, Season166MainView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		}, HelpEnum.HelpId.Season166TrainHelp)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.getMainSceneView(arg_3_0)
	return arg_3_0.Season166MainSceneView
end

function var_0_0.setOverrideCloseClick(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.navigateView:setOverrideClose(arg_4_1, arg_4_2)
end

function var_0_0.setHelpBtnShowState(arg_5_0, arg_5_1)
	arg_5_0.navigateView:setHelpVisible(arg_5_1)
end

return var_0_0
