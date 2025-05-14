module("modules.logic.activity.view.warmup.ActivityWarmUpViewContainer", package.seeall)

local var_0_0 = class("ActivityWarmUpViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, ActivityWarmUpView.New())

	return var_1_0
end

return var_0_0
