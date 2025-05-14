module("modules.logic.room.view.debug.RoomDebugViewContainer", package.seeall)

local var_0_0 = class("RoomDebugViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomViewDebugPlace.New())
	table.insert(var_1_0, RoomViewDebugPackage.New())
	table.insert(var_1_0, RoomViewDebugBuilding.New())
	table.insert(var_1_0, RoomDebugView.New())
	table.insert(var_1_0, RoomViewDebugCamera.New())
	arg_1_0:_buildDebugPlaceListView(var_1_0)
	arg_1_0:_buildDebugPackageListView(var_1_0)
	arg_1_0:_buildDebugBuildingListView(var_1_0)

	return var_1_0
end

function var_0_0._buildDebugPlaceListView(arg_2_0, arg_2_1)
	local var_2_0 = ListScrollParam.New()

	var_2_0.scrollGOPath = "go_normalroot/go_debugplace/scroll_debugplace"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[6]
	var_2_0.cellClass = RoomDebugPlaceItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirH
	var_2_0.lineCount = 1
	var_2_0.cellWidth = 300
	var_2_0.cellHeight = 234
	var_2_0.cellSpaceH = 10
	var_2_0.cellSpaceV = 0
	var_2_0.startSpace = 0

	table.insert(arg_2_1, LuaListScrollView.New(RoomDebugPlaceListModel.instance, var_2_0))
end

function var_0_0._buildDebugPackageListView(arg_3_0, arg_3_1)
	local var_3_0 = ListScrollParam.New()

	var_3_0.scrollGOPath = "go_normalroot/go_debugpackage/scroll_debugpackage"
	var_3_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_3_0.prefabUrl = arg_3_0._viewSetting.otherRes[7]
	var_3_0.cellClass = RoomDebugPackageItem
	var_3_0.scrollDir = ScrollEnum.ScrollDirH
	var_3_0.lineCount = 1
	var_3_0.cellWidth = 300
	var_3_0.cellHeight = 234
	var_3_0.cellSpaceH = 10
	var_3_0.cellSpaceV = 0
	var_3_0.startSpace = 0

	table.insert(arg_3_1, LuaListScrollView.New(RoomDebugPackageListModel.instance, var_3_0))
end

function var_0_0._buildDebugBuildingListView(arg_4_0, arg_4_1)
	local var_4_0 = ListScrollParam.New()

	var_4_0.scrollGOPath = "go_normalroot/go_debugbuilding/scroll_debugbuilding"
	var_4_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_4_0.prefabUrl = arg_4_0._viewSetting.otherRes[1]
	var_4_0.cellClass = RoomDebugBuildingItem
	var_4_0.scrollDir = ScrollEnum.ScrollDirH
	var_4_0.lineCount = 1
	var_4_0.cellWidth = 300
	var_4_0.cellHeight = 234
	var_4_0.cellSpaceH = 10
	var_4_0.cellSpaceV = 0
	var_4_0.startSpace = 0

	table.insert(arg_4_1, LuaListScrollView.New(RoomDebugBuildingListModel.instance, var_4_0))
end

return var_0_0
