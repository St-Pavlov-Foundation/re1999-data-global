module("modules.logic.versionactivity2_4.enter.view.VersionActivity2_4EnterViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_4EnterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		VersionActivity2_4EnterView.New(),
		VersionActivity2_4EnterBgmView.New(),
		TabViewGroup.New(1, "#go_topleft"),
		TabViewGroup.New(2, "#go_subview")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0._navigateButtonView
		}
	elseif arg_2_1 == 2 then
		local var_2_0 = {}

		var_2_0[#var_2_0 + 1] = VersionActivity2_4DungeonEnterView.New()
		var_2_0[#var_2_0 + 1] = V2a4_PinballEnterView.New()
		var_2_0[#var_2_0 + 1] = VersionActivity2_4MusicEnterView.New()
		var_2_0[#var_2_0 + 1] = VersionActivity2_4WuErLiXiEnterView.New()
		var_2_0[#var_2_0 + 1] = ReactivityEnterview.New()
		var_2_0[#var_2_0 + 1] = VersionActivity2_4RougeEnterView.New()
		var_2_0[#var_2_0 + 1] = V2a4_Season166EnterView.New()
		var_2_0[#var_2_0 + 1] = RoleStoryEnterView.New()
		var_2_0[#var_2_0 + 1] = V1a6_BossRush_EnterView.New()
		var_2_0[#var_2_0 + 1] = ActivityWeekWalkDeepShowView.New()
		var_2_0[#var_2_0 + 1] = TowerMainEntryView.New()

		return var_2_0
	end
end

function var_0_0.selectActTab(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.activityId = arg_3_2

	if arg_3_0.activityId == VersionActivity2_4Enum.ActivityId.Dungeon then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_4Dungeon.enterview_tab_switch)
	end

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
	local var_4_3 = var_4_1[var_4_2]
	local var_4_4 = VersionActivityEnterHelper.getActId(var_4_3)

	if var_4_2 ~= 1 then
		arg_4_0.viewParam.defaultTabIds = {}
		arg_4_0.viewParam.defaultTabIds[2] = var_4_2
	elseif not arg_4_0.viewParam.isDirectOpen and var_4_4 == VersionActivity2_4Enum.ActivityId.Dungeon then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_4Dungeon.play_ui_diqiu_open)
	end

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

return var_0_0
