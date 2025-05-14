module("modules.logic.seasonver.act123.view1_8.Season123_1_8DecomposeViewContainer", package.seeall)

local var_0_0 = class("Season123_1_8DecomposeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		CommonViewFrame.New(),
		Season123_1_8DecomposeView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

return var_0_0
