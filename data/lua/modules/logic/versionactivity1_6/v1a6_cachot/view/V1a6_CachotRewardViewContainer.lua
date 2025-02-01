module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRewardViewContainer", package.seeall)

slot0 = class("V1a6_CachotRewardViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		V1a6_CachotRewardView.New(),
		V1a6_CachotCurrencyView.New(),
		V1a6_CachotRoomEventTipsView.New()
	}
end

return slot0
