module("modules.logic.bossrush.view.V1a4_BossRush_ScheduleViewContainer", package.seeall)

local var_0_0 = class("V1a4_BossRush_ScheduleViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.cellClass = V1a4_BossRush_ScheduleItem
	var_1_0.scrollGOPath = "Root/#scroll_Reward"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.scrollDir = ScrollEnum.ScrollDirH
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 200
	var_1_0.cellHeight = 700
	var_1_0.cellSpaceH = 150
	var_1_0.cellSpaceV = 0
	var_1_0.startSpace = 0
	var_1_0.endSpace = 150
	arg_1_0._listScrollParam = var_1_0
	arg_1_0._scheduleView = V1a4_BossRush_ScheduleView.New()

	return {
		arg_1_0._scheduleView
	}
end

function var_0_0.getListScrollParam(arg_2_0)
	return arg_2_0._listScrollParam
end

return var_0_0
