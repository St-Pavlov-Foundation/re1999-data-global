module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_TaskViewContainer", package.seeall)

local var_0_0 = class("V2a4_WarmUp_TaskViewContainer", Activity125TaskViewBaseContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#scroll_TaskList"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = V2a4_WarmUp_TaskItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 1136
	var_1_0.cellHeight = 152
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 12

	local var_1_1 = {}

	for iter_1_0 = 1, 5 do
		var_1_1[iter_1_0] = (iter_1_0 - 1) * 0.06
	end

	arg_1_0.notPlayAnimation = true
	arg_1_0._taskScrollView = LuaListScrollViewWithAnimator.New(V2a4_WarmUp_TaskListModel.instance, var_1_0, var_1_1)

	return {
		arg_1_0._taskScrollView,
		V2a4_WarmUp_TaskView.New()
	}
end

function var_0_0.actId(arg_2_0)
	return V2a4_WarmUpConfig.instance:actId()
end

return var_0_0
