module("modules.logic.weekwalk_2.view.WeekWalk_2HeartResultViewContainer", package.seeall)

local var_0_0 = class("WeekWalk_2HeartResultViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, WeekWalk_2HeartResultView.New())

	return var_1_0
end

return var_0_0
