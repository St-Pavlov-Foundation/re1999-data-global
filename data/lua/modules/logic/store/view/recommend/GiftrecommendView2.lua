module("modules.logic.store.view.recommend.GiftrecommendView2", package.seeall)

local var_0_0 = class("GiftrecommendView2", GiftrecommendViewBase)

function var_0_0.ctor(arg_1_0, ...)
	var_0_0.super.ctor(arg_1_0, ...)

	arg_1_0.config = StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.GiftrecommendView2)
end

return var_0_0
