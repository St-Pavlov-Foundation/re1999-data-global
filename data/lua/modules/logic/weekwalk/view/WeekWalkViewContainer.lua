module("modules.logic.weekwalk.view.WeekWalkViewContainer", package.seeall)

slot0 = class("WeekWalkViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._weekWalkView = WeekWalkView.New()
	slot0._weekWalkMapView = WeekWalkMap.New()

	table.insert(slot1, slot0._weekWalkMapView)
	table.insert(slot1, slot0._weekWalkView)
	table.insert(slot1, WeekWalkEnding.New())
	table.insert(slot1, TabViewGroup.New(1, "top_left"))

	return slot1
end

function slot0.getWeekWalkMap(slot0)
	return slot0._weekWalkMapView
end

function slot0.buildTabViews(slot0, slot1)
	slot0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, HelpEnum.HelpId.WeekWalk)

	slot0._navigateButtonView:setOverrideClose(slot0._overrideClose, slot0)

	return {
		slot0._navigateButtonView
	}
end

function slot0.getNavBtnView(slot0)
	return slot0._navigateButtonView
end

function slot0._overrideClose(slot0)
	module_views_preloader.WeekWalkLayerViewPreload(function ()
		uv0._weekWalkView._viewAnim:Play(UIAnimationName.Close, 0, 0)
		TaskDispatcher.runDelay(uv0._doClose, uv0, 0.133)
	end)
end

function slot0._doClose(slot0)
	slot0:closeThis()

	if not ViewMgr.instance:isOpen(ViewName.WeekWalkLayerView) then
		WeekWalkController.instance:openWeekWalkLayerView({
			mapId = WeekWalkModel.instance:getCurMapId()
		})
	end
end

function slot0.onContainerInit(slot0)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, slot0._navigateButtonView.refreshUI, slot0._navigateButtonView)
end

function slot0.onContainerOpenFinish(slot0)
	slot0._navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_Universal_Click)
end

function slot0.onContainerDestroy(slot0)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, slot0._navigateButtonView.refreshUI, slot0._navigateButtonView)
	TaskDispatcher.cancelTask(slot0._doClose, slot0)
end

return slot0
