module("modules.logic.store.view.StoreSkinGoodsViewContainer", package.seeall)

slot0 = class("StoreSkinGoodsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "#go_topright"))
	table.insert(slot1, StoreSkinGoodsView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0._currencyView = CurrencyView.New({})

	return {
		slot0._currencyView
	}
end

function slot0.setCurrencyType(slot0, slot1)
	if slot0._currencyView then
		slot0._currencyView:setCurrencyType(slot1)
	end
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
