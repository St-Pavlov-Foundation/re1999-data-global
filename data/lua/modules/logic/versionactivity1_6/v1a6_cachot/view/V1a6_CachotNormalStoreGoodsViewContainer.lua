module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotNormalStoreGoodsViewContainer", package.seeall)

local var_0_0 = class("V1a6_CachotNormalStoreGoodsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		V1a6_CachotNormalStoreGoodsView.New(),
		V1a6_CachotCurrencyView.New("top")
	}
end

return var_0_0
