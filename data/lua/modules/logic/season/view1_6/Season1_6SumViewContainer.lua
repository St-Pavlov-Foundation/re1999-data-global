module("modules.logic.season.view1_6.Season1_6SumViewContainer", package.seeall)

local var_0_0 = class("Season1_6SumViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Season1_6SumView.New())

	return var_1_0
end

return var_0_0
