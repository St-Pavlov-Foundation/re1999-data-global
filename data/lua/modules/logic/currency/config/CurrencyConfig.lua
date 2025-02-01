module("modules.logic.currency.config.CurrencyConfig", package.seeall)

slot0 = class("CurrencyConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._currencyConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"currency"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "currency" then
		slot0._currencyConfig = slot2
	end
end

function slot0.getCurrencyCo(slot0, slot1)
	return slot0._currencyConfig.configDict[slot1]
end

function slot0.getAllCurrency(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._currencyConfig.configDict) do
		table.insert(slot1, slot5)
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
