module("modules.logic.seasonver.act123.view1_8.Season123_1_8EpisodeListViewContainer", package.seeall)

slot0 = class("Season123_1_8EpisodeListViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.episodeListView = Season123_1_8EpisodeListView.New()

	table.insert(slot1, Season123_1_8CheckCloseView.New())
	table.insert(slot1, slot0.episodeListView)
	table.insert(slot1, TabViewGroup.New(1, "top_left"))

	return slot1
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
	slot0.episodeListView._viewAnimator:Play(UIAnimationName.Close, 0, 0)
	Season123Controller.instance:dispatchEvent(Season123Event.EnterEpiosdeList, false)
	TaskDispatcher.runDelay(slot0._doClose, slot0, 0.17)
end

function slot0._doClose(slot0)
	slot0:closeThis()
end

function slot0.onContainerDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._doClose, slot0)
end

return slot0
