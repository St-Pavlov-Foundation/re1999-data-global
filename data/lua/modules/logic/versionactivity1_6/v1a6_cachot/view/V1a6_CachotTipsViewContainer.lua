module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTipsViewContainer", package.seeall)

local var_0_0 = class("V1a6_CachotTipsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		V1a6_CachotTipsView.New()
	}
end

function var_0_0.playOpenTransition(arg_2_0)
	arg_2_0:onPlayOpenTransitionFinish()
end

return var_0_0
