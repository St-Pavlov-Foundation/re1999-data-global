module("modules.logic.activity.view.V1a5_DoubleFestival_WishPanelContainer", package.seeall)

local var_0_0 = class("V1a5_DoubleFestival_WishPanelContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		V1a5_DoubleFestival_WishPanel.New()
	}
end

function var_0_0.playOpenTransition(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.ui_mail.play_ui_mail_open_1)
	arg_2_0:onPlayOpenTransitionFinish()
end

return var_0_0
