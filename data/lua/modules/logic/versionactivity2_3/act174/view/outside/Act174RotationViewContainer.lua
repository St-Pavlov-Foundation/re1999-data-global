module("modules.logic.versionactivity2_3.act174.view.outside.Act174RotationViewContainer", package.seeall)

slot0 = class("Act174RotationViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0.view = Act174RotationView.New()
	slot1 = {}

	table.insert(slot1, slot0.view)
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0.navigateView
		}
	end
end

function slot0.playCloseTransition(slot0)
	slot0.view.anim:Play(UIAnimationName.Close)
	TaskDispatcher.runDelay(slot0.onPlayCloseTransitionFinish, slot0, 0.3)
end

return slot0
