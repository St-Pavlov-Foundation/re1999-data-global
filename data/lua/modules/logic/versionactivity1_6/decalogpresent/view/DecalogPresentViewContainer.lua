module("modules.logic.versionactivity1_6.decalogpresent.view.DecalogPresentViewContainer", package.seeall)

local var_0_0 = class("DecalogPresentViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		DecalogPresentView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

return var_0_0
