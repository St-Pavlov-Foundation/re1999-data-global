module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicTaskViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicTaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#scroll_TaskList"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = VersionActivity2_4MusicTaskItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 1160
	var_1_0.cellHeight = 165
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 0

	local var_1_1 = {}

	for iter_1_0 = 1, 6 do
		var_1_1[iter_1_0] = (iter_1_0 - 1) * 0.06
	end

	arg_1_0._taskScrollView = LuaListScrollViewWithAnimator.New(VersionActivity2_4MusicTaskListModel.instance, var_1_0, var_1_1)

	return {
		arg_1_0._taskScrollView,
		VersionActivity2_4MusicTaskView.New(),
		TabViewGroup.New(1, "#go_lefttop")
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

function var_0_0.addTaskItem(arg_4_0, arg_4_1)
	arg_4_0._taskItemList = arg_4_0._taskItemList or {}
	arg_4_0._taskItemList[arg_4_1] = arg_4_1
end

function var_0_0.getTaskItemList(arg_5_0)
	return arg_5_0._taskItemList or {}
end

return var_0_0
