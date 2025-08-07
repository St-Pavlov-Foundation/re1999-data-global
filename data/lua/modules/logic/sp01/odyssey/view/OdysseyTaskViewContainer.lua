module("modules.logic.sp01.odyssey.view.OdysseyTaskViewContainer", package.seeall)

local var_0_0 = class("OdysseyTaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0:buildScrollViews()
	table.insert(var_1_0, arg_1_0.scrollView)
	table.insert(var_1_0, OdysseyTaskView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "root/#go_topleft"))

	return var_1_0
end

function var_0_0.buildScrollViews(arg_2_0)
	local var_2_0 = ListScrollParam.New()

	var_2_0.scrollGOPath = "root/Task/#scroll_TaskList"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[1]
	var_2_0.cellClass = OdysseyTaskItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirV
	var_2_0.lineCount = 1
	var_2_0.cellWidth = 1160
	var_2_0.cellHeight = 158
	var_2_0.cellSpaceH = 0
	var_2_0.cellSpaceV = 0
	var_2_0.startSpace = 0
	var_2_0.frameUpdateMs = 100

	local var_2_1 = {}

	for iter_2_0 = 1, 6 do
		var_2_1[iter_2_0] = (iter_2_0 - 1) * 0.06
	end

	arg_2_0.scrollView = LuaListScrollViewWithAnimator.New(OdysseyTaskModel.instance, var_2_0, var_2_1)
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_3_0.navigateView
		}
	end
end

return var_0_0
