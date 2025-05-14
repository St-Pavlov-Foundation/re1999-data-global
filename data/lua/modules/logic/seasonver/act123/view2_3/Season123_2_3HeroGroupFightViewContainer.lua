module("modules.logic.seasonver.act123.view2_3.Season123_2_3HeroGroupFightViewContainer", package.seeall)

local var_0_0 = class("Season123_2_3HeroGroupFightViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season123_2_3HeroGroupFightView.New(),
		Season123_2_3HeroGroupListView.New(),
		Season123_2_3HeroGroupFightViewRule.New(),
		Season123_2_3HeroGroupMainCardView.New(),
		Season123_2_3HeroGroupReplaySelectView.New(),
		TabViewGroup.New(1, "#go_container/#go_btns/commonBtns")
	}
end

function var_0_0.getSeasonHeroGroupFightView(arg_2_0)
	return arg_2_0._views[1]
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.Season2_3HerogroupHelp, arg_3_0._closeCallback, nil, nil, arg_3_0)

		arg_3_0._navigateButtonsView:setHelpId(HelpEnum.HelpId.Season2_3HerogroupHelp)
		arg_3_0._navigateButtonsView:setCloseCheck(arg_3_0.defaultOverrideCloseCheck, arg_3_0)

		return {
			arg_3_0._navigateButtonsView
		}
	end
end

function var_0_0._closeCallback(arg_4_0)
	arg_4_0:closeThis()

	if arg_4_0:handleVersionActivityCloseCall() then
		return
	end

	MainController.instance:enterMainScene(true, false)
end

function var_0_0.handleVersionActivityCloseCall(arg_5_0)
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

return var_0_0
