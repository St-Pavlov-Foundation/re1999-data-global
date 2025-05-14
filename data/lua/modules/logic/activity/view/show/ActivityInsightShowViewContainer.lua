module("modules.logic.activity.view.show.ActivityInsightShowViewContainer", package.seeall)

local var_0_0 = class("ActivityInsightShowViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, ActivityInsightShowView.New())

	return var_1_0
end

return var_0_0
