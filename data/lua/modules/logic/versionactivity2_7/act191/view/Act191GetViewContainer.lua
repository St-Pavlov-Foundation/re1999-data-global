module("modules.logic.versionactivity2_7.act191.view.Act191GetViewContainer", package.seeall)

local var_0_0 = class("Act191GetViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Act191GetView.New())

	return var_1_0
end

return var_0_0
