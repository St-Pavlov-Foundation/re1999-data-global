module("modules.logic.sp01.act208.view.V2a9_Act208MainViewContainer", package.seeall)

local var_0_0 = class("V2a9_Act208MainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, V2a9_Act208MainView.New())

	return var_1_0
end

return var_0_0
