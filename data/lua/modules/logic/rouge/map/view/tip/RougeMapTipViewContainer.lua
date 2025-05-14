module("modules.logic.rouge.map.view.tip.RougeMapTipViewContainer", package.seeall)

local var_0_0 = class("RougeMapTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RougeMapTipView.New())

	return var_1_0
end

return var_0_0
