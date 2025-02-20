module("modules.logic.room.model.map.RoomResourceModel", package.seeall)

slot0 = class("RoomResourceModel", BaseModel)

function slot0.ctor(slot0)
	uv0.super.ctor(slot0)

	slot0._allResourcePointDic = {}
	slot0._allResourcePointList = {}
	slot0._blockPointDic = {}
	slot0._mapMaxRadius = 400
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
	slot0._resourceAreaList = nil
	slot0._resourcePointToAreaIndex = nil
	slot0._lightResourcePointDict = nil
	slot0._blockPointDic = {}

	if slot0._resourcePointAreaModel then
		slot0._resourcePointAreaModel:clear()
	end
end

function slot0.init(slot0)
	slot0:clear()

	if not slot0._resourcePointAreaModel then
		slot0._resourcePointAreaModel = BaseModel.New()
	end

	if CommonConfig.instance:getConstNum(ConstEnum.RoomMapMaxRadius) then
		slot0._mapMaxRadius = math.max(slot1, slot0._mapMaxRadius)
	end

	slot0:_initLigheResourcePoint()
end

function slot0._initLigheResourcePoint(slot0)
	slot3 = RoomMapBuildingModel.instance:getTempBuildingMO() and slot2.id or nil
	slot4 = RoomConfig.instance

	for slot8, slot9 in pairs(RoomMapBlockModel.instance:getBlockMODict()) do
		for slot13, slot14 in pairs(slot9) do
			if slot3 ~= slot14.id then
				slot0:_addBlockMO(slot14)
			end
		end
	end
end

function slot0._addBlockMO(slot0, slot1)
	for slot6 = 0, 6 do
		if RoomConfig.instance:isLightByResourceId(slot1:getResourceId(slot6)) then
			if not slot0._resourcePointAreaModel:getById(slot7) then
				slot8 = RoomMapResorcePointAreaMO.New()

				slot8:init(slot7, slot7)
				slot0._resourcePointAreaModel:addAtLast(slot8)
			end

			slot8:addResPoint(slot0:getResourcePoint(slot1.hexPoint.x, slot1.hexPoint.y, slot6))

			if not slot0._blockPointDic[slot1.id] then
				slot0._blockPointDic[slot1.id] = slot9
			end
		end
	end
end

function slot0._removeBlockMO(slot0, slot1)
	if slot0._blockPointDic[slot1.id] then
		slot0._blockPointDic[slot1.id] = nil

		for slot7, slot8 in ipairs(slot0._resourcePointAreaModel:getList()) do
			slot8:removeByXY(slot2.x, slot2.y)
		end
	end
end

function slot0.unUseBlockList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0:_removeBlockMO(slot6)
	end
end

function slot0.useBlock(slot0, slot1)
	slot0:_removeBlockMO(slot1)
	slot0:_addBlockMO(slot1)
end

function slot0.getIndexByXYD(slot0, slot1, slot2, slot3)
	slot4 = slot0._mapMaxRadius + 1

	return ((slot1 + slot4) * 2 * slot4 + slot2 + slot4) * 100 + slot3
end

function slot0.getIndexByXY(slot0, slot1, slot2)
	return slot0:getIndexByXYD(slot1, slot2, 0)
end

function slot0.getResourcePoint(slot0, slot1, slot2, slot3)
	if not slot0._allResourcePointDic[slot0:getIndexByXYD(slot1, slot2, slot3)] then
		slot5 = ResourcePoint(HexPoint(slot1, slot2), slot3)
		slot0._allResourcePointDic[slot4] = slot5

		table.insert(slot0._allResourcePointList, slot5)
	end

	return slot5
end

function slot0._refreshResourceAreaList(slot0)
	slot0._resourceAreaList = {}
	slot0._resourcePointToAreaIndex = {}
end

function slot0.getResourceAreaList(slot0)
	if not slot0._resourceAreaList or not slot0._resourcePointToAreaIndex then
		slot0:_refreshResourceAreaList()
	end

	return slot0._resourceAreaList
end

function slot0.getResourceAreaById(slot0, slot1)
	if not slot0._resourceAreaList or not slot0._resourcePointToAreaIndex then
		slot0:_refreshResourceAreaList()
	end

	return slot0._resourceAreaList[slot1]
end

function slot0.getResourceArea(slot0, slot1)
	if not slot0._resourceAreaList or not slot0._resourcePointToAreaIndex then
		slot0:_refreshResourceAreaList()
	end

	for slot5, slot6 in ipairs(slot0._resourceAreaList) do
		if slot6.resourcePointDict[slot1.x] and slot6.resourcePointDict[slot1.x][slot1.y] and slot6.resourcePointDict[slot1.x][slot1.y][slot1.direction] then
			return slot6
		end
	end

	return nil
end

function slot0.getResourcePointToAreaIndex(slot0, slot1)
	if not slot0._resourceAreaList or not slot0._resourcePointToAreaIndex then
		slot0:_refreshResourceAreaList()
	end

	return slot0._resourcePointToAreaIndex[tostring(slot1)]
