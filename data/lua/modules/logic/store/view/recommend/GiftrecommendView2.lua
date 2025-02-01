module("modules.logic.store.view.recommend.GiftrecommendView2", package.seeall)

slot0 = class("GiftrecommendView2", GiftrecommendViewBase)

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)

	slot0.config = StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.GiftrecommendView2)
end

return slot0
