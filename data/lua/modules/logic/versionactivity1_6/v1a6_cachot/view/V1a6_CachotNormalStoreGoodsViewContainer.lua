module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotNormalStoreGoodsViewContainer", package.seeall)

slot0 = class("V1a6_CachotNormalStoreGoodsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		V1a6_CachotNormalStoreGoodsView.New(),
		V1a6_CachotCurrencyView.New("top")
	}
end

return slot0
