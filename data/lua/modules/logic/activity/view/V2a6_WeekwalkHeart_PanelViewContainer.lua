module("modules.logic.activity.view.V2a6_WeekwalkHeart_PanelViewContainer", package.seeall)

local var_0_0 = class("V2a6_WeekwalkHeart_PanelViewContainer", Activity189BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, V2a6_WeekwalkHeart_PanelView.New())

	return var_1_0
end

function var_0_0.actId(arg_2_0)
	return ActivityEnum.Activity.V2a6_WeekwalkHeart
end

return var_0_0
