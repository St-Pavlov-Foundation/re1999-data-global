module("modules.logic.chargepush.model.ChargePushMO", package.seeall)

local var_0_0 = pureTable("ChargePushMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.config = ChargePushConfig.instance:getPushGoodsConfig(arg_1_1)
end

function var_0_0.sortFunction(arg_2_0, arg_2_1)
	return arg_2_0.id < arg_2_1.id
end

return var_0_0
