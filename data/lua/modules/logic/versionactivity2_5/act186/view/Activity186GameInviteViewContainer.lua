module("modules.logic.versionactivity2_5.act186.view.Activity186GameInviteViewContainer", package.seeall)

local var_0_0 = class("Activity186GameInviteViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.heroView = Activity186GameHeroView.New()

	table.insert(var_1_0, arg_1_0.heroView)
	table.insert(var_1_0, Activity186GameInviteView.New())
	table.insert(var_1_0, Activity186GameDialogueView.New())

	return var_1_0
end

return var_0_0
