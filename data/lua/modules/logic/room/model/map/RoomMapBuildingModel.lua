module("modules.logic.room.model.map.RoomMapBuildingModel", package.seeall)

slot0 = class("RoomMapBuildingModel", BaseModel)

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
	slot0._mapBuildingMODict = {}
	slot0._type2BuildingDict = {}
	slot0._tempBuildingMO = nil
	slot0._allOccupyDict = nil
	slot0._canConfirmPlaceDict = nil
	slot0._revertHexPoint = nil
	slot0._revertRotate = nil
	slot0._tempOccupyDict = nil
	slot0._lightResourcePointDict = nil
	slot0._isHasCritterDict = nil
end

function slot0.initMap(slot0, slot1)
	slot0:clear()

	if not slot1 or #slot1 <= 0 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		if slot6.use then
			slot8 = RoomBuildingMO.New()

			slot8:init(RoomInfoHelper.serverInfoToBuildingInfo(slot6))

			if slot8.config then
				slot0:_addBuildingMO(slot8)
			end
		end
	end
end

function slot0._addBuildingMO(slot0, slot1)
	slot2 = slot1.hexPoint
	slot0._mapBuildingMODict[slot2.x] = slot0._mapBuildingMODict[slot2.x] or {}
	slot0._mapBuildingMODict[slot2.x][slot2.y] = slot1
	slot0._type2BuildingDict[slot3] = slot0._type2BuildingDict[slot1.config.buildingType] or {}

	table.insert(slot0._type2BuildingDict[slot3], slot1)
	slot0:addAtLast(slot1)
end

function slot0._removeBuildingMO(slot0, slot1)
	if slot0._mapBuildingMODict[slot1.hexPoint.x] then
		slot0._mapBuildingMODict[slot2.x][slot2.y] = nil
	end

	if slot0._type2BuildingDict[slot1.config.buildingType] then
		tabletool.removeValue(slot0._type2BuildingDict[slot3], slot1)
	end

	slot0:remove(slot1)
end

function slot0.removeBuildingMO(slot0, slot1)
	slot0:_removeBuildingMO(slot1)
end

function slot0.addTempBuildingMO(slot0, slot1, slot2)
	if slot0._tempBuildingMO then
		logError("暂不支持两个临时建筑")

		return
	end

	slot3 = RoomInfoHelper.buildingMOToBuildingInfo(slot1)
	slot0._tempBuildingMO = RoomBuildingMO.New()
	slot3.buildingState = RoomBuildingEnum.BuildingState.Temp
	slot3.x = slot2.x
	slot3.y = slot2.y

	slot0._tempBuildingMO:init(slot3)
	slot0:_addBuildingMO(slot0._tempBuildingMO)
	RoomResourceModel.instance:clearResourceAreaList()
	slot0:clearCanConfirmPlaceDict()
	slot0:clearTempOccupyDict()
	slot0:clearLightResourcePoint()

	return slot0._tempBuildingMO
end

function slot0.getTempBuildingMO(slot0)
	return slot0._tempBuildingMO
end

function slot0.changeTempBuildingMOUid(slot0, slot1, slot2)
	if slot0._tempBuildingMO and tonumber(slot0._tempBuildingMO.id) < 1 and slot0._tempBuildingMO.buildingId == slot2 then
		if slot0._tempBuildingMO.id ~= slot1 then
			slot0:_removeBuildingMO(slot0._tempBuildingMO)
			slot0._tempBuildingMO:setUid(slot1)
			slot0:_addBuildingMO(slot0._tempBuildingMO)
		end

		return true, slot3
	end
end

function slot0.changeTempBuildingMO(slot0, slot1, slot2)
	if not slot0._tempBuildingMO then
		return
	end

	slot0._tempBuildingMO.rotate = slot2

	if slot0._tempBuildingMO.hexPoint ~= slot1 then
		slot0:_removeBuildingMO(slot0._tempBuildingMO)

		slot0._tempBuildingMO.hexPoint = slot1

		slot0:_addBuildingMO(slot0._tempBuildingMO)
	end

	RoomResourceModel.instance:clearResourceAreaList()
	slot0:clearTempOccupyDict()
	slot0:clearLightResourcePoint()
