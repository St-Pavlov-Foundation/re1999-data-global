module("modules.logic.activity.view.ActivityNoviceSignViewContainer", package.seeall)

local var_0_0 = class("ActivityNoviceSignViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#go_daylist/#scroll_item"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = ActivityNoviceSignItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirH
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 190
	var_1_1.cellHeight = 520
	var_1_1.cellSpaceH = 3.16
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 5

	table.insert(var_1_0, LuaListScrollView.New(ActivityNoviceSignItemListModel.instance, var_1_1))
	table.insert(var_1_0, ActivityNoviceSignView.New())

	return var_1_0
end

return var_0_0
