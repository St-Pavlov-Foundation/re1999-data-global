module("modules.logic.versionactivity2_3.act174.view.outside.Act174RotationViewContainer", package.seeall)

local var_0_0 = class("Act174RotationViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.view = Act174RotationView.New()

	local var_1_0 = {}

	table.insert(var_1_0, arg_1_0.view)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.playCloseTransition(arg_3_0)
	arg_3_0.view.anim:Play(UIAnimationName.Close)
	TaskDispatcher.runDelay(arg_3_0.onPlayCloseTransitionFinish, arg_3_0, 0.3)
end

return var_0_0
