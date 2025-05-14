module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotResultViewContainer", package.seeall)

local var_0_0 = class("V1a6_CachotResultViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		V1a6_CachotResultView.New()
	}
end

function var_0_0.playCloseTransition(arg_2_0)
	SLFramework.AnimatorPlayer.Get(arg_2_0.viewGO):Play("close", arg_2_0.onCloseAnimDone, arg_2_0)
end

function var_0_0.onCloseAnimDone(arg_3_0)
	arg_3_0:onPlayCloseTransitionFinish()
end

return var_0_0
