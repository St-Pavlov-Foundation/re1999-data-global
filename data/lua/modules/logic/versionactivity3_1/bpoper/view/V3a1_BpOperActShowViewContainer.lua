module("modules.logic.versionactivity3_1.bpoper.view.V3a1_BpOperActShowViewContainer", package.seeall)

local var_0_0 = class("V3a1_BpOperActShowViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, V3a1_BpOperActShowView.New())

	return var_1_0
end

return var_0_0
