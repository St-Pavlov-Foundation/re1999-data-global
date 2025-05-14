module("modules.ugui.icon.common.CommonHeroHelper", package.seeall)

local var_0_0 = class("CommonHeroHelper")

function var_0_0.setGrayState(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:_getGrayStateTab()[arg_1_1] = arg_1_2
end

function var_0_0.getGrayState(arg_2_0, arg_2_1)
	return arg_2_0:_getGrayStateTab()[arg_2_1]
end

function var_0_0._getGrayStateTab(arg_3_0)
	arg_3_0.grayTab = arg_3_0.grayTab or {}

	return arg_3_0.grayTab
end

function var_0_0.resetGrayState(arg_4_0)
	arg_4_0.grayTab = {}
end

var_0_0.instance = var_0_0.New()

return var_0_0
