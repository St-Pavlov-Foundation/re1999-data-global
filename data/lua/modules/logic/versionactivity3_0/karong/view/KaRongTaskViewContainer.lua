module("modules.logic.versionactivity3_0.karong.view.KaRongTaskViewContainer", package.seeall)

local var_0_0 = class("KaRongTaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_TaskList"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = KaRongTaskItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 1160
	var_1_1.cellHeight = 165
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0

	local var_1_2 = {}

	for iter_1_0 = 1, 6 do
		var_1_2[iter_1_0] = (iter_1_0 - 1) * 0.06
	end

	local var_1_3 = LuaListScrollViewWithAnimator.New(RoleActivityTaskListModel.instance, var_1_1, var_1_2)

	var_1_3.dontPlayCloseAnimation = true

	table.insert(var_1_0, var_1_3)
	table.insert(var_1_0, KaRongTaskView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
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
