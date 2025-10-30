module("modules.logic.season.view3_0.Season3_0TaskViewContainer", package.seeall)

local var_0_0 = class("Season3_0TaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Season3_0TaskView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_tasklist"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = Season3_0TaskItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 1112
	var_1_1.cellHeight = 140
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 19

	local var_1_2 = {}

	for iter_1_0 = 1, 7 do
		var_1_2[iter_1_0] = (iter_1_0 - 1) * 0.06
	end

	arg_1_0.notPlayAnimation = true
	arg_1_0._taskScrollView = LuaListScrollViewWithAnimator.New(Activity104TaskListModel.instance, var_1_1, var_1_2)

	table.insert(var_1_0, arg_1_0._taskScrollView)

	return var_1_0
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

return var_0_0
