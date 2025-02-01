module("modules.logic.store.view.PackageStoreGoodsViewContainer", package.seeall)

slot0 = class("PackageStoreGoodsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "#go_topright"))
	table.insert(slot1, PackageStoreGoodsView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0._currencyView = CurrencyView.New({})
	slot2 = CurrencyEnum.CurrencyType

	slot0._currencyView:setCurrencyType({
		slot2.Diamond,
		slot2.FreeDiamondCoupon
	})

	return {
		slot0._currencyView
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
