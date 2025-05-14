module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEpisodeViewContainer", package.seeall)

local var_0_0 = class("V1a6_CachotEpisodeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		V1a6_CachotEpisodeView.New(),
		V1a6_CachotInteractView.New(),
		V1a6_CachotHeartView.New("top/#go_heart"),
		V1a6_CachotCurrencyView.New("top")
	}
end

return var_0_0