end

function slot0.clearResourceAreaList(slot0)
	slot0._resourceAreaList = nil
end

function slot0._refreshBuildingLightResourcePoint(slot0)
	slot0._lightResourcePointDict = {}

	if not RoomMapBuildingModel.instance:getTempBuildingMO() then
		return
	end

	slot6 = slot1.rotate
	slot7 = slot1.buildingUid

	for slot6, slot7 in pairs(RoomBuildingHelper.getOccupyDict(slot1.buildingId, slot1.hexPoint, slot6, slot7)) do
		for slot11, slot12 in pairs(slot7) do
			if slot13 and (RoomMapBlockModel.instance:getBlockMO(slot6, slot11) and RoomBuildingHelper.isJudge(slot13.hexPoint, slot13.id)) then
				slot15 = slot13.replaceDefineId
				slot16 = slot13.replaceRotate
				slot13.replaceDefineId = slot12.blockDefineId
				slot13.replaceRotate = slot12.blockDefineId and slot12.blockRotate

				for slot22 = 1, 6 do
					if slot13:getResourceId(slot22) ~= RoomResourceEnum.ResourceId.None and slot23 ~= RoomResourceEnum.ResourceId.Empty and RoomBuildingHelper.checkCostResource(RoomBuildingHelper.getCostResource(slot1.buildingId), slot23) then
						slot0._lightResourcePointDict[slot0:getIndexByXYD(slot13.hexPoint.x, slot13.hexPoint.y, RoomRotateHelper.rotateDirection(slot22, slot13:getRotate()))] = true
					end
				end

				slot13.replaceDefineId = slot15
				slot13.replaceRotate = slot16
			end
		end
	end
end

function slot0._refreshLightResourcePoint(slot0)
	slot0._lightResourcePointDict = {}

	if not RoomMapBlockModel.instance:getTempBlockMO() or not slot1:isHasLight() then
		return
	end

	slot4 = slot1.hexPoint
	slot5 = {}
	slot6 = {}
	slot7 = {}

	for slot11 = 1, 6 do
		slot12 = slot3:getResourceId(slot11)
		slot13 = slot0._resourcePointAreaModel:getById(slot12)

		if RoomConfig.instance:isLightByResourceId(slot12) and slot13 then
			slot5[slot12] = slot5[slot12] or {}
			slot14 = slot0:getResourcePoint(slot4.x, slot4.y, slot11)
			slot16 = false

			for slot20, slot21 in ipairs(slot13:getConnectsAll(slot11)) do
				if slot21.x ~= 0 or slot21.y ~= 0 then
					if slot13:getAreaIdByXYD(slot21.x + slot14.x, slot21.y + slot14.y, slot21.direction) then
						slot16 = true
					end

					if slot24 and not slot5[slot12][slot24] then
						slot5[slot12][slot24] = true
						slot29 = slot23
						slot30 = slot21.direction

						for slot29, slot30 in ipairs(slot13:getResorcePiontListByXYD(slot22, slot29, slot30)) do
							slot0._lightResourcePointDict[slot0:getIndexByXYD(slot30.x, slot30.y, slot30.direction)] = slot12
						end
					end
				end
			end

			if slot16 then
				slot21 = slot14.y
				slot22 = slot14.direction
				slot0._lightResourcePointDict[slot0:getIndexByXYD(slot14.x, slot21, slot22)] = slot12

				for slot21, slot22 in ipairs(slot15) do
					if (slot22.x == 0 or slot22.y == 0) and slot12 == slot3:getResourceId(slot22.direction) then
						slot0._lightResourcePointDict[slot0:getIndexByXYD(slot22.x + slot14.x, slot22.y + slot14.y, slot22.direction)] = slot12
					end
				end
			end
		end
	end
end

function slot0._refreshWaterReformLightResourcePoint(slot0)
	slot0._lightResourcePointDict = {}

	if not slot0._resourcePointAreaModel:getById(RoomResourceEnum.ResourceId.River) then
		return
	end

	for slot8, slot9 in ipairs(slot2:findeArea()) do
		if slot8 ~= RoomWaterReformModel.instance:getSelectAreaId() then
			for slot13, slot14 in ipairs(slot9) do
				slot0._lightResourcePointDict[slot0:getIndexByXYD(slot14.x, slot14.y, slot14.direction)] = slot1
			end
		end
	end
end

function slot0.isLightResourcePoint(slot0, slot1, slot2, slot3)
	slot4 = RoomWaterReformModel.instance:isWaterReform()

	if not slot0._lightResourcePointDict then
		if RoomBuildingController.instance:isBuildingListShow() then
			return false
		elseif slot4 then
			return false
		else
			slot0:_refreshLightResourcePoint()
		end
	end

	return slot0._lightResourcePointDict[slot0:getIndexByXYD(slot1, slot2, slot3)]
end

function slot0.clearLightResourcePoint(slot0)
	slot0._lightResourcePointDict = nil
end

slot0.instance = slot0.New()

return slot0
