module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTipsViewContainer", package.seeall)

slot0 = class("V1a6_CachotTipsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		V1a6_CachotTipsView.New()
	}
end

function slot0.playOpenTransition(slot0)
	slot0:onPlayOpenTransitionFinish()
end

return slot0
