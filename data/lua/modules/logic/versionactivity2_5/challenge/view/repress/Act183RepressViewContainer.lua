module("modules.logic.versionactivity2_5.challenge.view.repress.Act183RepressViewContainer", package.seeall)

local var_0_0 = class("Act183RepressViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Act183RepressView.New())

	arg_1_0.helpView = HelpShowView.New()

	arg_1_0.helpView:setHelpId(HelpEnum.HelpId.Act183Repress)
	table.insert(var_1_0, arg_1_0.helpView)

	return var_1_0
end

return var_0_0
