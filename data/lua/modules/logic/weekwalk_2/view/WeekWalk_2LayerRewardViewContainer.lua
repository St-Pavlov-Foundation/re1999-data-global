module("modules.logic.weekwalk_2.view.WeekWalk_2LayerRewardViewContainer", package.seeall)

local var_0_0 = class("WeekWalk_2LayerRewardViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "right/#scroll_reward"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = WeekWalk_2LayerRewardItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 1500
	var_1_1.cellHeight = 160
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 1
	var_1_1.startSpace = 0

	local var_1_2 = {}

	for iter_1_0 = 1, 10 do
		var_1_2[iter_1_0] = (iter_1_0 - 1) * 0.07
	end

	table.insert(var_1_0, WeekWalk_2LayerRewardView.New())
	table.insert(var_1_0, LuaListScrollViewWithAnimator.New(WeekWalk_2TaskListModel.instance, var_1_1, var_1_2))

	return var_1_0
end

return var_0_0
