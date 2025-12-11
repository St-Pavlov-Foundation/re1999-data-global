module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_TaskViewContainer", package.seeall)

local var_0_0 = class("V3a1_GaoSiNiao_TaskViewContainer", CorvusTaskViewContainer)

function var_0_0.onCreateListScrollParam(arg_1_0)
	return (var_0_0.super.onCreateListScrollParam(arg_1_0))
end

function var_0_0.onCreateMainView(arg_2_0)
	return V3a1_GaoSiNiao_TaskView.New()
end

function var_0_0.onCreateListScrollParam(arg_3_0)
	local var_3_0 = ListScrollParam.New()

	var_3_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_3_0.sortMode = ScrollEnum.ScrollSortDown
	var_3_0.scrollDir = ScrollEnum.ScrollDirV
	var_3_0.prefabUrl = arg_3_0._viewSetting.otherRes[1]
	var_3_0.lineCount = 1
	var_3_0.cellWidth = 1160
	var_3_0.cellHeight = 165
	var_3_0.cellSpaceV = 0
	var_3_0.startSpace = 0
	var_3_0.scrollGOPath = "#scroll_TaskList"
	var_3_0.cellClass = V3a1_GaoSiNiao_TaskViewItem
	var_3_0.rectMaskSoftness = {
		0,
		0
	}

	return var_3_0
end

return var_0_0
