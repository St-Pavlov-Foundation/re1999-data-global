module("modules.logic.equip.view.EquipInfoTipsViewContainer", package.seeall)

local var_0_0 = class("EquipInfoTipsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.tipView = EquipInfoTipsView.New()

	return {
		arg_1_0.tipView
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return
end

function var_0_0.playCloseTransition(arg_3_0)
	arg_3_0:startViewCloseBlock()
	arg_3_0.tipView.animatorPlayer:Play(UIAnimationName.Close, arg_3_0.onPlayCloseTransitionFinish, arg_3_0)
	TaskDispatcher.runDelay(arg_3_0.onPlayCloseTransitionFinish, arg_3_0, 2)
end

return var_0_0
