module("modules.logic.sp01.act204.view.Activity204TaskViewContainer", package.seeall)

local var_0_0 = class("Activity204TaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Activity204TaskView.New())
	table.insert(var_1_0, Activity204MileStoneView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "root/taskList/ScrollView"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes.itemRes
	var_1_1.cellClass = Activity204TaskItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirH
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 400
	var_1_1.cellHeight = 600
	var_1_1.cellSpaceH = 20
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 15
	var_1_1.endSpace = 50

	table.insert(var_1_0, LuaListScrollView.New(Activity204TaskListModel.instance, var_1_1))

	local var_1_2 = ListScrollParam.New()

	var_1_2.scrollGOPath = "root/bonusNode/#scroll_reward"
	var_1_2.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_2.prefabUrl = "root/bonusNode/#scroll_reward/Viewport/#go_content/rewarditem"
	var_1_2.cellClass = Activity204MileStoneItem
	var_1_2.scrollDir = ScrollEnum.ScrollDirH
	var_1_2.lineCount = 1
	var_1_2.cellWidth = 487
	var_1_2.cellHeight = 285
	var_1_2.cellSpaceH = -57
	var_1_2.startSpace = 0
	arg_1_0.mileStoneScrollView = LuaMixScrollView.New(Activity204MileStoneListModel.instance, var_1_2)

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
