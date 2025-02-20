module("modules.logic.versionactivity2_3.act174.view.info.Act174ItemTipViewContainer", package.seeall)

slot0 = class("Act174ItemTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0.view = Act174ItemTipView.New()

	return {
		slot0.view
	}
end

function slot0.playCloseTransition(slot0)
	slot0.view:playCloseAnim()
	TaskDispatcher.runDelay(slot0.onPlayCloseTransitionFinish, slot0, 0.2)
end

return slot0
