module("modules.logic.sp01.act205.view.card.Act205CardShowViewContainer", package.seeall)

local var_0_0 = class("Act205CardShowViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Act205CardShowView.New())

	return var_1_0
end

return var_0_0
