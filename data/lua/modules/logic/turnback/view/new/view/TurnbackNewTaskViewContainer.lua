module("modules.logic.turnback.view.new.view.TurnbackNewTaskViewContainer", package.seeall)

local var_0_0 = class("TurnbackNewTaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "left/#scroll_task"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = TurnbackNewTaskItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 1136
	var_1_1.cellHeight = 152
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 6
	var_1_1.startSpace = 6
	var_1_1.frameUpdateMs = 100
	arg_1_0._scrollView = LuaListScrollView.New(TurnbackTaskModel.instance, var_1_1)

	table.insert(var_1_0, arg_1_0._scrollView)
	table.insert(var_1_0, TurnbackNewTaskView.New())

	return var_1_0
end

return var_0_0
