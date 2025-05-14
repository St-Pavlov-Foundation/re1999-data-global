module("modules.logic.room.view.debug.RoomDebugThemeFilterViewContainer", package.seeall)

local var_0_0 = class("RoomDebugThemeFilterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomDebugThemeFilterView.New())

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#go_content/#scroll_theme"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "#go_content/#go_themeitem"
	var_1_1.cellClass = RoomDebugThemeFilterItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 3
	var_1_1.cellWidth = 386
	var_1_1.cellHeight = 80
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0
	var_1_1.endSpace = 0

	table.insert(var_1_0, LuaListScrollView.New(RoomDebugThemeFilterListModel.instance, var_1_1))

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0
