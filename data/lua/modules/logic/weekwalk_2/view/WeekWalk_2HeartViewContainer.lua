module("modules.logic.weekwalk_2.view.WeekWalk_2HeartViewContainer", package.seeall)

local var_0_0 = class("WeekWalk_2HeartViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._heartView = WeekWalk_2HeartView.New()

	table.insert(var_1_0, arg_1_0._heartView)
	table.insert(var_1_0, WeekWalk_2Ending.New())
	table.insert(var_1_0, TabViewGroup.New(1, "top_left"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.WeekWalk)

		arg_2_0._navigateButtonView:setOverrideClose(arg_2_0._overrideClose, arg_2_0)

		return {
			arg_2_0._navigateButtonView
		}
	end
end

function var_0_0._overrideClose(arg_3_0)
	module_views_preloader.WeekWalk_2HeartLayerViewPreload(function()
		arg_3_0._heartView._viewAnim:Play(UIAnimationName.Close, 0, 0)
		TaskDispatcher.runDelay(arg_3_0._doClose, arg_3_0, 0.133)
	end)
end

function var_0_0._doClose(arg_5_0)
	if not ViewMgr.instance:isOpen(ViewName.WeekWalk_2HeartLayerView) then
		WeekWalk_2Controller.instance:openWeekWalk_2HeartLayerView({
			mapId = WeekWalk_2Model.instance:getCurMapId()
		})
	end

	arg_5_0:closeThis()
end

function var_0_0.onContainerDestroy(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._doClose, arg_6_0)
end

return var_0_0
