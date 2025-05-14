module("modules.logic.versionactivity1_4.act134.view.Activity134TaskViewContainer", package.seeall)

local var_0_0 = class("Activity134TaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "main/#scroll_view"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = Activity134TaskItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 1300
	var_1_1.cellHeight = 160
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0

	local var_1_2 = {}

	for iter_1_0 = 1, 6 do
		var_1_2[iter_1_0] = (iter_1_0 - 1) * 0.06
	end

	arg_1_0._scrollview = LuaListScrollViewWithAnimator.New(Activity134TaskListModel.instance, var_1_1, var_1_2)

	table.insert(var_1_0, arg_1_0._scrollview)
	table.insert(var_1_0, Activity134TaskView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return
end

function var_0_0.onContainerInit(arg_3_0)
	arg_3_0.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(arg_3_0._scrollview)
end

function var_0_0.onContainerClickModalMask(arg_4_0)
	arg_4_0:closeThis()
end

return var_0_0
