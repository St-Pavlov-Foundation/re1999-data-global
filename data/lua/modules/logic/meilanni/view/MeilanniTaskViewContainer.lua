module("modules.logic.meilanni.view.MeilanniTaskViewContainer", package.seeall)

local var_0_0 = class("MeilanniTaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "right/#scroll_reward"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = MeilanniTaskItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 1300
	var_1_1.cellHeight = 160
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 6.19
	var_1_1.startSpace = 0

	local var_1_2 = {}

	for iter_1_0 = 1, 6 do
		var_1_2[iter_1_0] = (iter_1_0 - 1) * 0.07
	end

	local var_1_3 = LuaListScrollViewWithAnimator.New(MeilanniTaskListModel.instance, var_1_1, var_1_2)

	var_1_3.dontPlayCloseAnimation = true
	arg_1_0._taskScrollView = var_1_3

	table.insert(var_1_0, arg_1_0._taskScrollView)
	table.insert(var_1_0, MeilanniTaskView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, nil, nil, nil, nil, arg_2_0)

	return {
		arg_2_0._navigateButtonView
	}
end

function var_0_0.onContainerInit(arg_3_0)
	arg_3_0.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(arg_3_0._taskScrollView)

	arg_3_0.taskAnimRemoveItem:setMoveInterval(0)
end

return var_0_0
