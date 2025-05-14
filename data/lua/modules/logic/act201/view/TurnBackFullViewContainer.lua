module("modules.logic.act201.view.TurnBackFullViewContainer", package.seeall)

local var_0_0 = class("TurnBackFullViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TurnBackFullView.New())

	return var_1_0
end

return var_0_0
