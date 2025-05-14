module("modules.logic.seasonver.act123.view2_1.Season123_2_1DecomposeViewContainer", package.seeall)

local var_0_0 = class("Season123_2_1DecomposeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		CommonViewFrame.New(),
		Season123_2_1DecomposeView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

return var_0_0
