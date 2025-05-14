module("modules.logic.rouge.view.RougeOpenGuideViewContainer", package.seeall)

local var_0_0 = class("RougeOpenGuideViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RougeOpenGuideView.New())

	return var_1_0
end

return var_0_0
