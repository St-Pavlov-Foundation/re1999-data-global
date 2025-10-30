module("modules.logic.season.view3_0.Season3_0SumViewContainer", package.seeall)

local var_0_0 = class("Season3_0SumViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Season3_0SumView.New())

	return var_1_0
end

return var_0_0
