module("modules.logic.versionactivity2_8.activity2nd.view.Activity2ndShowSkinViewContainer", package.seeall)

local var_0_0 = class("Activity2ndShowSkinViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Activity2ndShowSkinView.New())

	return var_1_0
end

return var_0_0
