module("modules.logic.versionactivity2_7.act191.view.Act191CharacterTipViewContainer", package.seeall)

local var_0_0 = class("Act191CharacterTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Act191CharacterTipView.New())

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

return var_0_0
