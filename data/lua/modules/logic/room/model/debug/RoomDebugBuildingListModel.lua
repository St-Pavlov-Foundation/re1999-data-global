module("modules.logic.room.model.debug.RoomDebugBuildingListModel", package.seeall)

slot0 = class("RoomDebugBuildingListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0:_clearData()
end

function slot0.reInit(slot0)
	slot0:_clearData()
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)
	slot0:_clearData()
end

function slot0._clearData(slot0)
	slot0._selectBuildingId = nil
end

function slot0.setDebugBuildingList(slot0)
	slot1 = {}

	for slot6, slot7 in pairs(RoomConfig.instance:getBuildingConfigList()) do
		slot8 = RoomDebugBuildingMO.New()

		slot8:init({
			id = slot7.id
		})
		table.insert(slot1, slot8)
	end

	table.sort(slot1, slot0._sortFunction)
	slot0:setList(slot1)
	slot0:_refreshSelect()
end

function slot0._sortFunction(slot0, slot1)
	return slot0.id < slot1.id
end

function slot0.clearSelect(slot0)
	for slot4, slot5 in ipairs(slot0._scrollViews) do
		slot5:setSelect(nil)
	end

	slot0._selectBuildingId = nil
end

function slot0._refreshSelect(slot0)
	slot1 = nil

	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7.id == slot0._selectBuildingId then
			slot1 = slot7
		end
	end

	for slot6, slot7 in ipairs(slot0._scrollViews) do
		slot7:setSelect(slot1)
	end
end

function slot0.setSelect(slot0, slot1)
	slot0._selectBuildingId = slot1

	slot0:_refreshSelect()
end

function slot0.getSelect(slot0)
	return slot0._selectBuildingId
end

function slot0.initDebugBuilding(slot0)
	slot0:setDebugBuildingList()
end

slot0.instance = slot0.New()

return slot0
