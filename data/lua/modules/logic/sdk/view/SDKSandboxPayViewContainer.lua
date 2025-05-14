module("modules.logic.sdk.view.SDKSandboxPayViewContainer", package.seeall)

local var_0_0 = class("SDKSandboxPayViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, SDKSandboxPayView.New())

	return var_1_0
end

return var_0_0
