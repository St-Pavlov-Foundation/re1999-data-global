module("modules.logic.room.view.layout.RoomLayoutItemTipsContainer", package.seeall)

local var_0_0 = class("RoomLayoutItemTipsContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomLayoutItemTips.New())

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#go_content/#scroll_ItemList"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "#go_content/#go_normalitem"
	var_1_1.cellClass = RoomLayoutItemTipsItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 550
	var_1_1.cellHeight = 52
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0

	table.insert(var_1_0, LuaListScrollView.New(RoomLayoutItemListModel.instance, var_1_1))

	return var_1_0
end

function var_0_0.getTipsHeight(arg_2_0)
	local var_2_0 = RoomLayoutItemListModel.instance:getCount()
	local var_2_1 = 0
	local var_2_2 = 12.5
	local var_2_3 = 52
	local var_2_4 = 88
	local var_2_5 = 20

	if var_2_0 > 0 then
		var_2_0 = var_2_0 + 0.5
	end

	local var_2_6 = math.max(var_2_1, var_2_0)

	return math.min(var_2_2, var_2_6) * var_2_3 + var_2_4 + var_2_5
end

return var_0_0
