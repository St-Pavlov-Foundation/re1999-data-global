module("modules.versionactivitybase.fixed.enterview.view.VersionActivityFixedEnterViewContainer", package.seeall)

local var_0_0 = class("VersionActivityFixedEnterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = arg_1_0:getViews()

	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))
	table.insert(var_1_0, TabViewGroup.New(2, "#go_subview"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0:initNavigateButtonsView({
			true,
			true,
			false
		})

		return {
			arg_2_0._navigateButtonView
		}
	elseif arg_2_1 == 2 then
		local var_2_0 = arg_2_0:getMultiViews()

		var_2_0[#var_2_0 + 1] = ActivityWeekWalkDeepShowView.New()
		var_2_0[#var_2_0 + 1] = TowerMainEntryView.New()
		var_2_0[#var_2_0 + 1] = ActivityWeekWalkHeartShowView.New()

		return var_2_0
	end
end

function var_0_0.selectActTab(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.activityId = arg_3_2

	arg_3_0:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_3_1)
end

function var_0_0.onContainerInit(arg_4_0)
	if not arg_4_0.viewParam then
		return
	end

	arg_4_0.isFirstPlaySubViewAnim = true

	local var_4_0 = arg_4_0.viewParam.activityIdList or {}

	ActivityStageHelper.recordActivityStage(var_4_0)

	arg_4_0.activityId = arg_4_0.viewParam.jumpActId

	local var_4_1 = arg_4_0.viewParam.activitySettingList or {}
	local var_4_2 = VersionActivityEnterHelper.getTabIndex(var_4_1, arg_4_0.activityId)

	if var_4_2 ~= 1 then
		arg_4_0.viewParam.defaultTabIds = {}
		arg_4_0.viewParam.defaultTabIds[2] = var_4_2
	end

	local var_4_3 = var_4_1[var_4_2]
	local var_4_4 = VersionActivityEnterHelper.getActId(var_4_3)

	ActivityEnterMgr.instance:enterActivity(var_4_4)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		var_4_4
	})
end

function var_0_0.onContainerClose(arg_5_0)
	if arg_5_0:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

function var_0_0.getIsFirstPlaySubViewAnim(arg_6_0)
	return arg_6_0.isFirstPlaySubViewAnim
end

function var_0_0.markPlayedSubViewAnim(arg_7_0)
	arg_7_0.isFirstPlaySubViewAnim = false
end

function var_0_0.getViews(arg_8_0)
	return {
		VersionActivityFixedHelper.getVersionActivityEnterView().New(),
		VersionActivityFixedHelper.getVersionActivityEnterBgmView().New()
	}
end

function var_0_0.initNavigateButtonsView(arg_9_0, arg_9_1)
	arg_9_0._navigateButtonView = NavigateButtonsView.New(arg_9_1)
end

function var_0_0.getMultiViews(arg_10_0)
	return {
		VersionActivityFixedHelper.getVersionActivityDungeonEnterView().New()
	}
end

return var_0_0
