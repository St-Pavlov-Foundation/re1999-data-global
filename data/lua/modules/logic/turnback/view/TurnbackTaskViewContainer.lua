module("modules.logic.turnback.view.TurnbackTaskViewContainer", package.seeall)

local var_0_0 = class("TurnbackTaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "right/#scroll_task"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = TurnbackTaskItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 800
	var_1_0.cellHeight = 140
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 0
	var_1_0.startSpace = 6
	var_1_0.frameUpdateMs = 100
	arg_1_0._scrollView = LuaListScrollView.New(TurnbackTaskModel.instance, var_1_0)

	return {
		arg_1_0._scrollView,
		TurnbackTaskView.New()
	}
end

return var_0_0
