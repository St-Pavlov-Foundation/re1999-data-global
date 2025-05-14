module("modules.logic.weekwalk.view.WeekWalkRewardViewContainer", package.seeall)

local var_0_0 = class("WeekWalkRewardViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "right/#scroll_reward"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = WeekWalkRewardItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 1500
	var_1_1.cellHeight = 160
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0
	WeekWalkTaskListModel.instance.openRewardTime = Time.time

	table.insert(var_1_0, LuaListScrollView.New(WeekWalkTaskListModel.instance, var_1_1))
	table.insert(var_1_0, WeekWalkRewardView.New())

	return var_1_0
end

return var_0_0
