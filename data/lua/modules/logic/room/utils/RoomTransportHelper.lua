module("modules.logic.room.utils.RoomTransportHelper", package.seeall)

return {
	_pathBuidingTypeList = nil,
	_pathBuidingTypesDict = nil,
	_stieBuidingTypeList = nil,
	_initPathParam = function ()
		if not uv0._pathBuidingTypeList then
			slot0 = {
				{
					RoomBuildingEnum.BuildingType.Collect,
					RoomBuildingEnum.BuildingType.Process
				},
				{
					RoomBuildingEnum.BuildingType.Process,
					RoomBuildingEnum.BuildingType.Manufacture
				},
				{
					RoomBuildingEnum.BuildingType.Manufacture,
					RoomBuildingEnum.BuildingType.Collect
				}
			}
			uv0._pathBuidingTypeList = slot0
			uv0._pathBuidingTypesDict = {}
			uv0._stieBuidingTypeList = {}

			for slot4, slot5 in ipairs(slot0) do
				slot6 = {}
				slot7 = slot5[1]

				tabletool.addValues(slot6, slot5)

				uv0._pathBuidingTypesDict[slot7] = slot6

				table.insert(uv0._stieBuidingTypeList, slot7)
			end
		end
	end,
	getPathBuildingTypesList = function ()
		uv0._initPathParam()

		return uv0._pathBuidingTypeList
	end,
	getSiteBuildingTypeList = function ()
		uv0._initPathParam()

		return uv0._stieBuidingTypeList
	end,
	getPathBuildingTypes = function (slot0)
		uv0._initPathParam()

		return uv0._pathBuidingTypesDict[slot0]
	end,
	getVehicleCfgByBuildingId = function (slot0, slot1)
		if not RoomConfig.instance:getBuildingConfig(slot0) then
			return
		end

		if not RoomConfig.instance:getVehicleConfig(RoomConfig.instance:getBuildingSkinConfig(slot1) and slot3.vehicleId or slot2.vehicleId) and slot2.buildingType == RoomBuildingEnum.BuildingType.Transport then
			logError(string.format("运输建筑【%s %s】找不到交通工具配置[%s]", slot2.name, slot2.id, slot4))
		end

		return slot5
	end,
	getSiteFromToByType = function (slot0)
		if uv0.getPathBuildingTypes(slot0) then
			return slot1[1], slot1[2]
		end
	end,
	getSiltParamBy2PathMO = function (slot0, slot1)
		slot2, slot3 = nil
		slot5 = slot0:getLastHexPoint()

		if slot0:getFirstHexPoint() == slot1:getFirstHexPoint() or slot4 == slot1:getLastHexPoint() then
			slot2 = slot4
		elseif slot5 == slot6 or slot5 == slot7 then
			slot2 = slot5
		end

		if slot0.fromType == slot1.fromType or slot0.fromType == slot1.toType then
			slot3 = slot0.fromType
		elseif slot0.toType == slot1.fromType or slot0.toType == slot1.toType then
			slot3 = slot0.toType
		end

		slot8 = RoomMapBuildingAreaModel.instance:getAreaMOByBType(slot3)

		if slot2 ~= nil and slot8 and slot8:isInRangesByHexPoint(slot2) then
			return slot3, slot2
		end

		return nil, 
	end,
	fromTo2SiteType = function (slot0, slot1)
		for slot6, slot7 in ipairs(uv0.getSiteBuildingTypeList()) do
			slot8, slot9 = uv0.getSiteFromToByType(slot7)

			if slot8 == slot0 and slot9 == slot1 or slot9 == slot0 and slot8 == slot1 then
				return slot7
			end
		end
	end,
	canPathByHexPoint = function (slot0, slot1)
		return uv0.canPathByBlockMO(RoomMapBlockModel.instance:getBlockMO(slot0.hexX, slot0.hexY), slot1)
	end,
	canPathByhexXY = function (slot0, slot1, slot2)
		return uv0.canPathByBlockMO(RoomMapBlockModel.instance:getBlockMO(slot0, slot1), slot2)
	end,
	canSiteByHexPoint = function (slot0, slot1)
		if not slot0 then
			return false
		end

		if RoomMapBuildingAreaModel.instance:getAreaMOByBType(slot1) and slot2:isInRangesByHexPoint(slot0) then
			slot3 = RoomMapTransportPathModel.instance
			slot5 = false

			for slot9, slot10 in ipairs(uv0.getSiteBuildingTypeList()) do
				slot11 = slot3:getSiteHexPointByType(slot10)

				if slot1 == slot10 then
					slot5 = true
				elseif slot11 and HexPoint.Distance(slot11, slot0) < 2 then
					return false
				end
			end

			return slot5
		end

		return false
	end,
	canPathByBlockMO = function (slot0, slot1)
		if not slot0 or not slot0:isInMapBlock() then
			return false
		end

		if slot0.packageId == RoomBlockPackageEnum.ID.RoleBirthday then
			return false
		end

		if RoomBuildingHelper.isInInitBlock(slot0.hexPoint) then
			return false
		end

		if RoomMapBuildingModel.instance:getBuildingParam(slot2.x, slot2.y) then
			if slot1 == nil then
				slot1 = RoomMapTransportPathModel.instance:getIsRemoveBuilding()
			end

			if RoomMapBuildingModel.instance:getBuildingMOById(slot3.buildingUid) and slot4.config and not RoomBuildingEnum.CanDateleBuildingType[slot5.buildingType] then
				return false
			end

			if slot1 ~= true then
				return false
			end
		end

		return true
	end,
	initTransportPathModel = function (slot0, slot1)
		slot2 = {}

		if slot1 then
			for slot6 = 1, #slot1 do
				slot8 = slot0:getById(slot1[slot6].id) or RoomTransportPathMO.New()

				slot8:setId(slot7.id)
				slot8:setServerRoadInfo(slot7)
				table.insert(slot2, slot8)
			end
		end

		slot0:setList(slot2)
	end,
	serverRoadInfo2Info = function (slot0)
		slot1 = {
			fromType = slot0.fromType or 0,
			toType = slot0.toType or 0,
			critterUid = slot0.critterUid or 0,
			buildingUid = slot0.buildingUid or 0,
			blockCleanType = slot0.blockCleanType or 0,
			buildingId = slot0.buildingDefineId or slot0.buildingId or 0,
			buildingSkinId = slot0.skinId or slot0.buildingSkinId,
			hexPointList = {},
			id = slot0.id
		}
		slot5 = RoomMapHexPointModel.instance

		if slot0.roadPoints then
			for slot9, slot10 in ipairs(slot0.roadPoints) do
				table.insert(slot2, slot5:getHexPoint(slot10.x, slot10.y))
			end
		end

		return slot1
	end,
	findInfoInListByType = function (slot0, slot1, slot2)
		if not slot0 or #slot0 < 1 then
			return nil
		end

		for slot6 = 1, #slot0 do
			if slot0[slot6].fromType == slot1 and slot7.toType == slot2 or slot7.fromType == slot2 and slot7.toType == slot1 then
				return slot7, slot6
			end
		end

		return nil
	end,
	getBuildingTypeListByHexPoint = function (slot0, slot1)
		slot2 = {}

		if RoomMapTransportPathModel.instance:getSiteTypeByHexPoint(slot0) and slot4 ~= 0 then
			if not (slot1 and #slot1 > 0) or tabletool.indexOf(slot1, slot4) then
				table.insert(slot2, slot4)
			end

			return slot2
		end

		for slot9 = 1, #RoomMapBuildingAreaModel.instance:getList() do
			slot11 = slot5[slot9].buildingType

			if (not slot3 or tabletool.indexOf(slot1, slot11)) and slot10:isInRangesByHexPoint(slot0) then
				table.insert(slot2, slot11)
			end
		end

		for slot9 = #slot2, 1, -1 do
			if RoomMapTransportPathModel.instance:getSiteHexPointByType(slot2[slot9]) and slot10 ~= slot0 then
				table.remove(slot2, slot9)
			end
		end

		return slot2
	end,
	getBuildingTypeByHexPoint = function (slot0, slot1)
		return uv0.getBuildingAreaByHexPoint(slot0, slot1) and slot2.buildingType or 0
	end,
	getBuildingAreaByHexPoint = function (slot0, slot1)
		slot2 = RoomMapBuildingAreaModel.instance:getList()

		for slot7 = 1, #slot2 do
			slot8 = slot2[slot7]

			if (not (slot1 and #slot1 > 0) or tabletool.indexOf(slot1, slot8.buildingType)) and slot8:isInRangesByHexPoint(slot0) then
				return slot8
			end
		end
	end,
	getBuildingAreaByHexXY = function (slot0, slot1)
		for slot6 = 1, #RoomMapBuildingAreaModel.instance:getList() do
			if slot2[slot6]:isInRangesByHexXY(slot0, slot1) then
				return slot7
			end
		end
	end,
	checkBuildingInLoad = function (slot0, slot1, slot2)
		if RoomMapModel.instance:getBuildingPointList(slot0, slot2) then
			slot4 = nil

			for slot8 = 1, #slot3 do
				slot4 = slot3[slot8]

				if uv0.checkInLoadHexXY(slot4.x + slot1.x, slot4.y + slot1.y) then
					return true
				end
			end
		end

		return false
	end,
	checkInLoadHexXY = function (slot0, slot1)
		for slot6 = 1, #RoomTransportPathModel.instance:getTransportPathMOList() do
			if slot2[slot6]:checkHexXY(slot0, slot1) then
				return true
			end
		end

		return false
	end,
	saveQuickLink = function (slot0, slot1)
		if slot0 then
			RoomHelper.setNumberByKey(PlayerPrefsKey.RoomTransportPathQuickLinkKey .. slot0, slot1 and 1 or 0)
		end
	end,
	getIsQuickLink = function (slot0)
		if slot0 and RoomHelper.getNumberByKey(PlayerPrefsKey.RoomTransportPathQuickLinkKey .. slot0) == 1 then
			return true
		end

		return false
	end
}
