module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotResultViewContainer", package.seeall)

slot0 = class("V1a6_CachotResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		V1a6_CachotResultView.New()
	}
end

function slot0.playCloseTransition(slot0)
	SLFramework.AnimatorPlayer.Get(slot0.viewGO):Play("close", slot0.onCloseAnimDone, slot0)
end

function slot0.onCloseAnimDone(slot0)
	slot0:onPlayCloseTransitionFinish()
end

return slot0
