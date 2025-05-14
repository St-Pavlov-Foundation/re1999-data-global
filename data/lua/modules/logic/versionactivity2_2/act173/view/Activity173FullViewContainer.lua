module("modules.logic.versionactivity2_2.act173.view.Activity173FullViewContainer", package.seeall)

local var_0_0 = class("Activity173FullViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Activity173FullView.New())

	return var_1_0
end

function var_0_0.playCloseTransition(arg_2_0)
	arg_2_0:startViewCloseBlock()
	SLFramework.AnimatorPlayer.Get(arg_2_0.viewGO):Play(UIAnimationName.Close, arg_2_0.onPlayCloseTransitionFinish, arg_2_0)
end

return var_0_0
