module("modules.logic.turnback.view.new.view.TurnbackNewShowRewardViewContainer", package.seeall)

local var_0_0 = class("TurnbackNewShowRewardViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TurnbackNewShowRewardView.New())

	return var_1_0
end

return var_0_0
