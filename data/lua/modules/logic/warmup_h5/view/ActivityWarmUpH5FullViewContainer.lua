module("modules.logic.warmup_h5.view.ActivityWarmUpH5FullViewContainer", package.seeall)

local var_0_0 = class("ActivityWarmUpH5FullViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, ActivityWarmUpH5FullView.New())

	return var_1_0
end

function var_0_0.actId(arg_2_0)
	return arg_2_0.viewParam and arg_2_0.viewParam.actId or ActivityType100Config.instance:getWarmUpH5ActivityId()
end

function var_0_0.getH5BaseUrl(arg_3_0)
	return ActivityType100Config.instance:getWarmUpH5Link(arg_3_0:actId())
end

return var_0_0
