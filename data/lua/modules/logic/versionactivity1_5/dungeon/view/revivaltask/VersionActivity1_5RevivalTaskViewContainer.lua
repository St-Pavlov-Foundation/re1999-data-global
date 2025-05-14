module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5RevivalTaskViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_5RevivalTaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.exploreTipView = VersionActivity1_5ExploreTaskTipView.New()

	return {
		VersionActivity1_5RevivalTaskView.New(),
		VersionActivity1_5ExploreTaskView.New(),
		VersionActivity1_5HeroTaskView.New(),
		VersionActivity1_5RevivalTaskTipView.New(),
		arg_1_0.exploreTipView,
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0._navigateButtonsView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	arg_2_0._navigateButtonsView:setHelpId(HelpEnum.HelpId.Dungeon1_5TaskHelp)

	return {
		arg_2_0._navigateButtonsView
	}
end

function var_0_0.onContainerInit(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_paiqian_open)
end

return var_0_0
