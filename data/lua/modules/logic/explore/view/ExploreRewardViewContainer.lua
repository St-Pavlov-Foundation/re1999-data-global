module("modules.logic.explore.view.ExploreRewardViewContainer", package.seeall)

local var_0_0 = class("ExploreRewardViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "mask/#scroll_view1"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "#go_rewarditem"
	var_1_0.cellClass = ExploreBonusItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 700
	var_1_0.cellHeight = 154
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 0
	var_1_0.startSpace = 25
	var_1_0.frameUpdateMs = 100

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "mask/#scroll_view2"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "#go_rewarditem"
	var_1_1.cellClass = ExploreBonusItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 700
	var_1_1.cellHeight = 154
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 25
	var_1_1.frameUpdateMs = 100

	local var_1_2 = {}

	for iter_1_0 = 1, 10 do
		var_1_2[iter_1_0] = (iter_1_0 - 1) * 0.06
	end

	return {
		ExploreRewardView.New(),
		LuaListScrollViewWithAnimator.New(ExploreTaskModel.instance:getTaskList(1), var_1_0, var_1_2),
		LuaListScrollViewWithAnimator.New(ExploreTaskModel.instance:getTaskList(2), var_1_1, var_1_2),
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return var_0_0
