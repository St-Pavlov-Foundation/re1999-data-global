module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickChoiceViewContainer", package.seeall)

local var_0_0 = class("SummonNewCustomPickChoiceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, SummonNewCustomPickChoiceView.New())
	table.insert(var_1_0, SummonNewCustomPickChoiceViewList.New())

	return var_1_0
end

return var_0_0
