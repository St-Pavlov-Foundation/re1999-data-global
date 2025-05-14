module("modules.logic.versionactivity2_5.autochess.view.AutoChessRankUpViewContainer", package.seeall)

local var_0_0 = class("AutoChessRankUpViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, AutoChessRankUpView.New())

	return var_1_0
end

return var_0_0
