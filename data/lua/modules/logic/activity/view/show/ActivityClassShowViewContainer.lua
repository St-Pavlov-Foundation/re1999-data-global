module("modules.logic.activity.view.show.ActivityClassShowViewContainer", package.seeall)

local var_0_0 = class("ActivityClassShowViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, ActivityClassShowView.New())

	return var_1_0
end

return var_0_0
