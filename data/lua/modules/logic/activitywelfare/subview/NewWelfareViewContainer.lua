module("modules.logic.activitywelfare.subview.NewWelfareViewContainer", package.seeall)

local var_0_0 = class("NewWelfareViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, NewWelfareView.New())

	return var_1_0
end

return var_0_0
