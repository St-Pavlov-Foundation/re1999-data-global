module("modules.logic.seasonver.act123.view2_0.Season123_2_0StoryViewContainer", package.seeall)

slot0 = class("Season123_2_0StoryViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123_2_0StoryView.New(),
		TabViewGroup.New(1, "#go_LeftTop")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		slot0._navigateButtonView:setOverrideClose(slot0._overrideCloseFunc, slot0)

		return {
			slot0._navigateButtonView
		}
	end
end

function slot0._overrideCloseFunc(slot0)
	slot0._views[1]._animView:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(slot0._doCloseView, slot0, 0.333)
end

function slot0._doCloseView(slot0)
	slot0:closeThis()
end

function slot0.onContainerDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._doCloseView, slot0)
end

return slot0
