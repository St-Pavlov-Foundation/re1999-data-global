module("modules.logic.room.view.gift.RoomBlockGiftChoiceViewContainer", package.seeall)

local var_0_0 = class("RoomBlockGiftChoiceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_block"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "#go_blockItem"
	var_1_1.cellClass = RoomBlockGiftPackageItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 5

	local var_1_2 = RoomBlockGiftEnum.SubTypeInfo[MaterialEnum.MaterialType.BlockPackage]

	var_1_1.cellWidth = var_1_2.CellSize[1]
	var_1_1.cellHeight = var_1_2.CellSize[2]
	var_1_1.cellSpaceH = var_1_2.CellSpacing[1]
	var_1_1.cellSpaceV = var_1_2.CellSpacing[2]

	table.insert(var_1_0, LuaListScrollView.New(RoomBlockGiftListModel.instance, var_1_1))

	local var_1_3 = ListScrollParam.New()

	var_1_3.scrollGOPath = "#scroll_building"
	var_1_3.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_3.prefabUrl = "#go_buildingItem"
	var_1_3.cellClass = RoomBlockGiftBuildingItem
	var_1_3.scrollDir = ScrollEnum.ScrollDirV
	var_1_3.startSpace = 20
	var_1_3.lineCount = 4

	local var_1_4 = RoomBlockGiftEnum.SubTypeInfo[MaterialEnum.MaterialType.Building]

	var_1_3.cellWidth = var_1_4.CellSize[1]
	var_1_3.cellHeight = var_1_4.CellSize[2]
	var_1_3.cellSpaceH = var_1_4.CellSpacing[1]
	var_1_3.cellSpaceV = var_1_4.CellSpacing[2]

	table.insert(var_1_0, LuaListScrollView.New(RoomBuildingGiftListModel.instance, var_1_3))
	table.insert(var_1_0, RoomBlockGiftChoiceView.New())

	return var_1_0
end

return var_0_0
