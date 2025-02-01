module("modules.logic.versionactivity.view.VersionActivityNormalStoreGoodsViewContainer", package.seeall)

slot0 = class("VersionActivityNormalStoreGoodsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		TabViewGroup.New(1, "#go_topright"),
		VersionActivityNormalStoreGoodsView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot2 = CurrencyEnum.CurrencyType.LeiMiTeBei

	if slot0.viewParam then
		slot2 = string.splitToNumber(slot0.viewParam.cost, "#")[2]
	end

	return {
		CurrencyView.New({
			slot2
		})
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
