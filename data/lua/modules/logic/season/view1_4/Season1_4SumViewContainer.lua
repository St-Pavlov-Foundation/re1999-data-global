module("modules.logic.season.view1_4.Season1_4SumViewContainer", package.seeall)

local var_0_0 = class("Season1_4SumViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Season1_4SumView.New())

	return var_1_0
end

return var_0_0
