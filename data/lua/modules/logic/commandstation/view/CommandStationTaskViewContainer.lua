module("modules.logic.commandstation.view.CommandStationTaskViewContainer", package.seeall)

local var_0_0 = class("CommandStationTaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "Right/#scroll_TaskList"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = CommandStationTaskItem.prefabPath
	var_1_0.cellClass = CommandStationTaskItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 1160
	var_1_0.cellHeight = 165
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 0
	var_1_0.startSpace = 0

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "Right/Progress/#scroll_view"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "Right/Progress/#scroll_view/Viewport/Content/#go_rewarditem"
	var_1_1.cellClass = CommandStationBonusItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirH

	local var_1_2 = {}

	for iter_1_0 = 1, 30 do
		var_1_2[iter_1_0] = (iter_1_0 - 1) * 0.06
	end

	return {
		LuaListScrollViewWithAnimator.New(CommandStationTaskListModel.instance, var_1_0, var_1_2),
		LuaMixScrollView.New(CommandStationBonusListModel.instance, var_1_1),
		CommandStationTaskView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.CommandStationTask)

		return {
			arg_2_0.navigateView
		}
	end
end

return var_0_0
