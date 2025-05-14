module("modules.logic.activity.view.SummerSignPart1ViewContainer_1_2", package.seeall)

local var_0_0 = class("SummerSignPart1ViewContainer_1_2", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#go_daylist/#scroll_item"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = ActivityNorSignItem_1_2
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 7
	var_1_1.cellWidth = 200
	var_1_1.cellHeight = 590
	var_1_1.cellSpaceH = 4.1
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0

	table.insert(var_1_0, LuaListScrollView.New(ActivityNorSignItemListModel_1_2.instance, var_1_1))
	table.insert(var_1_0, SummerSignPart1View_1_2.New())

	return var_1_0
end

return var_0_0
