module("modules.logic.sp01.odyssey.view.OdysseyMythSuccessViewContainer", package.seeall)

local var_0_0 = class("OdysseyMythSuccessViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, OdysseyMythSuccessView.New())

	return var_1_0
end

return var_0_0
