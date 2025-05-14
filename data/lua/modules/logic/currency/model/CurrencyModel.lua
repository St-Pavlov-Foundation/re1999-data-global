module("modules.logic.currency.model.CurrencyModel", package.seeall)

local var_0_0 = class("CurrencyModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._currencyList = {}
	arg_1_0.powerCanBuyCount = 0
end

function var_0_0.getDiamond(arg_2_0)
	local var_2_0 = arg_2_0:getCurrency(CurrencyEnum.CurrencyType.Diamond)

	return var_2_0 and var_2_0.quantity or 0
end

function var_0_0.getFreeDiamond(arg_3_0)
	local var_3_0 = arg_3_0:getCurrency(CurrencyEnum.CurrencyType.FreeDiamondCoupon)

	return var_3_0 and var_3_0.quantity or 0
end

function var_0_0.getGold(arg_4_0)
	return arg_4_0:getCurrency(CurrencyEnum.CurrencyType.Gold).quantity or 0
end

function var_0_0.getPower(arg_5_0)
	return arg_5_0:getCurrency(CurrencyEnum.CurrencyType.Power).quantity or 0
end

function var_0_0.getCurrency(arg_6_0, arg_6_1)
	return arg_6_0._currencyList[arg_6_1]
end

function var_0_0.getCurrencyList(arg_7_0)
	return arg_7_0._currencyList
end

function var_0_0.setCurrencyList(arg_8_0, arg_8_1)
	arg_8_0:_receiveCurrencyList(arg_8_1)
end

function var_0_0.changeCurrencyList(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	arg_9_0:_receiveCurrencyList(arg_9_1)
end

function var_0_0._receiveCurrencyList(arg_10_0, arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		local var_10_1 = arg_10_0._currencyList[iter_10_1.currencyId] or CurrencyMO.New()

		var_10_1:init(iter_10_1)

		arg_10_0._currencyList[var_10_1.currencyId] = var_10_1
		var_10_0[iter_10_1.currencyId] = true
	end

	CurrencyController.instance:powerRecover()
	CurrencyController.instance:dispatchEvent(CurrencyEvent.CurrencyChange, var_10_0)
end

function var_0_0.reInit(arg_11_0)
	arg_11_0._currencyList = {}
	arg_11_0.powerCanBuyCount = 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
