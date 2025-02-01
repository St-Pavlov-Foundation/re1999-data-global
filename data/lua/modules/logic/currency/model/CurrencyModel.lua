module("modules.logic.currency.model.CurrencyModel", package.seeall)

slot0 = class("CurrencyModel", BaseModel)

function slot0.onInit(slot0)
	slot0._currencyList = {}
	slot0.powerCanBuyCount = 0
end

function slot0.getDiamond(slot0)
	return slot0:getCurrency(CurrencyEnum.CurrencyType.Diamond) and slot1.quantity or 0
end

function slot0.getFreeDiamond(slot0)
	return slot0:getCurrency(CurrencyEnum.CurrencyType.FreeDiamondCoupon) and slot1.quantity or 0
end

function slot0.getGold(slot0)
	return slot0:getCurrency(CurrencyEnum.CurrencyType.Gold).quantity or 0
end

function slot0.getPower(slot0)
	return slot0:getCurrency(CurrencyEnum.CurrencyType.Power).quantity or 0
end

function slot0.getCurrency(slot0, slot1)
	return slot0._currencyList[slot1]
end

function slot0.getCurrencyList(slot0)
	return slot0._currencyList
end

function slot0.setCurrencyList(slot0, slot1)
	slot0:_receiveCurrencyList(slot1)
end

function slot0.changeCurrencyList(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:_receiveCurrencyList(slot1)
end

function slot0._receiveCurrencyList(slot0, slot1)
	for slot6, slot7 in ipairs(slot1) do
		slot8 = slot0._currencyList[slot7.currencyId] or CurrencyMO.New()

		slot8:init(slot7)

		slot0._currencyList[slot8.currencyId] = slot8
	end

	CurrencyController.instance:powerRecover()
	CurrencyController.instance:dispatchEvent(CurrencyEvent.CurrencyChange, {
		[slot7.currencyId] = true
	})
end

function slot0.reInit(slot0)
	slot0._currencyList = {}
	slot0.powerCanBuyCount = 0
end

slot0.instance = slot0.New()

return slot0
