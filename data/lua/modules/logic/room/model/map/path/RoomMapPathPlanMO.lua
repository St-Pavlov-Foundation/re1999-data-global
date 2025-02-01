module("modules.logic.room.model.map.path.RoomMapPathPlanMO", package.seeall)

slot0 = pureTable("RoomMapPathPlanMO")

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.id = slot1
	slot0.resourceId = slot2
	slot0.resId = slot2
	slot0._mapNodeDic, slot0._nodeList = slot0:_getMapPoint(slot3, slot2)
end

function slot0.initHexPintList(slot0, slot1, slot2, slot3)
	slot0.id = slot1
	slot0.resourceId = slot2
	slot0.resId = slot2
	slot0._mapNodeDic, slot0._nodeList = slot0:_getMapHexPointList(slot3, slot2)
end

function slot0._getMapHexPointList(slot0, slot1, slot2)
	slot3 = {}
	slot4 = {}

	for slot8 = 1, #slot1 do
		slot9 = slot1[slot8]

		if RoomHelper.get2KeyValue(slot3, slot9.x, slot9.y) == nil then
			slot10 = RoomMapPathNodeMO.New()

			RoomHelper.add2KeyValue(slot3, slot9.x, slot9.y, slot10)
			slot10:init(slot8, slot9, slot2)
			table.insert(slot4, slot10)
		end

		slot0:_addLinkHexPoint(slot10, slot1[slot8 - 1])
		slot0:_addLinkHexPoint(slot10, slot1[slot8 + 1])
	end

	slot0:_updateNeighborParams(slot4, slot3)

	return slot3, slot4
end

function slot0._addLinkHexPoint(slot0, slot1, slot2)
	if slot2 and RoomTransportPathLinkHelper.findLinkDirection(slot1.hexPoint, slot2) then
		slot1:addDirection(slot3)
	end
end

function slot0._getMapPoint(slot0, slot1, slot2)
	if not slot1 or #slot1 <= 0 then
		return nil
	end

	slot3 = {}
	slot4 = {}

	for slot9, slot10 in ipairs(slot1) do
		if RoomHelper.get2KeyValue(slot3, slot10.x, slot10.y) == nil then
			slot11 = RoomMapPathNodeMO.New()

			RoomHelper.add2KeyValue(slot3, slot10.x, slot10.y, slot11)
			slot11:init(0 + 1, HexPoint(slot10.x, slot10.y), slot2)
			table.insert(slot4, slot11)
		end

		slot11:addDirection(slot10.direction)
	end

	slot0:_updateNeighborParams(slot4, slot3)

	return slot3, slot4
end

function slot0._updateNeighborParams(slot0, slot1, slot2)
	for slot6 = 1, #slot1 do
		slot7 = slot1[slot6]
		slot7.neighborNum, slot7.connectNodeNum = slot0:_findNeighborCount(slot7, slot2)
		slot7.hasBuilding = slot0:_isHasBuilding(slot7)
	end
end

function slot0._isHasBuilding(slot0, slot1)
	if RoomMapBuildingModel.instance:getBuildingParam(slot1.hexPoint.x, slot1.hexPoint.y) then
		return true
	end

	return false
end

function slot0._findNeighborCount(slot0, slot1, slot2)
	for slot9 = 1, #slot1.directionList do
		if slot0:_getNeighbor(slot1, slot2, slot5[slot9]) then
			slot3 = 0 + 1

			if slot11:isHasDirection(slot1:getConnectDirection(slot10)) then
				slot1:setConnctNode(slot10, slot11)

				slot4 = 0 + 1
			end
		end
	end

	return slot3, slot4
end

function slot0._getNeighbor(slot0, slot1, slot2, slot3)
	if HexPoint.directions[slot3] then
		return slot2[slot1.hexPoint.x + slot4.x] and slot2[slot5][slot1.hexPoint.y + slot4.y]
	end

	return nil
end

function slot0.getNodeList(slot0)
	return slot0._nodeList
end

function slot0.getCount(slot0)
	return #slot0._nodeList
end

function slot0.getNode(slot0, slot1)
	return slot0:getNodeByXY(slot1.x, slot1.y)
end

function slot0.getNodeByXY(slot0, slot1, slot2)
	return slot0._mapNodeDic[slot1] and slot0._mapNodeDic[slot1][slot2]
end

return slot0
