module("modules.logic.room.model.map.RoomMapTransportPathModel", package.seeall)

slot0 = class("RoomMapTransportPathModel", BaseModel)

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
	slot0._siteHexPointDict = {}
	slot0._buildingTypesDict = {}
	slot0._opParams = {}
end

function slot0.removeByIds(slot0, slot1)
	if slot1 and #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			slot0:remove(slot0:getById(slot6))
		end
	end
end

function slot0.updateInofoById(slot0, slot1, slot2)
	if slot0:getById(slot1) and slot2 then
		slot3:updateInfo(slot2)
	end
end

function slot0.getTransportPathMOByCritterUid(slot0, slot1)
	for slot6 = 1, #slot0:getList() do
		if slot2[slot6] and slot7.critterUid == slot1 then
			return slot7
		end
	end
end

function slot0.getTransportPathMOByBuildingUid(slot0, slot1)
	for slot6 = 1, #slot0:getList() do
		if slot2[slot6] and slot7.buildingUid == slot1 then
			return slot7
		end
	end
end

function slot0.getTransportPathMO(slot0, slot1)
	return slot0:getById(slot1)
end

function slot0.getTransportPathMOList(slot0)
	return slot0:getList()
end

function slot0.initPath(slot0, slot1)
	RoomTransportHelper.initTransportPathModel(slot0, slot1)

	slot0._buildingTypesDict = {}
end

function slot0.resetByTransportPathMOList(slot0, slot1)
	slot2 = {}

	if slot1 then
		for slot6 = 1, #slot1 do
			if not slot0:getByIndex(slot1[slot6].id) then
				RoomTransportPathMO.New():setId(-slot6)
			end

			slot8:setIsEdit(false)
			slot8:setIsQuickLink(nil)
			slot8:updateInfo(slot7)
			table.insert(slot2, slot8)
		end
	end

	slot0:setList(slot2)
end

function slot0.updateSiteHexPoint(slot0)
	slot0._siteHexPointDict = {}
	slot2 = {}

	for slot6 = 1, #slot0:getList() do
		if slot1[slot6] and slot7:isLinkFinish() then
			table.insert(slot2, slot7)
		end
	end

	for slot6 = 1, #slot2 do
		for slot11 = slot6 + 1, #slot2 do
			slot12, slot13 = RoomTransportHelper.getSiltParamBy2PathMO(slot2[slot6], slot2[slot11])

			if slot12 ~= nil and slot13 ~= nil then
				slot0._siteHexPointDict[slot12] = slot13
			end
		end
	end

	for slot6 = 1, #slot2 do
		slot7 = slot2[slot6]

		slot7:checkTempTypes({
			slot7.fromType,
			slot7.toType
		})
	end

	for slot7 = 1, #RoomTransportHelper.getPathBuildingTypesList() do
		slot8 = slot3[slot7]

		if slot0:getTransportPathMOBy2Type(slot8[1], slot8[2]) and slot11:isLinkFinish() then
			slot0._siteHexPointDict[slot11.fromType] = slot0._siteHexPointDict[slot11.fromType] or slot11:getFirstHexPoint()
			slot0._siteHexPointDict[slot11.toType] = slot0._siteHexPointDict[slot11.toType] or slot11:getLastHexPoint()
		end
	end
end

function slot0.getSiteHexPointByType(slot0, slot1)
	return slot0._siteHexPointDict and slot0._siteHexPointDict[slot1]
end

function slot0.getSiteTypeByHexPoint(slot0, slot1)
	if slot0._siteHexPointDict and slot1 then
		for slot5, slot6 in pairs(slot0._siteHexPointDict) do
			if slot1 == slot6 then
				return slot5
			end
		end
	end

	return 0
end

function slot0.setSiteHexPointByType(slot0, slot1, slot2)
	slot0._siteHexPointDict = slot0._siteHexPointDict or {}
	slot0._siteHexPointDict[slot1] = slot2
end

function slot0.isHasEdit(slot0)
	for slot5, slot6 in ipairs(slot0:getList()) do
		if slot6:getIsEdit() then
			return true
		end
	end

	return false
end

