module("modules.logic.toughbattle.view.ToughBattleEnterViewContainer", package.seeall)

local var_0_0 = class("ToughBattleEnterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		ToughBattleEnterView.New(),
		TabViewGroup.New(1, "root/#go_btns"),
		ToughBattleWordView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0.navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		arg_2_0.navigateView
	}
end

return var_0_0
