module("modules.logic.turnback.view.new.view.TurnbackReviewViewContainer", package.seeall)

local var_0_0 = class("TurnbackReviewViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TurnbackReviewView.New())

	return var_1_0
end

return var_0_0
