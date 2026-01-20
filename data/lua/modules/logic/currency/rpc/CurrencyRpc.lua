-- chunkname: @modules/logic/currency/rpc/CurrencyRpc.lua

module("modules.logic.currency.rpc.CurrencyRpc", package.seeall)

local CurrencyRpc = class("CurrencyRpc", BaseRpc)

function CurrencyRpc:sendGetAllCurrency(callback, callbackObj)
	local allCurrency = CurrencyConfig.instance:getAllCurrency()

	return self:sendGetCurrencyListRequest(allCurrency, callback, callbackObj)
end

function CurrencyRpc:sendGetCurrencyListRequest(currencyId, callback, callbackObj)
	local req = CurrencyModule_pb.GetCurrencyListRequest()

	for i, v in ipairs(currencyId) do
		table.insert(req.currencyIds, v)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function CurrencyRpc:onReceiveGetCurrencyListReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CurrencyModel.instance:setCurrencyList(msg.currencyList)
	CurrencyController.instance:dispatchEvent(CurrencyEvent.GetCurrencyInfoSuccess)
end

function CurrencyRpc:onReceiveCurrencyChangePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CurrencyModel.instance:changeCurrencyList(msg.changeCurrency)
end

function CurrencyRpc:sendGetBuyPowerInfoRequest(callback, callbackObj)
	local req = CurrencyModule_pb.GetBuyPowerInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function CurrencyRpc:onReceiveGetBuyPowerInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local canBuyCount = msg.canBuyCount

	CurrencyModel.instance.powerCanBuyCount = canBuyCount

	CurrencyController.instance:dispatchEvent(CurrencyEvent.PowerBuyCountChange, false)
end

function CurrencyRpc:sendBuyPowerRequest()
	local req = CurrencyModule_pb.BuyPowerRequest()

	self:sendMsg(req)
end

function CurrencyRpc:onReceiveBuyPowerReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local canBuyCount = msg.canBuyCount

	CurrencyModel.instance.powerCanBuyCount = canBuyCount

	SDKChannelEventModel.instance:firstBuyPower()
	CurrencyController.instance:dispatchEvent(CurrencyEvent.PowerBuyCountChange, true)
end

function CurrencyRpc:sendExchangeDiamondRequest(quantity, sourceType, callback, callbackObj)
	local req = CurrencyModule_pb.ExchangeDiamondRequest()

	req.exchangeDiamond = quantity
	req.opType = sourceType

	self:sendMsg(req, callback, callbackObj)
end

function CurrencyRpc:onReceiveExchangeDiamondReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	SDKChannelEventModel.instance:firstExchangeDiamond()

	local sourceType = msg.opType

	if sourceType == CurrencyEnum.PayDiamondExchangeSource.Summon then
		return
	end

	GameFacade.showToast(ToastEnum.ExchangeDiamond)

	if sourceType == CurrencyEnum.PayDiamondExchangeSource.SkinStore then
		StoreController.instance:recordExchangeSkinDiamond(msg.exchangeDiamond)
	end
end

CurrencyRpc.instance = CurrencyRpc.New()

return CurrencyRpc
