module("modules.logic.currency.model.CurrencyMO", package.seeall)

slot0 = pureTable("CurrencyMO")

function slot0.ctor(slot0)
	slot0.currencyId = 0
	slot0.quantity = 0
	slot0.lastRecoverTime = 0
	slot0.expiredTime = 0
end

function slot0.init(slot0, slot1)
	slot0.currencyId = slot1.currencyId
	slot0.quantity = slot1.quantity
	slot0.lastRecoverTime = slot1.lastRecoverTime
	slot0.expiredTime = slot1.expiredTime
end

return slot0
