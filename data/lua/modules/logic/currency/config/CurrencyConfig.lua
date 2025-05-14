module("modules.logic.currency.config.CurrencyConfig", package.seeall)

local var_0_0 = class("CurrencyConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._currencyConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"currency"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "currency" then
		arg_3_0._currencyConfig = arg_3_2
	end
end

function var_0_0.getCurrencyCo(arg_4_0, arg_4_1)
	return arg_4_0._currencyConfig.configDict[arg_4_1]
end

function var_0_0.getAllCurrency(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0._currencyConfig.configDict) do
		table.insert(var_5_0, iter_5_0)
	end

	return var_5_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
