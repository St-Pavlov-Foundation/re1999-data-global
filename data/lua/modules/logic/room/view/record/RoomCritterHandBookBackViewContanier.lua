module("modules.logic.room.view.record.RoomCritterHandBookBackViewContanier", package.seeall)

local var_0_0 = class("RoomCritterHandBookBackViewContanier", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "bg/#scroll_view/"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "bg/#scroll_view/Viewport/Content/item"
	var_1_0.cellClass = RoomCritterHandBookBackItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.cellWidth = 230
	var_1_0.cellHeight = 220
	var_1_0.cellSpaceV = 0
	var_1_0.cellSpaceH = 20
	var_1_0.startSpace = 20
	var_1_0.cellSpaceH = 0
	var_1_0.lineCount = 4
	arg_1_0._handbookbackView = RoomCritterHandBookBackView.New()
	arg_1_0._handbookbackScrollView = LuaListScrollView.New(RoomHandBookBackListModel.instance, var_1_0)

	local var_1_1 = {}

	table.insert(var_1_1, arg_1_0._handbookbackView)
	table.insert(var_1_1, arg_1_0._handbookbackScrollView)

	return var_1_1
end

function var_0_0.getScrollView(arg_2_0)
	return arg_2_0._handbookbackScrollView
end

return var_0_0
