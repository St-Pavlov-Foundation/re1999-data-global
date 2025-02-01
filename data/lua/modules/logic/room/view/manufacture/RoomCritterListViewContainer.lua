module("modules.logic.room.view.manufacture.RoomCritterListViewContainer", package.seeall)

slot0 = class("RoomCritterListViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#go_critter/#scroll_critter"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "#go_critter/#scroll_critter/viewport/content/#go_critterItem"
	slot2.cellClass = RoomManufactureCritterItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 648
	slot2.cellHeight = 175
	slot2.cellSpaceV = 10

	table.insert(slot1, LuaListScrollView.New(ManufactureCritterListModel.instance, slot2))
	table.insert(slot1, RoomCritterListView.New())

	return slot1
end

function slot0.onContainerInit(slot0)
	slot1, slot2 = nil

	if slot0.viewParam then
		slot2 = slot0.viewParam.buildingUid
		slot1 = slot0.viewParam.pathId
	end

	if not slot2 and not slot1 then
		logError("RoomCritterListViewContainer:onContainerInit,error, no buildingUid and no pathId")
	end

	slot0:setContainerViewBelongId(slot2, slot1)
end

function slot0.onContainerClose(slot0)
	slot0:setContainerViewBelongId()
end

function slot0.setContainerViewBelongId(slot0, slot1, slot2)
	slot0._isTransport = false

	if not slot1 and slot2 then
		slot0._isTransport = true
	end

	slot0._viewBelongId = slot1 or slot2
end

function slot0.getContainerPathId(slot0)
	if slot0._isTransport then
		return slot0._viewBelongId
	end
end

function slot0.getContainerViewBuilding(slot0, slot1)
	slot4 = slot0._isTransport and slot5 and slot5.buildingId or RoomMapBuildingModel.instance:getBuildingMOById(slot0._viewBelongId) and slot3.buildingId

	if not nil and slot1 then
		logError(string.format("RoomCritterListViewContainer:getContainerViewBuilding error, buildingMO is nil, id:%s  isTransport:%s", slot0._viewBelongId, slot0._isTransport))
	end

	return slot2, slot3, slot4
end

return slot0
