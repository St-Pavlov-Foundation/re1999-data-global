module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandResultViewContainer", package.seeall)

local var_0_0 = class("CooperGarlandResultViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, CooperGarlandResultView.New())

	return var_1_0
end

return var_0_0
