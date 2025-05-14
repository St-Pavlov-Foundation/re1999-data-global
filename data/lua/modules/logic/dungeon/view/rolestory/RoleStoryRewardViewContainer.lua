module("modules.logic.dungeon.view.rolestory.RoleStoryRewardViewContainer", package.seeall)

local var_0_0 = class("RoleStoryRewardViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "Left/progress/#scroll_view"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes.itemRes
	var_1_1.cellClass = RoleStoryRewardItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirH
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 268
	var_1_1.cellHeight = 600
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 2
	arg_1_0.scrollView = LuaListScrollViewWithAnimator.New(RoleStoryRewardListModel.instance, var_1_1)

	table.insert(var_1_0, arg_1_0.scrollView)
	table.insert(var_1_0, RoleStoryRewardView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.getScrollView(arg_2_0)
	return arg_2_0.scrollView
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	local var_3_0 = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		var_3_0
	}
end

return var_0_0
