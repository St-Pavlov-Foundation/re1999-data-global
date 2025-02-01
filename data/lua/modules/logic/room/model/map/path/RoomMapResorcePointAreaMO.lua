module("modules.logic.room.model.map.path.RoomMapResorcePointAreaMO", package.seeall)

slot0 = pureTable("RoomMapResorcePointAreaMO")

function slot0.init(slot0, slot1, slot2)
	slot0.id = slot1
	slot0.resourceId = slot2
	slot0._resPointMap = {}
	slot0._resPointList = {}
	slot0._directionConnectsDic = slot0._directionConnectsDic or {}
	slot0._areaIdMap = {}
	slot0._areaPointList = {}
	slot0._isNeedUpdateAreaIdMap = false
end

function slot0.addResPoint(slot0, slot1)
	if slot0:_getResPointValue(slot0._resPointMap, slot1.x, slot1.y, slot1.direction) then
		tabletool.removeValue(slot0._resPointList, slot5)
	else
		slot0._isNeedUpdateAreaIdMap = true
	end

	slot0:_addResPointValue(slot0._resPointMap, slot2, slot3, slot4, slot1)
	table.insert(slot0._resPointList, slot1)
end

function slot0.removeByXYD(slot0, slot1, slot2, slot3)
	if slot0:_getResPointValue(slot0._resPointMap, slot1, slot2, slot3) then
		tabletool.removeValue(slot0._resPointList, slot4)

		slot0._isNeedUpdateAreaIdMap = true
	end
end

function slot0.removeByXY(slot0, slot1, slot2)
	if slot0._resPointMap[slot1] and slot0._resPointMap[slot1][slot2] then
		slot0._resPointMap[slot1][slot2] = nil
		slot4 = nil

		for slot9 = #slot0._resPointList, 1, -1 do
			if slot3[slot9].x == slot1 and slot4.y == slot2 then
				slot3[slot9] = slot3[slot5]

				table.remove(slot3, slot5)

				slot5 = slot5 - 1
			end
		end

		slot0._isNeedUpdateAreaIdMap = true
	end
end

function slot0.getAreaIdByXYD(slot0, slot1, slot2, slot3)
	return slot0:_getResPointValue(slot0:getAreaIdMap(), slot1, slot2, slot3)
end

function slot0.getResorcePiontListByXYD(slot0, slot1, slot2, slot3)
	if slot0:getAreaIdByXYD(slot1, slot2, slot3) then
		return slot0._areaPointList[slot4]
	end

	return nil
end

function slot0._checkUpdateArea(slot0)
	if slot0._isNeedUpdateAreaMap then
		return
	end

	slot2 = {}
	slot4 = slot0._resPointMap

	for slot8 = 1, #slot0._resPointList do
		slot9 = slot3[slot8]

		slot0:_addResPointValue({}, slot9.x, slot9.y, slot9.direction, -1)
	end

	for slot9 = 1, #slot3 do
		slot10 = slot3[slot9]

		if slot0:_getResPointValue(slot1, slot10.x, slot10.y, slot10.direction) == -1 then
			slot12 = {}

			table.insert(slot2, slot12)
			slot0:_searchArea(0 + 1, slot10, slot1, slot4, slot12)
		end
	end

	slot0._isNeedUpdateAreaMap = false
	slot0._areaIdMap = slot1
	slot0._areaPointList = slot2
end

function slot0.getAreaIdMap(slot0)
	slot0:_checkUpdateArea()

	return slot0._areaIdMap
end

function slot0.findeArea(slot0)
	slot0:_checkUpdateArea()

	return slot0._areaPointList
end

function slot0._searchArea(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0:_getResPointValue(slot3, slot2.x, slot2.y, slot2.direction) == -1 then
		slot0:_addResPointValue(slot3, slot2.x, slot2.y, slot2.direction, slot1)

		if slot5 then
			table.insert(slot5, slot2)
		end

		for slot11, slot12 in ipairs(slot0:getConnectsAll(slot2.direction)) do
			if slot0:_getResPointValue(slot4, slot2.x + slot12.x, slot2.y + slot12.y, slot12.direction) then
				slot0:_searchArea(slot1, slot13, slot3, slot4, slot5)
			end
		end
	end
end

function slot0.getConnectsAll(slot0, slot1)
	if not slot0._directionConnectsDic[slot1] then
		slot0._directionConnectsDic[slot1] = ResourcePoint(HexPoint(0, 0), slot1):GetConnectsAll()
	end

	return slot0._directionConnectsDic[slot1]
end

function slot0._addResPointValue(slot0, slot1, slot2, slot3, slot4, slot5)
	slot1[slot2] = slot1[slot2] or {}
	slot1[slot2][slot3] = slot1[slot2][slot3] or {}
	slot1[slot2][slot3][slot4] = slot5
end

function slot0._getResPointValue(slot0, slot1, slot2, slot3, slot4)
	return slot1[slot2] and slot1[slot2][slot3] and slot1[slot2][slot3][slot4]
end

return slot0