end

function slot0.removeTempBuildingMO(slot0)
	if not slot0._tempBuildingMO then
		return
	end

	slot0:_removeBuildingMO(slot0._tempBuildingMO)

	slot0._tempBuildingMO = nil

	RoomResourceModel.instance:clearResourceAreaList()
	slot0:clearCanConfirmPlaceDict()
	slot0:clearTempOccupyDict()
	slot0:clearLightResourcePoint()
end

function slot0.placeTempBuildingMO(slot0, slot1)
	if not slot0._tempBuildingMO then
		return
	end

	slot2 = RoomBuildingMO.New()

	slot2:init(RoomInfoHelper.serverInfoToBuildingInfo(slot1))

	slot0._tempBuildingMO.uid = slot2.uid
	slot0._tempBuildingMO.buildingId = slot2.buildingId
	slot0._tempBuildingMO.rotate = slot2.rotate
	slot0._tempBuildingMO.levels = slot2.levels
	slot0._tempBuildingMO.resAreaDirection = slot2.resAreaDirection
	slot0._tempBuildingMO.buildingState = RoomBuildingEnum.BuildingState.Map
	slot0._tempBuildingMO = nil

	RoomResourceModel.instance:clearResourceAreaList()
	slot0:clearAllOccupyDict()
	slot0:clearCanConfirmPlaceDict()
	slot0:clearTempOccupyDict()
	slot0:clearLightResourcePoint()
end

function slot0.revertTempBuildingMO(slot0, slot1)
	if slot0._tempBuildingMO then
		logError("暂不支持两个临时建筑")

		return
	end

	slot0._tempBuildingMO = slot0:getBuildingMOById(slot1)

	if not slot0._tempBuildingMO then
		return
	end

	slot0._tempBuildingMO.buildingState = RoomBuildingEnum.BuildingState.Revert
	slot0._revertHexPoint = HexPoint(slot0._tempBuildingMO.hexPoint.x, slot0._tempBuildingMO.hexPoint.y)
	slot0._revertRotate = slot0._tempBuildingMO.rotate

	RoomResourceModel.instance:clearResourceAreaList()
	slot0:clearAllOccupyDict()
	slot0:clearCanConfirmPlaceDict()
	slot0:clearTempOccupyDict()
	slot0:clearLightResourcePoint()

	return slot0._tempBuildingMO
end

function slot0.removeRevertBuildingMO(slot0)
	if not slot0._tempBuildingMO then
		return
	end

	slot0._tempBuildingMO.hexPoint = slot0._revertHexPoint
	slot0._tempBuildingMO.rotate = slot0._revertRotate
	slot0._tempBuildingMO.buildingState = RoomBuildingEnum.BuildingState.Map
	slot0._tempBuildingMO = nil

	RoomResourceModel.instance:clearResourceAreaList()
	slot0:clearAllOccupyDict()
	slot0:clearCanConfirmPlaceDict()
	slot0:clearTempOccupyDict()
	slot0:clearLightResourcePoint()

	return slot0._tempBuildingMO.buildingId, slot0._revertHexPoint, slot0._revertRotate
end

function slot0.unUseRevertBuildingMO(slot0)
	if not slot0._tempBuildingMO then
		return
	end

	slot0:_removeBuildingMO(slot0._tempBuildingMO)

	slot0._tempBuildingMO = nil

	RoomResourceModel.instance:clearResourceAreaList()
	slot0:clearCanConfirmPlaceDict()
	slot0:clearTempOccupyDict()
	slot0:clearLightResourcePoint()
end

function slot0.updateBuildingLevels(slot0, slot1, slot2)
	slot0:getBuildingMOById(slot1):updateBuildingLevels(slot2)
end

function slot0.getBuildingMO(slot0, slot1, slot2)
	return slot0._mapBuildingMODict[slot1] and slot0._mapBuildingMODict[slot1][slot2]
end

function slot0.getBuildingMOList(slot0)
	return slot0:getList()
end

function slot0.getBuildingMODict(slot0)
	return slot0._mapBuildingMODict
end

