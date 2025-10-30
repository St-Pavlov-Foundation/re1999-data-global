﻿module("modules.logic.versionactivity3_0.enter.view.VersionActivity3_0EnterViewContainer", package.seeall)

local var_0_0 = class("VersionActivity3_0EnterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		VersionActivity3_0EnterView.New(),
		VersionActivity3_0EnterBgmView.New(),
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

		var_2_0[#var_2_0 + 1] = MultiView.New({
			VersionActivity3_0DungeonEnterView.New(),
			VersionActivity3_0EnterDragView.New("#simage_bg")
		})
		var_2_0[#var_2_0 + 1] = MultiView.New({
			V1a6_BossRush_EnterView.New(),
			VersionActivity3_0EnterDragView.New("#simage_FullBG")
		})
		var_2_0[#var_2_0 + 1] = MultiView.New({
			RoleStoryEnterView.New(),
			VersionActivity3_0EnterDragView.New("#simage_FullBG")
		})
		var_2_0[#var_2_0 + 1] = MultiView.New({
			VersionActivity3_0MaLiAnNaEnterView.New(),
			VersionActivity3_0EnterDragView.New("#simage_FullBG")
		})
		var_2_0[#var_2_0 + 1] = MultiView.New({
			VersionActivity3_0KaRongEnterView.New(),
			VersionActivity3_0EnterDragView.New("#simage_FullBG")
		})
		var_2_0[#var_2_0 + 1] = MultiView.New({
			SeasonEnterView.New(),
			VersionActivity3_0EnterDragView.New("#simage_FullBG")
		})
		var_2_0[#var_2_0 + 1] = MultiView.New({
			VersionActivity3_0_v2a3_ReactivityEnterview.New(),
			VersionActivity3_0EnterDragView.New("bg")
		})
		var_2_0[#var_2_0 + 1] = MultiView.New({
			ActivityWeekWalkDeepShowView.New(),
			VersionActivity3_0EnterDragView.New("bg")
		})
		var_2_0[#var_2_0 + 1] = MultiView.New({
			TowerMainEntryView.New(),
			VersionActivity3_0EnterDragView.New("#simage_FullBG")
		})
		var_2_0[#var_2_0 + 1] = MultiView.New({
			ActivityWeekWalkHeartShowView.New(),
			VersionActivity3_0EnterDragView.New("bg")
		})

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
		ViewMgr.instance:openView(ViewName.MainView)
	end
end

function var_0_0.getIsFirstPlaySubViewAnim(arg_6_0)
	return arg_6_0.isFirstPlaySubViewAnim
end

function var_0_0.markPlayedSubViewAnim(arg_7_0)
	arg_7_0.isFirstPlaySubViewAnim = false
end

return var_0_0
