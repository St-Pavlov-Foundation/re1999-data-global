module("modules.logic.versionactivity2_5.act186.view.Activity186TaskViewContainer", package.seeall)

local var_0_0 = class("Activity186TaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Activity186TaskView.New())
	table.insert(var_1_0, Activity186MileStoneView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "root/taskList/ScrollView"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes.itemRes
	var_1_1.cellClass = Activity186TaskItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirH
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 364
	var_1_1.cellHeight = 450
	var_1_1.cellSpaceH = 20
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0
	var_1_1.endSpace = 0

	table.insert(var_1_0, LuaListScrollView.New(Activity186TaskListModel.instance, var_1_1))

	local var_1_2 = ListScrollParam.New()

	var_1_2.scrollGOPath = "root/bonusNode/#scroll_reward"
	var_1_2.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_2.prefabUrl = "root/bonusNode/#scroll_reward/Viewport/#go_content/rewarditem"
	var_1_2.cellClass = Activity186MileStoneItem
	var_1_2.scrollDir = ScrollEnum.ScrollDirH
	var_1_2.lineCount = 1
	var_1_2.cellWidth = 210
	var_1_2.cellHeight = 285
	var_1_2.cellSpaceH = 30
	var_1_2.startSpace = -10
	arg_1_0.mileStoneScrollView = LuaListScrollViewWithAnimator.New(Activity186MileStoneListModel.instance, var_1_2)

	table.insert(var_1_0, arg_1_0.mileStoneScrollView)

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

return var_0_0
