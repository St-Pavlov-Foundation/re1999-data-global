module("modules.logic.versionactivity2_1.activity165.view.Activity165StoryEditViewContainer", package.seeall)

local var_0_0 = class("Activity165StoryEditViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.editView = Activity165StoryEditView.New()

	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))
	table.insert(var_1_0, arg_1_0.editView)

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function var_0_0.playCloseTransition(arg_3_0)
	arg_3_0:startViewCloseBlock()
	arg_3_0.editView:playCloseAnim(arg_3_0.onPlayCloseTransitionFinish, arg_3_0)
end

return var_0_0
