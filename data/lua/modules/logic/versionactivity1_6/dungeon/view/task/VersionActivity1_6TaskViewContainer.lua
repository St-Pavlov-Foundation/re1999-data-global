module("modules.logic.versionactivity1_6.dungeon.view.task.VersionActivity1_6TaskViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_6TaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#scroll_TaskList"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = VersionActivity1_6TaskItem
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

	arg_1_0._taskScrollView = LuaListScrollViewWithAnimator.New(VersionActivity1_6TaskListModel.instance, var_1_0, var_1_1)

	return {
		arg_1_0._taskScrollView,
		VersionActivity1_6TaskView.New(),
		TabViewGroup.New(1, "#go_BackBtns")
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

return var_0_0
