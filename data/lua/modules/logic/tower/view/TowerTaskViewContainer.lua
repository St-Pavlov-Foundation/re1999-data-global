module("modules.logic.tower.view.TowerTaskViewContainer", package.seeall)

local var_0_0 = class("TowerTaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0:buildScrollViews()
	table.insert(var_1_0, arg_1_0.scrollView)
	table.insert(var_1_0, TowerTaskView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.buildScrollViews(arg_3_0)
	local var_3_0 = ListScrollParam.New()

	var_3_0.scrollGOPath = "Right/#scroll_taskList"
	var_3_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_3_0.prefabUrl = arg_3_0._viewSetting.otherRes[1]
	var_3_0.cellClass = TowerTaskItem
	var_3_0.scrollDir = ScrollEnum.ScrollDirV
	var_3_0.lineCount = 1
	var_3_0.cellWidth = 1160
	var_3_0.cellHeight = 165
	var_3_0.cellSpaceH = 0
	var_3_0.cellSpaceV = 0
	var_3_0.startSpace = 0
	var_3_0.frameUpdateMs = 100

	local var_3_1 = {}

	for iter_3_0 = 1, 6 do
		var_3_1[iter_3_0] = (iter_3_0 - 1) * 0.06
	end

	arg_3_0.scrollView = LuaListScrollViewWithAnimator.New(TowerTaskModel.instance, var_3_0, var_3_1)
end

return var_0_0
