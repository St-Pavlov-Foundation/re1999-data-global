module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickViewContainer", package.seeall)

local var_0_0 = class("SummonNewCustomPickViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, SummonNewCustomPickView.New())

	return var_1_0
end

return var_0_0
