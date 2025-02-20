module("modules.logic.room.model.map.path.RoomMapVehicleModel", package.seeall)

slot0 = class("RoomMapVehicleModel", BaseModel)

function slot0.ctor(slot0)
	uv0.super:ctor(slot0)
	slot0:_clearData()
end

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
	slot0._buildingUidToVehicleIdDic = {}
	slot0._transportSiteTypeToVehicleIdDic = {}
	slot0._resIndexDic = {}
end

function slot0.init(slot0)
	slot0:clear()
end

function slot0.initVehicle(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot0._resIndexDic = slot1

	slot0:_initBuildingVehicle(slot2, slot1, slot3)

	slot8 = slot1
	slot9 = slot3

	slot0:_initTransportSiteVehicle(slot2, slot8, slot9)

	for slot8, slot9 in ipairs(RoomMapPathPlanModel.instance:getList()) do
		slot13 = slot11 and slot11.vehicleId or 0

		if (RoomConfig.instance:getResourceConfig(slot9.resourceId) and slot11.numLimit or 0) > 0 and slot13 ~= 0 and slot12 <= slot9:getCount() and RoomConfig.instance:getVehicleConfig(slot13) then
			slot16 = RoomMapVehicleMO.New()

			slot16:init(slot0:_createMOId(slot13, slot1), slot9, slot13)
			table.insert(slot2, slot16)
		end
	end

	slot0:setList(slot2)
end

function slot0._initBuildingVehicle(slot0, slot1, slot2, slot3)
	for slot8 = 1, #RoomMapBuildingModel.instance:getBuildingMOList() do
		slot11 = slot9.config and slot9.config.vehicleId or 0
		slot12 = slot9.hexPoint

		if (slot4[slot8].config and slot9.config.vehicleType or 0) ~= 0 and slot11 ~= 0 and slot12 then
			slot16 = RoomConfig.instance:getResourceConfig(slot13.resId) and slot15.numLimit or 0
			slot17 = {}

			if RoomConfig.instance:getVehicleConfig(slot11) and RoomMapPathPlanModel.instance:getPlanMOByXY(slot12.x, slot12.y, slot13.resId) and slot16 > 0 and slot16 <= slot14:getCount() and slot0:_checkAreaByBuildingMO(slot9, slot14, slot17) then
				slot18 = RoomMapVehicleMO.New()
				slot19 = slot0:_createMOId(slot11, slot2)

				slot0:_checkAreaNodeList(slot17)
				slot18:init(slot19, slot14, slot11, slot17)

				slot18.vehicleType = slot10
				slot18.ownerType = RoomVehicleEnum.OwnerType.Building
				slot18.ownerId = slot9.id

				table.insert(slot1, slot18)

				slot0._buildingUidToVehicleIdDic[slot9.id] = slot19

				table.insert(slot3, slot14.id)
			end
		end
	end
end

function slot0._checkAreaNodeList(slot0, slot1)
	if not slot1 or #slot1 < 2 then
		return
	end

	slot2 = #slot1

	if slot1[1]:isEndNode() and not slot1[slot2]:isEndNode() then
		for slot7 = 1, math.floor(slot2 / 2) do
			slot8 = slot2 + 1 - slot7
			slot1[slot7] = slot1[slot8]
			slot1[slot8] = slot1[slot7]
		end
	end
end

function slot0._checkAreaByBuildingMO(slot0, slot1, slot2, slot3)
	if not slot1 or not slot2 then
		return false
	end

	slot4 = RoomMapModel.instance:getBuildingConfigParam(slot1.buildingId)

	for slot10, slot11 in ipairs(slot4.pointList) do
		slot12 = RoomBuildingHelper.getWorldHexPoint(slot11, slot4.centerPoint, slot1.hexPoint, slot1.rotate)

		if not slot2:getNodeByXY(slot12.x, slot12.y) then
			return false
		end

		if slot3 then
			table.insert(slot3, slot13)
		end
	end

	return true
end

function slot0._createMOId(slot0, slot1, slot2)
	slot3 = slot2[slot1] or 1
	slot2[slot1] = slot3 + 1

	return slot1 * 1000 + slot3
end

function slot0.getVehicleMOByBuilingUid(slot0, slot1)
	if slot0._buildingUidToVehicleIdDic[slot1] then
		return slot0:getById(slot0._buildingUidToVehicleIdDic[slot1])
	end
end

function slot0._initTransportSiteVehicle(slot0, slot1, slot2)
	for slot7 = 1, #RoomTransportHelper.getSiteBuildingTypeList() do
		if slot0:createVehicleMOBySiteType(slot3[slot7]) then
			table.insert(slot1, slot9)
		end
	end
end

function slot0.createVehicleMOBySiteType(slot0, slot1)
	if not slot1 then
		return
	end

	slot2, slot3 = RoomTransportHelper.getSiteFromToByType(slot1)

	if not RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(slot2, slot3) or not slot4.buildingUid or slot4.buildingUid == 0 then
		return
	end

	if not RoomTransportHelper.getVehicleCfgByBuildingId(slot4.buildingId, slot4.buildingSkinId) then
		return
	end

	slot6 = slot0._transportSiteTypeToVehicleIdDic[slot1] or slot0:_createMOId(slot2, slot0._resIndexDic)
	slot0._transportSiteTypeToVehicleIdDic[slot1] = slot6
	slot7 = RoomMapPathPlanMO.New()

	slot7:initHexPintList(slot6, RoomResourceEnum.ResourceId.Empty, slot4:getHexPointList())

	slot9 = {}
	slot11 = false

	if #slot7:getNodeList() > 0 then
		slot12 = 1

		if slot4.fromType ~= slot1 then
			slot12 = #slot10
		end

		slot13 = slot10[slot12]

		table.insert(slot9, slot13)

		if RoomMapBlockModel.instance:getBlockMO(slot13.hexPoint.x, slot13.hexPoint.y) and slot14:hasRiver() then
			slot11 = true
		end
	end

	slot12 = RoomMapVehicleMO.New()

	slot12:init(slot6, slot7, slot5.id, slot9)

	slot12.vehicleType = 1
	slot12.ownerType = RoomVehicleEnum.OwnerType.TransportSite
	slot12.ownerId = slot1

	slot12:setReplaceType(slot11 and RoomVehicleEnum.ReplaceType.Water or RoomVehicleEnum.ReplaceType.Land)

	return slot12
end

function slot0.getVehicleIdBySiteType(slot0, slot1)
	return slot0._transportSiteTypeToVehicleIdDic[slot1]
end

function slot0.getVehicleMOBySiteType(slot0, slot1)
	return slot0:getById(slot0:getVehicleIdBySiteType(slot1))
end

slot0.instance = slot0.New()

return slot0
