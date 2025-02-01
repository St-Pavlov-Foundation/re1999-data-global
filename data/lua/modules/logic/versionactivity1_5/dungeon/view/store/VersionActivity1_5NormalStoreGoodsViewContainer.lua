module("modules.logic.versionactivity1_5.dungeon.view.store.VersionActivity1_5NormalStoreGoodsViewContainer", package.seeall)

slot0 = class("VersionActivity1_5NormalStoreGoodsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		TabViewGroup.New(1, "#go_topright"),
		VersionActivity1_5NormalStoreGoodsView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot2 = CurrencyEnum.CurrencyType.LeiMiTeBei

	if slot0.viewParam then
		slot2 = string.splitToNumber(slot0.viewParam.cost, "#")[2]
	end

	slot0._currencyView = CurrencyView.New({
		slot2
	})

	slot0._currencyView:setOpenCallback(slot0._onCurrencyOpen, slot0)

	return {
		slot0._currencyView
	}
end

function slot0._onCurrencyOpen(slot0)
	slot1 = slot0._currencyView:getCurrencyItem(1)

	gohelper.setActive(slot1.btn, false)
	gohelper.setActive(slot1.click, true)
	recthelper.setAnchorX(slot1.txt.transform, 313)
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
