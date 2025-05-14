module("modules.logic.custompickchoice.view.CustomPickChoiceViewContainer", package.seeall)

local var_0_0 = class("CustomPickChoiceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, CustomPickChoiceView.New())

	return var_1_0
end

return var_0_0
