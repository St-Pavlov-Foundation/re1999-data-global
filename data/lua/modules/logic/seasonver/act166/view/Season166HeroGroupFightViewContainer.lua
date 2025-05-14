module("modules.logic.seasonver.act166.view.Season166HeroGroupFightViewContainer", package.seeall)

local var_0_0 = class("Season166HeroGroupFightViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season166HeroGroupFightLayoutView.New(),
		Season166HeroGroupFightView.New(),
		Season166HeroGroupListView.New(),
		Season166HeroGroupFightViewRule.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		}, nil, arg_2_0._closeCallback, nil, nil, arg_2_0)

		return {
			arg_2_0._navigateButtonsView
		}
	end
end

function var_0_0._closeCallback(arg_3_0)
	arg_3_0:closeThis()

	if arg_3_0:handleVersionActivityCloseCall() then
		return
	end

	MainController.instance:enterMainScene(true, false)
end

function var_0_0.handleVersionActivityCloseCall(arg_4_0)
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

return var_0_0
