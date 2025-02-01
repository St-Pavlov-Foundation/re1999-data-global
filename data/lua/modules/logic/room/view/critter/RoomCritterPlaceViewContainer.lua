module("modules.logic.room.view.critter.RoomCritterPlaceViewContainer", package.seeall)

slot0 = class("RoomCritterPlaceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomCritterPlaceView.New())
	table.insert(slot1, LuaListScrollView.New(RoomCritterPlaceListModel.instance, slot0:getScrollParam1()))
	table.insert(slot1, LuaListScrollView.New(RoomCritterPlaceListModel.instance, slot0:getScrollParam2()))

	return slot1
end

function slot0.getScrollParam1(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_critterview1/critterscroll"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "#go_critterview1/critterscroll/Viewport/#go_critterContent1/#go_critterItem"
	slot1.cellClass = RoomCritterPlaceItem
	slot1.scrollDir = ScrollEnum.ScrollDirH
	slot1.cellWidth = 150
	slot1.cellHeight = 200
	slot1.cellSpaceH = 30
	slot1.startSpace = 30

	return slot1
end

function slot0.getScrollParam2(slot0)
	slot1 = "#go_critterview2/critterscroll"
	slot3 = ListScrollParam.New()
	slot3.scrollGOPath = slot1
	slot3.prefabType = ScrollEnum.ScrollPrefabFromView
	slot3.prefabUrl = "#go_critterview2/critterscroll/Viewport/#go_critterContent2/#go_critterItem"
	slot3.cellClass = RoomCritterPlaceItem
	slot3.scrollDir = ScrollEnum.ScrollDirV
	slot3.cellWidth = 180
	slot3.cellHeight = 150
	slot3.lineCount = slot0:_getLineCount(slot0:_getScrollWidth(slot1), slot3.cellWidth)
	slot3.cellSpaceV = 20
	slot3.startSpace = 10

	return slot3
end

function slot0._getScrollWidth(slot0, slot1)
	if gohelper.findChildComponent(slot0.viewGO, slot1, gohelper.Type_Transform) then
		return recthelper.getWidth(slot2)
	end

	return math.floor(UnityEngine.Screen.width * 1080 / UnityEngine.Screen.height + 0.5)
end

function slot0._getLineCount(slot0, slot1, slot2)
	return math.max(math.floor(slot1 / slot2), 1)
end

function slot0.onContainerInit(slot0)
	slot0:setContainerViewBuildingUid(slot0.viewParam and slot0.viewParam.buildingUid)
end

function slot0.onContainerClose(slot0)
	slot0:setContainerViewBuildingUid()
end

function slot0.setContainerViewBuildingUid(slot0, slot1)
	slot0._viewBuildingUid = slot1
end

function slot0.getContainerViewBuilding(slot0, slot1)
	if not RoomMapBuildingModel.instance:getBuildingMOById(slot0._viewBuildingUid) and slot1 then
		logError(string.format("RoomCritterPlaceViewContainer:getContainerViewBuilding error, buildingMO is nil, uid:%s", slot0._viewBuildingUid))
	end

	return slot0._viewBuildingUid, slot2
end

return slot0
