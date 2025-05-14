module("modules.logic.room.view.building.RoomFormulaViewContainer", package.seeall)

local var_0_0 = class("RoomFormulaViewContainer", BaseViewContainer)

var_0_0.cellHeightSize = 150

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomFormulaView.New())
	arg_1_0:_buildFormulaItemListView(var_1_0)

	return var_1_0
end

function var_0_0._buildFormulaItemListView(arg_2_0, arg_2_1)
	local var_2_0 = ListScrollParam.New()

	var_2_0.scrollGOPath = "view/#scroll_formula"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[1]
	var_2_0.cellClass = RoomFormulaItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirV
	var_2_0.lineCount = 1
	var_2_0.cellWidth = 980
	var_2_0.cellHeight = arg_2_0.cellHeightSize
	var_2_0.cellSpaceH = 0
	var_2_0.cellSpaceV = 0
	var_2_0.startSpace = 0
	arg_2_0.__scrollView = LuaListScrollView.New(RoomFormulaListModel.instance, var_2_0)

	table.insert(arg_2_1, arg_2_0.__scrollView)
end

function var_0_0.getScrollView(arg_3_0)
	return arg_3_0.__scrollView
end

function var_0_0.getCsListScroll(arg_4_0)
	return (arg_4_0:getScrollView():getCsListScroll())
end

return var_0_0
