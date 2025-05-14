module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessMallLevelUpViewContainer", package.seeall)

local var_0_0 = class("AutoChessMallLevelUpViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, AutoChessMallLevelUpView.New())

	return var_1_0
end

return var_0_0
