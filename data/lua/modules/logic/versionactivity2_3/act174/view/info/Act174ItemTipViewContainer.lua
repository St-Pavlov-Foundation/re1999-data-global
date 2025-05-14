module("modules.logic.versionactivity2_3.act174.view.info.Act174ItemTipViewContainer", package.seeall)

local var_0_0 = class("Act174ItemTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.view = Act174ItemTipView.New()

	return {
		arg_1_0.view
	}
end

function var_0_0.playCloseTransition(arg_2_0)
	arg_2_0.view:playCloseAnim()
	TaskDispatcher.runDelay(arg_2_0.onPlayCloseTransitionFinish, arg_2_0, 0.2)
end

return var_0_0
