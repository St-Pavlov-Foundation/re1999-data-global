module("modules.logic.versionactivity1_3.armpipe.view.ArmRewardViewContainer", package.seeall)

local var_0_0 = class("ArmRewardViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "Root/#scroll_TaskList"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = ArmRewardViewTaskItem.prefabPath
	var_1_1.cellClass = ArmRewardViewTaskItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 824
	var_1_1.cellHeight = 158
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0

	local var_1_2 = {}

	for iter_1_0 = 1, 10 do
		var_1_2[iter_1_0] = (iter_1_0 - 1) * 0.06 + 0.3
	end

	table.insert(var_1_0, LuaListScrollViewWithAnimator.New(Activity124RewardListModel.instance, var_1_1, var_1_2))
	table.insert(var_1_0, ArmRewardView.New())

	return var_1_0
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