function slot0.setSelectBuildingType(slot0, slot1)
	slot0._selectBuildingType = slot1
end

function slot0.getSelectBuildingType(slot0)
	return slot0._selectBuildingType
end

function slot0.setOpParam(slot0, slot1, slot2)
	slot0._opParams = slot0._opParams or {}
	slot0._opParams.isDragPath = slot1 == true
	slot0._opParams.siteType = slot2
end

function slot0.getOpParam(slot0)
	return slot0._opParams
end

function slot0.setIsRemoveBuilding(slot0, slot1)
	slot0._isRemoveBuilding = slot1
end

function slot0.getIsRemoveBuilding(slot0)
	return slot0._isRemoveBuilding
end

function slot0.placeTempTransportPathMO(slot0)
	slot0._tempTransportPathMO = nil
end

function slot0.getTempTransportPathMO(slot0)
	return slot0._tempTransportPathMO
end

function slot0.addTempTransportPathMO(slot0, slot1, slot2, slot3)
	if not (slot0:getTransportPathMOBy2Type(slot2, slot3) or slot0:_findTransportPathMOByHexPoint(slot1, false)) then
		slot5 = nil

		if slot2 and slot3 then
			slot5 = {
				slot2,
				slot3
			}
		end

		slot4 = slot0:_createTempTransportPathMOByHexPoint(slot1, slot5)
	end

	slot0._tempTransportPathMO = slot4

	return slot4
end

function slot0.getTransportPathMOByHexPoint(slot0, slot1, slot2)
	return slot0:_findTransportPathMOByHexPoint(slot1, slot2)
end

function slot0.getTransportPathMOListByHexPoint(slot0, slot1, slot2)
	slot3 = nil

	for slot8 = 1, #slot0:getList() do
		slot9 = slot4[slot8]

		if (slot2 == nil or slot2 == slot9:isLinkFinish()) and slot9:checkHexPoint(slot1) then
			table.insert(slot3 or {}, slot9)
		end
	end

	return slot3
end

function slot0.getLinkFinishCount(slot0)
	return slot0:_countTransportPathMO(nil, true)
end

function slot0.getLinkFailCount(slot0)
	return slot0:getMaxCount() - slot0:getLinkFinishCount()
end

function slot0.getTransportPathMOBy2Type(slot0, slot1, slot2)
	for slot7 = 1, #slot0:getList() do
		if slot3[slot7]:checkSameType(slot1, slot2) then
			return slot8
		end
	end
end

function slot0._countTransportPathMO(slot0, slot1, slot2)
	for slot8 = 1, #slot0:getList() do
		slot9 = slot3[slot8]

		if (slot1 == nil or slot9:checkHexPoint(slot1)) and (slot2 == nil or slot2 == slot9:isLinkFinish()) then
			slot4 = 0 + 1
		end
	end

	return slot4
end

function slot0._findTransportPathMOByHexPoint(slot0, slot1, slot2)
	for slot7 = 1, #slot0:getList() do
		if slot3[slot7]:checkHexPoint(slot1) and (slot2 == nil or slot2 == slot8:isLinkFinish()) then
			return slot8
		end
	end
end

function slot0._createTempTransportPathMOByHexPoint(slot0, slot1, slot2)
	if not RoomTransportHelper.getBuildingTypeListByHexPoint(slot1, slot2) or #slot3 < 1 then
		return nil
	end

	slot4 = nil

	for slot9 = 1, #slot0:getList() do
		if slot5[slot9]:getHexPointCount() < 1 then
			slot5[slot9]:addHexPoint(slot1)

			break
		end
	end

	if not slot4 and slot0:getCount() < slot0:getMaxCount() then
		RoomTransportPathMO.New():init()

		slot6 = 0

		while slot0:getById(slot6) ~= nil do
			slot6 = slot6 - 1
		end

		slot4:setId(slot6)
		slot4:addHexPoint(slot1)
		slot0:addAtLast(slot4)
	end

	return slot4
end

function slot0.getMaxCount(slot0)
	slot1 = RoomMapBuildingAreaModel.instance:getCount() - 1

	return (slot1 + 1) * slot1 * 0.5
end

slot0.instance = slot0.New()

return slot0
