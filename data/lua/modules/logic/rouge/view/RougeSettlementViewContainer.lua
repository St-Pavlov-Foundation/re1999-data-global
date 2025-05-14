module("modules.logic.rouge.view.RougeSettlementViewContainer", package.seeall)

local var_0_0 = class("RougeSettlementViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RougeSettlementView.New())

	return var_1_0
end

return var_0_0
