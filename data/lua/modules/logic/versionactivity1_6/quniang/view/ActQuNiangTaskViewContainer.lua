﻿module("modules.logic.versionactivity1_6.quniang.view.ActQuNiangTaskViewContainer", package.seeall)

local var_0_0 = class("ActQuNiangTaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_TaskList"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = ActQuNiangTaskItem.prefabPath
	var_1_1.cellClass = ActQuNiangTaskItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 1160
	var_1_1.cellHeight = 165
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0

	local var_1_2 = {}

	for iter_1_0 = 1, 10 do
		var_1_2[iter_1_0] = (iter_1_0 - 1) * 0.06
	end

	table.insert(var_1_0, LuaListScrollViewWithAnimator.New(ActQuNiangTaskListModel.instance, var_1_1, var_1_2))
	table.insert(var_1_0, ActQuNiangTaskView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return var_0_0
