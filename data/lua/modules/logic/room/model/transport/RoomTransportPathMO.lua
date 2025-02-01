module("modules.logic.room.model.transport.RoomTransportPathMO", package.seeall)

slot0 = pureTable("RoomTransportPathMO")

function slot0.init(slot0, slot1)
	slot0.hexPointList = {}

	slot0:setId(slot1 and slot1.id)
end

function slot0.setId(slot0, slot1)
	slot0.id = slot1 or 0
end

function slot0.updateCritterInfo(slot0, slot1)
	slot0.critterUid = slot1.critterUid or slot0.critterUid or 0

	if tonumber(slot0.critterUid) == 0 then
		slot0.critterUid = 0
	end
end

function slot0.updateBuildingInfo(slot0, slot1)
	slot0.buildingUid = slot1.buildingUid or slot0.buildingUid or 0
	slot0.buildingId = slot1.buildingId or slot1.buildingDefineId or slot0.buildingId or 0
	slot0.buildingSkinId = slot1.buildingSkinId or slot1.skinId or slot0.buildingSkinId or 0
end

function slot0.updateInfo(slot0, slot1)
	slot0.fromType = slot1.fromType or slot0.fromType or 0
	slot0.toType = slot1.toType or slot0.toType or 0
	slot0.blockCleanType = slot1.blockCleanType or slot0.blockCleanType or 0

	slot0:updateCritterInfo(slot1)
	slot0:updateBuildingInfo(slot1)

	if slot1.hexPointList then
		slot0.hexPointList = {}

		tabletool.addValues(slot0.hexPointList, slot2)
	end
end

function slot0.setServerRoadInfo(slot0, slot1)
	slot0:updateInfo(RoomTransportHelper.serverRoadInfo2Info(slot1))
end

function slot0.checkSameType(slot0, slot1, slot2)
	if slot0.fromType == slot1 and slot0.toType == slot2 or slot0.fromType == slot2 and slot0.toType == slot1 then
		return true
	end

	return false
end

function slot0.isLinkFinish(slot0)
	if not slot0.fromType or not slot0.toType or slot0.fromType == slot0.toType then
		return false
	end

	if RoomBuildingEnum.BuildingArea[slot0.fromType] and RoomBuildingEnum.BuildingArea[slot0.toType] then
		return true
	end

	return false
end

function slot0.getHexPointList(slot0)
	return slot0.hexPointList
end

function slot0.getHexPointCount(slot0)
	return slot0.hexPointList and #slot0.hexPointList or 0
end

function slot0.setHexPointList(slot0, slot1)
	slot0.hexPointList = {}

	tabletool.addValues(slot0.hexPointList, slot1)
end

function slot0.getLastHexPoint(slot0)
	return slot0.hexPointList[#slot0.hexPointList]
end

function slot0.getFirstHexPoint(slot0)
	return slot0.hexPointList[1]
end

function slot0.changeBenEnd(slot0)
	if slot0.hexPointList and #slot0.hexPointList > 1 then
		slot0.fromType = slot0.toType
		slot0.toType = slot0.fromType

		for slot7 = 1, math.floor(#slot0.hexPointList * 0.5) do
			slot9 = slot2 - slot7 + 1
			slot0.hexPointList[slot7] = slot0.hexPointList[slot9]
			slot0.hexPointList[slot9] = slot0.hexPointList[slot7]
		end
	end
end

function slot0.removeLastHexPoint(slot0)
	if slot0:getHexPointCount() > 0 then
		table.remove(slot0.hexPointList, slot1)
	end
end

function slot0.setIsEdit(slot0, slot1)
	slot0._isEdit = slot1
end

function slot0.getIsEdit(slot0)
	return slot0._isEdit
end

function slot0.setIsQuickLink(slot0, slot1)
	slot0._isQuickLink = slot1
end

function slot0.getIsQuickLink(slot0)
	return slot0._isQuickLink
end

function slot0.addHexPoint(slot0, slot1)
	if slot0:isCanAddHexPoint(slot1) then
		table.insert(slot0.hexPointList, slot1)

		return true
	end

	return false
end

function slot0.isCanAddHexPoint(slot0, slot1)
	if not slot1 or slot0:checkHexPoint(slot1) then
		return false
	end

	if slot0:getLastHexPoint() == nil or HexPoint.Distance(slot2, slot1) == 1 then
		return true
	end

	return false
end

function slot0.checkHexPoint(slot0, slot1)
	if slot1 then
		return slot0:checkHexXY(slot1.x, slot1.y)
	end

	return false
end

function slot0.checkHexXY(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0.hexPointList) do
		if slot7.x == slot1 and slot7.y == slot2 then
			return true, slot6
		end
	end

	return false
end

function slot0.checkTempTypes(slot0, slot1)
	slot0.tempFromTypes = RoomTransportHelper.getBuildingTypeListByHexPoint(slot0:getFirstHexPoint(), slot1)
	slot0.tempToTypes = RoomTransportHelper.getBuildingTypeListByHexPoint(slot0:getLastHexPoint(), slot1)
	slot0.fromType, slot0.toType = slot0:_find2ListValue(slot0.tempFromTypes, slot0.tempToTypes, 0)
end

function slot0._find2ListValue(slot0, slot1, slot2, slot3)
	for slot7 = 1, #slot1 do
		for slot11 = 1, #slot2 do
			if slot1[slot7] ~= slot2[slot11] then
				return slot1[slot7], slot2[slot11]
			end
		end
	end

	return slot1[1] or slot3, slot2[1] or slot3
end

function slot0.isTransporting(slot0)
	slot1 = false

	if slot0:hasCritterWorking() then
		if ManufactureModel.instance:isAreaHasManufactureRunning(slot0.fromType) or ManufactureModel.instance:isAreaHasManufactureRunning(slot0.toType) then
			slot1 = true
		end
	end

	return slot1
end

function slot0.hasCritterWorking(slot0)
	slot1 = 0

	if CritterModel.instance:getCritterMOByUid(slot0.critterUid) then
		slot1 = slot2:getMoodValue()
	end

	return slot1 > 0
end

function slot0.clear(slot0)
	if slot0.hexPointList and #slot0.hexPointList > 0 then
		slot0.hexPointList = {}
		slot0.fromType = 0
		slot0.toType = 0
	end
end

return slot0
