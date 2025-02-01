module("modules.logic.currency.view.CurrencyExchangeViewContainer", package.seeall)

slot0 = class("CurrencyExchangeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		CurrencyExchangeView.New(),
		TabViewGroup.New(1, "#go_righttop")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return slot0:_buildCurrency()
	end
end

function slot0._buildCurrency(slot0)
	slot0._currencyView = CurrencyView.New({
		CurrencyEnum.CurrencyType.Diamond,
		CurrencyEnum.CurrencyType.FreeDiamondCoupon
	}, nil, , , true)

	return {
		slot0._currencyView
	}
end

return slot0
