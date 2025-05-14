module("modules.logic.tips.view.MaterialTipViewContainer", package.seeall)

local var_0_0 = class("MaterialTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		MaterialTipView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

return var_0_0
