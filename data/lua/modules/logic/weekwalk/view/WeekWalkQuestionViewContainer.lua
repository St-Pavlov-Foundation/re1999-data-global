﻿module("modules.logic.weekwalk.view.WeekWalkQuestionViewContainer", package.seeall)

local var_0_0 = class("WeekWalkQuestionViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, WeekWalkQuestionView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "top_left"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		arg_2_0._navigateButtonView
	}
end

function var_0_0.onContainerOpenFinish(arg_3_0)
	arg_3_0._navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_Universal_Click)
end

return var_0_0