function slot0.getBuildingMOById(slot0, slot1)
	return slot0:getById(slot1)
end

function slot0.getCount(slot0)
	if slot0._tempBuildingMO then
		slot1 = slot0:getCount() - 1
	end

	return slot1
end

function slot0.refreshAllOccupyDict(slot0)
	slot0._allOccupyDict = RoomBuildingHelper.getAllOccupyDict()
end

function slot0.getAllOccupyDict(slot0)
	if not slot0._allOccupyDict then
		slot0:refreshAllOccupyDict()
	end

	return slot0._allOccupyDict
end

function slot0.clearAllOccupyDict(slot0)
	slot0._allOccupyDict = nil
end

function slot0.getBuildingParam(slot0, slot1, slot2)
	if not slot0._allOccupyDict then
		slot0:refreshAllOccupyDict()
	end

	return slot0._allOccupyDict[slot1] and slot0._allOccupyDict[slot1][slot2]
end

function slot0.isHasBuilding(slot0, slot1, slot2)
	if not slot0._allOccupyDict then
		slot0:refreshAllOccupyDict()
	end

	if slot0._allOccupyDict[slot1] and slot0._allOccupyDict[slot1][slot2] then
		return true
	end

	return false
end

function slot0.refreshCanConfirmPlaceDict(slot0)
	if not slot0._tempBuildingMO then
		slot0._canConfirmPlaceDict = {}
	else
		slot0._canConfirmPlaceDict = RoomBuildingHelper.getCanConfirmPlaceDict(slot0._tempBuildingMO.buildingId, nil, , false, slot0._tempBuildingMO.levels)
	end
end

function slot0.isCanConfirm(slot0, slot1)
	if not slot0._canConfirmPlaceDict then
		slot0:refreshCanConfirmPlaceDict()
	end

	return slot0._canConfirmPlaceDict[slot1.x] and slot0._canConfirmPlaceDict[slot1.x][slot1.y]
end

function slot0.getCanConfirmPlaceDict(slot0)
	if not slot0._canConfirmPlaceDict then
		slot0:refreshCanConfirmPlaceDict()
	end

	return slot0._canConfirmPlaceDict
end

function slot0.clearCanConfirmPlaceDict(slot0)
	slot0._canConfirmPlaceDict = nil
end

function slot0.refreshTempOccupyDict(slot0)
	if slot0._tempBuildingMO then
		if RoomBuildingController.instance:isPressBuilding() and slot2 == slot0._tempBuildingMO.id then
			slot1 = RoomBuildingController.instance:getPressBuildingHexPoint() or slot0._tempBuildingMO.hexPoint
		end

		slot0._tempOccupyIndexDict = {}
		slot0._tempOccupyDict = RoomBuildingHelper.getOccupyDict(slot0._tempBuildingMO.buildingId, slot1, slot0._tempBuildingMO.rotate)
		slot3 = RoomBuildingAreaHelper.checkBuildingArea(slot0._tempBuildingMO.buildingId, slot1, slot0._tempBuildingMO.rotate)

		for slot7, slot8 in pairs(slot0._tempOccupyDict) do
			for slot12, slot13 in pairs(slot8) do
				slot0._tempOccupyIndexDict[slot13.index] = slot13
				slot13.checkBuildingAreaSuccess = slot3
			end
		end
	else
		slot0._tempOccupyDict = {}
		slot0._tempOccupyIndexDict = {}
	end
end

function slot0.isTempOccupy(slot0, slot1)
	if slot0:getTempBuildingParam(slot1.x, slot1.y) then
		return true
	end

	return false
end

function slot0.getTempBuildingParam(slot0, slot1, slot2)
	if not slot0._tempOccupyDict then
		slot0:refreshTempOccupyDict()
	end

	return slot0._tempOccupyDict[slot1] and slot0._tempOccupyDict[slot1][slot2]
end

function slot0.getTempBuildingParamByPointIndex(slot0, slot1)
	if not slot0._tempOccupyDict then
		slot0:refreshTempOccupyDict()
	end

	return slot0._tempOccupyIndexDict[slot1]
end

function slot0.clearTempOccupyDict(slot0)
	slot0._tempOccupyDict = nil
	slot0._tempOccupyIndexDict = nil
