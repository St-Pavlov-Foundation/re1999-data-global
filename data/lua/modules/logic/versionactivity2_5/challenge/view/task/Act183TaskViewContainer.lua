module("modules.logic.versionactivity2_5.challenge.view.task.Act183TaskViewContainer", package.seeall)

local var_0_0 = class("Act183TaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "root/#go_topleft"))
	table.insert(var_1_0, Act183TaskView.New())

	local var_1_1 = MixScrollParam.New()

	var_1_1.scrollGOPath = "root/right/#scroll_task"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = Act183TaskItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.startSpace = 0
	var_1_1.endSpace = 0
	arg_1_0._scrollView = LuaMixScrollView.New(Act183TaskListModel.instance, var_1_1)

	arg_1_0._scrollView:setDynamicGetItem(arg_1_0._dynamicGetItem, arg_1_0)
	table.insert(var_1_0, arg_1_0._scrollView)

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

function var_0_0._dynamicGetItem(arg_3_0, arg_3_1)
	if not arg_3_1 then
		return
	end

	if arg_3_1.type == Act183Enum.TaskListItemType.Head then
		return "taskheader", Act183TaskHeadItem, arg_3_0._viewSetting.otherRes[2]
	elseif arg_3_1.type == Act183Enum.TaskListItemType.OneKey then
		return "onekey", Act183TaskOneKeyItem, arg_3_0._viewSetting.otherRes[3]
	end
end

function var_0_0.getTaskScrollView(arg_4_0)
	return arg_4_0._scrollView
end

return var_0_0
