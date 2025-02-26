module("modules.logic.room.model.map.RoomMapBuildingAreaMO", package.seeall)

slot0 = pureTable("RoomMapBuildingAreaMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.uid
	slot0.buildingType = slot1.config.buildingType

	slot0:setMainBuildingMO(slot1)
end

function slot0.setMainBuildingMO(slot0, slot1)
	slot0.mainBuildingMO = slot1

	slot0:clearRangesHexList()
	slot0:clearBuildingMOList()
end

function slot0.getMainBuildingCfg(slot0)
	if slot0.mainBuildingMO then
		return slot0.mainBuildingMO.config
	end
end

function slot0.getRangesHexPointList(slot0)
	if slot0.mainBuildingMO then
		slot2 = slot0.mainBuildingMO.hexPoint
		slot3 = slot0.mainBuildingMO.rotate

		if slot0._builingId ~= slot0.mainBuildingMO.buildingId or slot0._rotate ~= slot3 or slot0._hexPoint ~= slot2 then
			slot0._builingId = slot1
			slot0._hexPoint = slot2
			slot0._rotate = slot3
			slot0._rangsHexList = slot0:_findBuildingInRanges(slot1, slot2, slot3, RoomBuildingEnum.BuildingAreaRange or 1)
		end
	else
		slot0:clearRangesHexList()
	end

	return slot0._rangsHexList
end

function slot0.isInRangesByHexPoint(slot0, slot1)
	if slot1 and slot0:isInRangesByHexXY(slot1.x, slot1.y) then
		return true
	end

	return false
end

function slot0.isInRangesByHexXY(slot0, slot1, slot2)
	slot4 = nil

	for slot8 = 1, #slot0:getRangesHexPointList() do
		if slot3[slot8].x == slot1 and slot4.y == slot2 then
			return true
		end
	end

	return false
end

function slot0.clearRangesHexList(slot0)
	if slot0._rangsHexList and #slot0._rangsHexList > 0 then
		slot0._rangsHexList = {}
	end

	slot0._builingId = 0
	slot0._rotate = 0
	slot0._hexPoint = nil
end

function slot0.getBuildingMOList(slot0, slot1)
	if not slot0._buildingMOList then
		slot0._buildingMOList = slot0:_findMapBuildingMOList()
		slot0._buildingMOWithMainList = {
			slot0.mainBuildingMO
		}

		tabletool.addValues(slot0._buildingMOWithMainList, slot0._buildingMOList)
	end

	if slot1 then
		return slot0._buildingMOWithMainList
	end

	return slot0._buildingMOList
end

function slot0.clearBuildingMOList(slot0)
	slot0._buildingMOList = nil
end

function slot0._findMapBuildingMOList(slot0)
	if not slot0.mainBuildingMO then
		return {}
	end

	for slot7 = 1, #slot0:getRangesHexPointList() do
		if slot2[slot7] and RoomMapBuildingModel.instance:getBuildingMO(slot8.x, slot8.y) and slot9:checkSameType(slot0.buildingType) and not tabletool.indexOf(slot1, slot9) then
			table.insert(slot1, slot9)
		end
	end

	return slot1
end

function slot0.getBuildingType(slot0)
	return slot0.buildingType
end

function slot0._findBuildingInRanges(slot0, slot1, slot2, slot3, slot4)
	slot6 = {}

	for slot11 = 1, #RoomMapModel.instance:getBuildingPointList(slot1, slot3 or 0) do
		slot12 = (slot2 or HexPoint(0, 0)) + slot7[slot11]

		table.insert({}, slot12)
		tabletool.addValues(slot6, slot12:inRanges(slot4 or 1, true))
	end

	for slot11 = #slot6, 1, -1 do
		if tabletool.indexOf(slot5, slot6[slot11]) then
			table.remove(slot6, slot11)
		end
	end

	return slot6
end

return slot0
