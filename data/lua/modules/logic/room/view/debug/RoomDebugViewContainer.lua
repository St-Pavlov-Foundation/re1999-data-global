module("modules.logic.room.view.debug.RoomDebugViewContainer", package.seeall)

slot0 = class("RoomDebugViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomViewDebugPlace.New())
	table.insert(slot1, RoomViewDebugPackage.New())
	table.insert(slot1, RoomViewDebugBuilding.New())
	table.insert(slot1, RoomDebugView.New())
	table.insert(slot1, RoomViewDebugCamera.New())
	slot0:_buildDebugPlaceListView(slot1)
	slot0:_buildDebugPackageListView(slot1)
	slot0:_buildDebugBuildingListView(slot1)

	return slot1
end

function slot0._buildDebugPlaceListView(slot0, slot1)
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "go_normalroot/go_debugplace/scroll_debugplace"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[6]
	slot2.cellClass = RoomDebugPlaceItem
	slot2.scrollDir = ScrollEnum.ScrollDirH
	slot2.lineCount = 1
	slot2.cellWidth = 300
	slot2.cellHeight = 234
	slot2.cellSpaceH = 10
	slot2.cellSpaceV = 0
	slot2.startSpace = 0

	table.insert(slot1, LuaListScrollView.New(RoomDebugPlaceListModel.instance, slot2))
end

function slot0._buildDebugPackageListView(slot0, slot1)
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "go_normalroot/go_debugpackage/scroll_debugpackage"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[7]
	slot2.cellClass = RoomDebugPackageItem
	slot2.scrollDir = ScrollEnum.ScrollDirH
	slot2.lineCount = 1
	slot2.cellWidth = 300
	slot2.cellHeight = 234
	slot2.cellSpaceH = 10
	slot2.cellSpaceV = 0
	slot2.startSpace = 0

	table.insert(slot1, LuaListScrollView.New(RoomDebugPackageListModel.instance, slot2))
end

function slot0._buildDebugBuildingListView(slot0, slot1)
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "go_normalroot/go_debugbuilding/scroll_debugbuilding"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = RoomDebugBuildingItem
	slot2.scrollDir = ScrollEnum.ScrollDirH
	slot2.lineCount = 1
	slot2.cellWidth = 300
	slot2.cellHeight = 234
	slot2.cellSpaceH = 10
	slot2.cellSpaceV = 0
	slot2.startSpace = 0

	table.insert(slot1, LuaListScrollView.New(RoomDebugBuildingListModel.instance, slot2))
end

return slot0
