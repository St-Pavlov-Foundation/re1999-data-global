module("modules.logic.currency.rpc.CurrencyRpc", package.seeall)

slot0 = class("CurrencyRpc", BaseRpc)

function slot0.sendGetAllCurrency(slot0, slot1, slot2)
	return slot0:sendGetCurrencyListRequest(CurrencyConfig.instance:getAllCurrency(), slot1, slot2)
end

function slot0.sendGetCurrencyListRequest(slot0, slot1, slot2, slot3)
	slot4 = CurrencyModule_pb.GetCurrencyListRequest()

	for slot8, slot9 in ipairs(slot1) do
		table.insert(slot4.currencyIds, slot9)
	end

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetCurrencyListReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	CurrencyModel.instance:setCurrencyList(slot2.currencyList)
	CurrencyController.instance:dispatchEvent(CurrencyEvent.GetCurrencyInfoSuccess)
end

function slot0.onReceiveCurrencyChangePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	CurrencyModel.instance:changeCurrencyList(slot2.changeCurrency)
end

function slot0.sendGetBuyPowerInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(CurrencyModule_pb.GetBuyPowerInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetBuyPowerInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	CurrencyModel.instance.powerCanBuyCount = slot2.canBuyCount

	CurrencyController.instance:dispatchEvent(CurrencyEvent.PowerBuyCountChange)
end

function slot0.sendBuyPowerRequest(slot0)
	slot0:sendMsg(CurrencyModule_pb.BuyPowerRequest())
end

function slot0.onReceiveBuyPowerReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	CurrencyModel.instance.powerCanBuyCount = slot2.canBuyCount

	SDKChannelEventModel.instance:firstBuyPower()
	CurrencyController.instance:dispatchEvent(CurrencyEvent.PowerBuyCountChange)
end

function slot0.sendExchangeDiamondRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = CurrencyModule_pb.ExchangeDiamondRequest()
	slot5.exchangeDiamond = slot1
	slot5.opType = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveExchangeDiamondReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	SDKChannelEventModel.instance:firstExchangeDiamond()
	GameFacade.showToast(ToastEnum.ExchangeDiamond)

	if slot2.opType == CurrencyEnum.PayDiamondExchangeSource.SkinStore then
		StoreController.instance:recordExchangeSkinDiamond(slot2.exchangeDiamond)
	end
end

slot0.instance = slot0.New()

return slot0
