module("modules.logic.activity.view.chessmap.ActivityChessGameRewardViewContainer", package.seeall)

local var_0_0 = class("ActivityChessGameRewardViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, ActivityChessGameRewardView.New())

	return var_1_0
end

return var_0_0
