module("modules.logic.versionactivity2_5.autochess.view.AutoChessLeaderNextViewContainer", package.seeall)

local var_0_0 = class("AutoChessLeaderNextViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, AutoChessLeaderNextView.New())

	return var_1_0
end

return var_0_0
