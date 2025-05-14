module("modules.logic.seasonver.act123.view1_8.Season123_1_8TaskViewContainer", package.seeall)

local var_0_0 = class("Season123_1_8TaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0:buildScrollViews()
	table.insert(var_1_0, arg_1_0.scrollView)
	table.insert(var_1_0, Season123_1_8TaskView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	local var_2_0 = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		var_2_0
	}
end

function var_0_0.buildScrollViews(arg_3_0)
	local var_3_0 = ListScrollParam.New()

	var_3_0.scrollGOPath = "#scroll_tasklist"
	var_3_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_3_0.prefabUrl = arg_3_0._viewSetting.otherRes[1]
	var_3_0.cellClass = Season123_1_8TaskItem
	var_3_0.scrollDir = ScrollEnum.ScrollDirV
	var_3_0.lineCount = 1
	var_3_0.cellWidth = 1112
	var_3_0.cellHeight = 140
	var_3_0.cellSpaceH = 0
	var_3_0.cellSpaceV = 18.9
	var_3_0.startSpace = 0
	var_3_0.frameUpdateMs = 100
	arg_3_0.scrollView = LuaListScrollView.New(Season123TaskModel.instance, var_3_0)
end

return var_0_0
