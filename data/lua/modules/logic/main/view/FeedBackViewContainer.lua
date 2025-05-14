module("modules.logic.main.view.FeedBackViewContainer", package.seeall)

local var_0_0 = class("FeedBackViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FeedBackView.New(),
		TabViewGroup.New(1, "browser")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0.navigationView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		arg_2_0.navigationView
	}
end

function var_0_0.onContainerOpenFinish(arg_3_0)
	arg_3_0.navigationView:resetCloseBtnAudioId(AudioEnum.UI.play_ui_feedback_close)
end

return var_0_0
