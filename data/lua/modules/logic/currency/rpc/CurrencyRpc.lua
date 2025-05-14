module("modules.logic.currency.rpc.CurrencyRpc", package.seeall)

local var_0_0 = class("CurrencyRpc", BaseRpc)

function var_0_0.sendGetAllCurrency(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = CurrencyConfig.instance:getAllCurrency()

	return arg_1_0:sendGetCurrencyListRequest(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.sendGetCurrencyListRequest(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = CurrencyModule_pb.GetCurrencyListRequest()

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		table.insert(var_2_0.currencyIds, iter_2_1)
	end

	return arg_2_0:sendMsg(var_2_0, arg_2_2, arg_2_3)
end

function var_0_0.onReceiveGetCurrencyListReply(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 ~= 0 then
		return
	end

	CurrencyModel.instance:setCurrencyList(arg_3_2.currencyList)
	CurrencyController.instance:dispatchEvent(CurrencyEvent.GetCurrencyInfoSuccess)
end

function var_0_0.onReceiveCurrencyChangePush(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	CurrencyModel.instance:changeCurrencyList(arg_4_2.changeCurrency)
end

function var_0_0.sendGetBuyPowerInfoRequest(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = CurrencyModule_pb.GetBuyPowerInfoRequest()

	return arg_5_0:sendMsg(var_5_0, arg_5_1, arg_5_2)
end

function var_0_0.onReceiveGetBuyPowerInfoReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	local var_6_0 = arg_6_2.canBuyCount

	CurrencyModel.instance.powerCanBuyCount = var_6_0

	CurrencyController.instance:dispatchEvent(CurrencyEvent.PowerBuyCountChange)
end

function var_0_0.sendBuyPowerRequest(arg_7_0)
	local var_7_0 = CurrencyModule_pb.BuyPowerRequest()

	arg_7_0:sendMsg(var_7_0)
end

function var_0_0.onReceiveBuyPowerReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	local var_8_0 = arg_8_2.canBuyCount

	CurrencyModel.instance.powerCanBuyCount = var_8_0

	SDKChannelEventModel.instance:firstBuyPower()
	CurrencyController.instance:dispatchEvent(CurrencyEvent.PowerBuyCountChange)
end

function var_0_0.sendExchangeDiamondRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = CurrencyModule_pb.ExchangeDiamondRequest()

	var_9_0.exchangeDiamond = arg_9_1
	var_9_0.opType = arg_9_2

	arg_9_0:sendMsg(var_9_0, arg_9_3, arg_9_4)
end

function var_0_0.onReceiveExchangeDiamondReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end

	SDKChannelEventModel.instance:firstExchangeDiamond()
	GameFacade.showToast(ToastEnum.ExchangeDiamond)

	if arg_10_2.opType == CurrencyEnum.PayDiamondExchangeSource.SkinStore then
		StoreController.instance:recordExchangeSkinDiamond(arg_10_2.exchangeDiamond)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
