module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaGameResultViewContainer", package.seeall)

local var_0_0 = class("JiaLaBoNaGameResultViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._resultview = JiaLaBoNaGameResultView.New()

	table.insert(var_1_0, arg_1_0._resultview)

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

return var_0_0
