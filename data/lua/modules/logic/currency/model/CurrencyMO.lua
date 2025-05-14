module("modules.logic.currency.model.CurrencyMO", package.seeall)

local var_0_0 = pureTable("CurrencyMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.currencyId = 0
	arg_1_0.quantity = 0
	arg_1_0.lastRecoverTime = 0
	arg_1_0.expiredTime = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.currencyId = arg_2_1.currencyId
	arg_2_0.quantity = arg_2_1.quantity
	arg_2_0.lastRecoverTime = arg_2_1.lastRecoverTime
	arg_2_0.expiredTime = arg_2_1.expiredTime
end

return var_0_0
