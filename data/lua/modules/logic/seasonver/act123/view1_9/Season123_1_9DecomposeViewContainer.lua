module("modules.logic.seasonver.act123.view1_9.Season123_1_9DecomposeViewContainer", package.seeall)

local var_0_0 = class("Season123_1_9DecomposeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		CommonViewFrame.New(),
		Season123_1_9DecomposeView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

return var_0_0
