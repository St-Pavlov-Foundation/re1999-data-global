module("modules.logic.explore.model.mo.ExploreInteractOptionMO", package.seeall)

local var_0_0 = class("ExploreInteractOptionMO")

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.optionTxt = arg_1_1
	arg_1_0.optionCallBack = arg_1_2
	arg_1_0.optionCallObj = arg_1_3
	arg_1_0.unit = arg_1_4
	arg_1_0.isClient = arg_1_5
end

return var_0_0
