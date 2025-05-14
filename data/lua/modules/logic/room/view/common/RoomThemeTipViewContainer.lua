module("modules.logic.room.view.common.RoomThemeTipViewContainer", package.seeall)

local var_0_0 = class("RoomThemeTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomThemeTipView.New())

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "content/go_scroll/#scroll_item"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "content/themeitem"
	var_1_1.cellClass = RoomThemeTipItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 680
	var_1_1.cellHeight = 60
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 4
	var_1_1.startSpace = 0
	var_1_1.endSpace = 0

	table.insert(var_1_0, LuaListScrollView.New(RoomThemeItemListModel.instance, var_1_1))

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0
