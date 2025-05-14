module("modules.logic.versionactivity.view.VersionActivityTaskViewContainer", package.seeall)

local var_0_0 = class("VersionActivityTaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#scroll_right"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = VersionActivityTaskItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 1070
	var_1_0.cellHeight = 163
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = -6

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_left"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "#scroll_left/Viewport/Content/#go_item"
	var_1_1.cellClass = VersionActivityTaskBonusItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 610
	var_1_1.cellHeight = 165
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0

	local var_1_2 = {}

	for iter_1_0 = 1, 8 do
		var_1_2[iter_1_0] = (iter_1_0 - 1) * 0.04
	end

	local var_1_3 = LuaListScrollViewWithAnimator.New(VersionActivityTaskListModel.instance, var_1_0, var_1_2)

	var_1_3.dontPlayCloseAnimation = true
	arg_1_0._taskScrollView = var_1_3
	arg_1_0._taskBonusScrollView = LuaListScrollViewWithAnimator.New(VersionActivityTaskBonusListModel.instance, var_1_1, var_1_2)

	return {
		var_1_3,
		arg_1_0._taskBonusScrollView,
		VersionActivityTaskView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function var_0_0.onContainerInit(arg_3_0)
	arg_3_0.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(arg_3_0._taskScrollView)

	arg_3_0.taskAnimRemoveItem:setMoveInterval(0)
end

function var_0_0.setTaskBonusScrollViewIndexOffset(arg_4_0, arg_4_1)
	arg_4_0._taskBonusScrollView.indexOffset = arg_4_1
end

return var_0_0