end

function slot0._refreshLightResourcePoint(slot0)
	slot0._lightResourcePointDict = {}

	if slot0._tempBuildingMO then
		for slot6, slot7 in ipairs(RoomResourceModel.instance:getResourceAreaList()) do
			if RoomBuildingHelper.checkCostResource(RoomBuildingHelper.getCostResource(slot0._tempBuildingMO.buildingId), slot7.resourceId) and RoomBuildingHelper.canContain(slot7.hexPointDict, slot0._tempBuildingMO.buildingId) then
				for slot13, slot14 in ipairs(slot7.area) do
					slot0._lightResourcePointDict[tostring(slot14)] = true
				end
			end
		end

		slot3 = RoomBuildingController.instance:isPressBuilding()
		slot4 = uv0.instance:getAllOccupyDict()
		slot9 = slot0._tempBuildingMO.buildingUid

		for slot9, slot10 in pairs(RoomBuildingHelper.getOccupyDict(slot0._tempBuildingMO.buildingId, slot0._tempBuildingMO.hexPoint, slot0._tempBuildingMO.rotate, slot9)) do
			for slot14, slot15 in pairs(slot10) do
				if slot15.buildingUid ~= slot3 then
					for slot19 = 0, 6 do
						slot0._lightResourcePointDict[tostring(ResourcePoint(HexPoint(slot9, slot14), slot19))] = nil
					end
				end
			end
		end

		for slot9, slot10 in pairs(slot4) do
			for slot14, slot15 in pairs(slot10) do
				if slot15.buildingUid ~= slot3 then
					for slot19 = 0, 6 do
						slot0._lightResourcePointDict[tostring(ResourcePoint(HexPoint(slot9, slot14), slot19))] = nil
					end
				end
			end
		end
	end
end

function slot0.isLightResourcePoint(slot0, slot1)
	if not slot0._lightResourcePointDict then
		slot0:_refreshLightResourcePoint()
	end

	return slot0._lightResourcePointDict[tostring(slot1)]
end

function slot0.clearLightResourcePoint(slot0)
	slot0._lightResourcePointDict = nil
end

function slot0.getTotalReserve(slot0, slot1)
	if not slot0:getBuildingMOById(slot1) then
		return 0
	end

	return slot2.config.reserve
end

function slot0.debugPlaceBuilding(slot0, slot1, slot2)
	slot3 = RoomBuildingMO.New()

	slot3:init(slot2)
	slot0:_addBuildingMO(slot3)

	return slot3
end

function slot0.debugRootOutBuilding(slot0, slot1)
	slot2 = slot0:getBuildingMO(slot1.x, slot1.y)

	slot0:_removeBuildingMO(slot2)

	return slot2
end

function slot0.getRevertHexPoint(slot0)
	return slot0._revertHexPoint
end

function slot0.getRevertRotate(slot0)
	return slot0._revertRotate
end

function slot0.getBuildingListByType(slot0, slot1, slot2)
	if slot0._type2BuildingDict[slot1] and slot2 then
		table.sort(slot3, RoomHelper.sortBuildingById)
	end

	return slot3
end

function slot0.isHasCritterByBuid(slot0, slot1)
	if not slot0._isHasCritterDict then
		slot0._isHasCritterDict = {}

		for slot6, slot7 in ipairs(CritterModel.instance:getAllCritters()) do
			if slot7.workInfo.buildingUid and slot7.workInfo.buildingUid ~= 0 then
				slot0._isHasCritterDict[slot7.workInfo.buildingUid] = true
			elseif slot7.restInfo.restBuildingUid and slot7.restInfo.restBuildingUid ~= 0 then
				slot0._isHasCritterDict[slot7.restInfo.restBuildingUid] = true
			end
		end
	end

	return slot0._isHasCritterDict[slot1]
end

function slot0.getBuildingMoByBuildingId(slot0, slot1)
	if slot0:getList() then
		for slot6, slot7 in pairs(slot2) do
			if slot7.buildingId == slot1 then
				return slot7
			end
		end
	end
end

slot0.instance = slot0.New()

return slot0
