module("modules.logic.room.view.layout.RoomLayoutBgSelectViewContainer", package.seeall)

local var_0_0 = class("RoomLayoutBgSelectViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomLayoutBgSelectView.New())

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#go_content/#scroll_CoverItemList"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "#go_content/#go_coveritem"
	var_1_1.cellClass = RoomLayoutBgSelectItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 520
	var_1_1.cellHeight = 254
	var_1_1.cellSpaceH = 20
	var_1_1.cellSpaceV = 20
	var_1_1.startSpace = 20

	table.insert(var_1_0, LuaListScrollView.New(RoomLayoutBgResListModel.instance, var_1_1))

	return var_1_0
end

return var_0_0
