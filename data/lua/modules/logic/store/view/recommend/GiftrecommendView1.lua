module("modules.logic.store.view.recommend.GiftrecommendView1", package.seeall)

slot0 = class("GiftrecommendView1", GiftrecommendViewBase)

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)

	slot0.config = StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.GiftrecommendView1)
end

return slot0
