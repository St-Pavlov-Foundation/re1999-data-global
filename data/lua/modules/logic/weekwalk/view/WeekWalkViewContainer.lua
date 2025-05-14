module("modules.logic.weekwalk.view.WeekWalkViewContainer", package.seeall)

local var_0_0 = class("WeekWalkViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._weekWalkView = WeekWalkView.New()
	arg_1_0._weekWalkMapView = WeekWalkMap.New()

	table.insert(var_1_0, arg_1_0._weekWalkMapView)
	table.insert(var_1_0, arg_1_0._weekWalkView)
	table.insert(var_1_0, WeekWalkEnding.New())
	table.insert(var_1_0, TabViewGroup.New(1, "top_left"))

	return var_1_0
end

function var_0_0.getWeekWalkMap(arg_2_0)
	return arg_2_0._weekWalkMapView
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	arg_3_0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, HelpEnum.HelpId.WeekWalk)

	arg_3_0._navigateButtonView:setOverrideClose(arg_3_0._overrideClose, arg_3_0)

	return {
		arg_3_0._navigateButtonView
	}
end

function var_0_0.getNavBtnView(arg_4_0)
	return arg_4_0._navigateButtonView
end

function var_0_0._overrideClose(arg_5_0)
	module_views_preloader.WeekWalkLayerViewPreload(function()
		arg_5_0._weekWalkView._viewAnim:Play(UIAnimationName.Close, 0, 0)
		TaskDispatcher.runDelay(arg_5_0._doClose, arg_5_0, 0.133)
	end)
end

function var_0_0._doClose(arg_7_0)
	arg_7_0:closeThis()

	if not ViewMgr.instance:isOpen(ViewName.WeekWalkLayerView) then
		WeekWalkController.instance:openWeekWalkLayerView({
			mapId = WeekWalkModel.instance:getCurMapId()
		})
	end
end

function var_0_0.onContainerInit(arg_8_0)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, arg_8_0._navigateButtonView.refreshUI, arg_8_0._navigateButtonView)
end

function var_0_0.onContainerOpenFinish(arg_9_0)
	arg_9_0._navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_Universal_Click)
end

function var_0_0.onContainerDestroy(arg_10_0)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, arg_10_0._navigateButtonView.refreshUI, arg_10_0._navigateButtonView)
	TaskDispatcher.cancelTask(arg_10_0._doClose, arg_10_0)
end

return var_0_0
