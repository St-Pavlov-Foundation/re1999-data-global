module("modules.logic.pay.model.PayModel_NativesImpl", package.seeall)

local var_0_0 = LuaUtil.class("PayModel_NativesImpl", PayModelBase)

function var_0_0.ctor(arg_1_0)
	assert(false, "PayModel_NativesImpl is an abstract class, please use PayModel instead.")
end

function var_0_0.getProductPrice(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:getProductOriginPriceSymbol(arg_2_1)
	local var_2_1 = arg_2_0:getProductOriginPriceNum(arg_2_1)

	return string.format("%s%s", var_2_0, var_2_1)
end

function var_0_0.getProductOriginPriceNum(arg_3_0, arg_3_1)
	local var_3_0 = 0
	local var_3_1 = StoreConfig.instance:getChargeGoodsConfig(arg_3_1)

	if var_3_1 then
		var_3_0 = var_3_1.price
	end

	local var_3_2 = arg_3_0:getProductOriginCurrency(arg_3_1)
	local var_3_3 = arg_3_0:isNoDecimalsCurrency(var_3_2)
	local var_3_4

	if var_3_3 then
		var_3_4 = math.floor(var_3_0)
	else
		var_3_4 = tostring(var_3_0)
	end

	return var_3_0, var_3_4, var_3_3
end

function var_0_0.getProductOriginCurrency(arg_4_0, arg_4_1)
	return PayEnum.CurrencyCode.CNY
end

function var_0_0.getProductOriginPriceSymbol(arg_5_0, arg_5_1)
	return "¥"
end

return var_0_0
