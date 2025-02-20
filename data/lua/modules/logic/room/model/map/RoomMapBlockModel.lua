module("modules.logic.room.model.map.RoomMapBlockModel", package.seeall)

slot0 = class("RoomMapBlockModel", BaseModel)

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
	slot0._mapBlockMOList = {}
	slot0._mapBlockMODict = {}

	if slot0._emptyBlockModel then
		slot0._emptyBlockModel:clear()
	end

	slot0._emptyBlockModel = BaseModel.New()

	if slot0._fullBlockModel then
		slot0._fullBlockModel:clear()
	end

	slot0._fullBlockModel = BaseModel.New()
	slot0._tempBlockMO = nil
	slot0._emptyId = -1000
	slot0._convexHull = nil
	slot0._convexHexPointDict = nil
	slot0._isBackMore = false

	if slot0._backBlockModel then
		slot0._backBlockModel:clear()
	end

	slot0._backBlockModel = BaseModel.New()
end

function slot0.getBackBlockModel(slot0)
	return slot0._backBlockModel
end

function slot0.isCanBackBlock(slot0)
	if slot0._backBlockModel:getCount() < 1 then
		return false
	end

	if RoomEnum.IsBlockNeedConnInit then
		if RoomBackBlockHelper.isCanBack(slot0:getFullListNoTempBlockMO(), slot0._backBlockModel:getList()) then
			return true
		end

		return false
	end

	if RoomBackBlockHelper.isHasInitBlock(slot0._backBlockModel:getList()) then
		return false
	end

	return true
end

function slot0.getFullListNoTempBlockMO(slot0)
	if not slot0:getTempBlockMO() then
		return slot0._fullBlockModel:getList()
	end

	slot1 = {}

	tabletool.addValues(slot1, slot0._fullBlockModel:getList())
	tabletool.removeValue(slot1, slot0:getTempBlockMO())

	return slot1
end

function slot0.backBlockById(slot0, slot1)
	if slot0:getFullBlockMOById(slot1) then
		slot2:setOpState(RoomBlockEnum.OpState.Normal)
		slot0:_removeBlockMO(slot2)
		slot0._backBlockModel:remove(slot2)
		slot0:_placeOneEmptyBlock(slot2.hexPoint)

		return slot2
	end
end

function slot0.isBackMore(slot0)
	return slot0._isBackMore
end

function slot0.setBackMore(slot0, slot1)
	slot0._isBackMore = slot1 == true
end

function slot0.initMap(slot0, slot1)
	slot0:clear()

	if not slot1 or #slot1 <= 0 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		if slot6.use ~= false then
			slot8 = RoomBlockMO.New()

			slot8:init(RoomInfoHelper.serverInfoToBlockInfo(slot6))
			slot0:_addBlockMO(slot8)
		end
	end

	slot0:_refreshEmpty()
	slot0:_refreshConvexHull()
end

function slot0._refreshEmpty(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(slot0._fullBlockModel:getList()) do
		slot8 = slot7.hexPoint

		for slot12 = 1, RoomBlockEnum.EmptyBlockDistanceStyleCount do
			for slot18, slot19 in ipairs(slot8:getOnRanges(slot12)) do
				slot1[slot19.x] = slot1[slot19.x] or {}
				slot1[slot19.x][slot19.y] = math.min(slot1[slot19.x][slot19.y] or RoomBlockEnum.EmptyBlockDistanceStyleCount, slot12)
			end
		end
	end

	slot3 = 0

	for slot7, slot8 in pairs(slot1) do
		for slot12, slot13 in pairs(slot8) do
			slot3 = slot3 + 1

			if slot0:getBlockMO(slot7, slot12) then
				slot0:_refreshEmptyMO(slot14, slot13)
			else
				slot0:_placeOneEmptyBlock(HexPoint(slot7, slot12), slot13)
			end
		end
	end
end

function slot0._placeEmptyBlock(slot0, slot1)
	slot7 = true

	for slot7, slot8 in ipairs(slot1.hexPoint:getInRanges(RoomBlockEnum.EmptyBlockDistanceStyleCount, slot7)) do
		if slot0:getBlockMO(slot8.x, slot8.y) then
			slot0:_refreshEmptyMO(slot9)
		else
			slot0:_placeOneEmptyBlock(slot8)
		end
	end
end

function slot0._placeOneEmptyBlock(slot0, slot1, slot2)
	if slot0._emptyBlockModel:getById(slot0:_getEmptyGUID(slot1.x, slot1.y)) then
		slot4.distanceStyle = slot2

		slot0:_addBlockMOToMapDict(slot4)
	else
		slot4 = RoomBlockMO.New()

		slot4:init(RoomInfoHelper.generateEmptyMapBlockInfo(slot3, slot1.x, slot1.y, slot2))
		slot0:_addBlockMO(slot4)
	end

	slot0:_refreshEmptyMO(slot4, slot2)
end

function slot0._addBlockMOToMapDict(slot0, slot1)
	slot2 = slot1.hexPoint
	slot0._mapBlockMODict[slot2.x] = slot0._mapBlockMODict[slot2.x] or {}
	slot0._mapBlockMODict[slot2.x][slot2.y] = slot1

	table.insert(slot0._mapBlockMOList, slot1)
end

function slot0._addBlockMO(slot0, slot1)
	slot0:_addBlockMOToMapDict(slot1)

	if slot1.blockState == RoomBlockEnum.BlockState.Water then
		slot0._emptyBlockModel:addAtLast(slot1)
	else
		slot0._fullBlockModel:addAtLast(slot1)
	end
end

function slot0._removeBlockMO(slot0, slot1)
	if slot0._mapBlockMODict[slot1.hexPoint.x] then
		slot0._mapBlockMODict[slot2.x][slot2.y] = nil
	end

	if tabletool.indexOf(slot0._mapBlockMOList, slot1) then
		table.remove(slot0._mapBlockMOList, slot3)
	end

	if slot1.blockState == RoomBlockEnum.BlockState.Water then
		slot0._emptyBlockModel:remove(slot1)
	else
		slot0._fullBlockModel:remove(slot1)
	end
end

function slot0.addTempBlockMO(slot0, slot1, slot2)
	if slot0._tempBlockMO then
		logError("暂不支持两个临时地块")

		return
	end

	if slot0:getBlockMO(slot2.x, slot2.y) then
		slot0:_removeBlockMO(slot3)
	end

	slot4 = RoomInfoHelper.blockMOToBlockInfo(slot1)
	slot0._tempBlockMO = RoomBlockMO.New()
	slot4.blockState = RoomBlockEnum.BlockState.Temp
	slot4.x = slot2.x
	slot4.y = slot2.y

	slot0._tempBlockMO:init(slot4)
	slot0:_addBlockMO(slot0._tempBlockMO)

	return slot0._tempBlockMO
end

function slot0.getTempBlockMO(slot0)
	return slot0._tempBlockMO
end

function slot0.changeTempBlockMO(slot0, slot1, slot2)
	if not slot0._tempBlockMO then
		return
	end

	slot0._tempBlockMO.rotate = slot2

	if slot0._tempBlockMO.hexPoint ~= slot1 then
		slot3 = HexPoint(slot0._tempBlockMO.hexPoint.x, slot0._tempBlockMO.hexPoint.y)

		if slot0:getBlockMO(slot1.x, slot1.y) then
			slot0:_removeBlockMO(slot4)
		end

		slot0:_removeBlockMO(slot0._tempBlockMO)

		slot0._tempBlockMO.hexPoint = slot1

		slot0:_addBlockMO(slot0._tempBlockMO)
		slot0:_placeOneEmptyBlock(slot3)
	end
end

function slot0.removeTempBlockMO(slot0)
	if not slot0._tempBlockMO then
		return
	end

	slot0:_removeBlockMO(slot0._tempBlockMO)
	slot0:_placeOneEmptyBlock(slot0._tempBlockMO.hexPoint)

	slot0._tempBlockMO = nil
end

function slot0.placeTempBlockMO(slot0, slot1)
	if not slot0._tempBlockMO then
		return
	end

	slot2 = RoomBlockMO.New()

	slot2:init(RoomInfoHelper.serverInfoToBlockInfo(slot1))

	slot0._tempBlockMO.rotate = slot2.rotate
	slot0._tempBlockMO.blockState = RoomBlockEnum.BlockState.Map

	slot0:_placeEmptyBlock(slot0._tempBlockMO)

	slot0._tempBlockMO = nil

	slot0:_refreshConvexHull()
end

function slot0.getBlockMO(slot0, slot1, slot2)
	return slot0._mapBlockMODict[slot1] and slot0._mapBlockMODict[slot1][slot2]
end

function slot0.getBlockMOList(slot0)
	return slot0._mapBlockMOList
end

function slot0.getBlockMODict(slot0)
	return slot0._mapBlockMODict
end

function slot0.getEmptyBlockMOList(slot0)
	return slot0._emptyBlockModel:getList()
end

function slot0.getFullBlockMOList(slot0)
	return slot0._fullBlockModel:getList()
end

function slot0.getEmptyBlockMOById(slot0, slot1)
	return slot0._emptyBlockModel:getById(slot1)
end

function slot0.getFullBlockMOById(slot0, slot1)
	return slot0._fullBlockModel:getById(slot1)
end

function slot0.getFullBlockCount(slot0)
	if slot0._tempBlockMO then
		slot1 = slot0._fullBlockModel:getCount() - 1
	end

	return slot1
end

function slot0.getConfirmBlockCount(slot0)
	for slot6, slot7 in ipairs(slot0._fullBlockModel:getList()) do
		if slot7.blockState == RoomBlockEnum.BlockState.Map and slot7.blockId > 0 then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.getMaxBlockCount(slot0, slot1)
	slot3 = RoomConfig.instance:getRoomLevelConfig(slot1 or RoomMapModel.instance:getRoomLevel()) or RoomConfig.instance:getRoomLevelConfig(RoomConfig.instance:getMaxRoomLevel())

	return (slot3 and slot3.maxBlockCount or 0) + slot0:getTradeBlockCount()
end

function slot0.getTradeBlockCount(slot0)
	return ManufactureConfig.instance:getTradeLevelCfg(ManufactureModel.instance:getTradeLevel(), false) and slot2.addBlockMax or 0
end

function slot0._refreshConvexHull(slot0)
	slot0._convexHull = {}
	slot2 = {}

	for slot6, slot7 in ipairs(slot0._fullBlockModel:getList()) do
		if slot7.blockState == RoomBlockEnum.BlockState.Map then
			slot9 = HexMath.hexToPosition(slot7.hexPoint, RoomBlockEnum.BlockSize)
			slot10 = RoomBlockEnum.BlockSize * 3

			table.insert(slot2, slot9 + Vector2(1.1546 * slot10, 0))
			table.insert(slot2, slot9 + Vector2(0.5773 * slot10, -slot10))
			table.insert(slot2, slot9 + Vector2(-0.5773 * slot10, -slot10))
			table.insert(slot2, slot9 + Vector2(-1.1546 * slot10, 0))
			table.insert(slot2, slot9 + Vector2(-0.5773 * slot10, slot10))
			table.insert(slot2, slot9 + Vector2(0.5773 * slot10, slot10))
		end
	end

	slot0._convexHull = RoomCameraHelper.getConvexHull(slot2)
	slot0._convexHexPointDict = RoomCameraHelper.getConvexHexPointDict(RoomCameraHelper.expandConvexHull(slot0._convexHull, RoomBlockEnum.BlockSize * 10))
end

function slot0.getConvexHull(slot0)
	if not slot0._convexHull then
		slot0:_refreshConvexHull()
	end

	return slot0._convexHull
end

function slot0.getConvexHexPointDict(slot0)
	if not slot0._convexHexPointDict then
		slot0:_refreshConvexHull()
	end

	return slot0._convexHexPointDict
end

function slot0._getEmptyGUID(slot0, slot1, slot2)
	slot4 = CommonConfig.instance:getConstNum(ConstEnum.RoomMapMaxRadius) + 1

	return slot0._emptyId - ((slot1 + slot4) * 2 * slot4 + slot2 + slot4)
end

function slot0.refreshNearRiver(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot1:getInRanges(slot2)) do
		if slot0:getBlockMO(slot8.x, slot8.y) and slot9.blockState ~= RoomBlockEnum.BlockState.Water then
			slot9:refreshRiver()
		end
	end
end

function slot0._refreshEmptyMO(slot0, slot1, slot2)
end

function slot0.debugConfirmPlaceBlock(slot0, slot1, slot2)
	RoomBlockMO.New():init(slot2)

	if slot0:getBlockMO(slot1.x, slot1.y) then
		slot0:_removeBlockMO(slot4)
	end

	slot0:_addBlockMO(slot3)
	slot0:_placeEmptyBlock(slot3)
	slot0:_refreshConvexHull()

	return slot3, slot4
end

function slot0.debugRootOutBlock(slot0, slot1)
	if slot0:getBlockMO(slot1.x, slot1.y) then
		slot0:_removeBlockMO(slot2)
	end

	slot4 = {}

	for slot8, slot9 in ipairs(slot1:getInRanges(RoomBlockEnum.EmptyBlockDistanceStyleCount, true)) do
		slot10 = false

		if slot0:getBlockMO(slot9.x, slot9.y) and slot11.blockState == RoomBlockEnum.BlockState.Water then
			slot12 = false
			slot17 = true

			for slot17, slot18 in ipairs(slot9:getInRanges(RoomBlockEnum.EmptyBlockDistanceStyleCount, slot17)) do
				if slot0:getBlockMO(slot18.x, slot18.y) and slot19.blockState == RoomBlockEnum.BlockState.Map then
					slot12 = true

					break
				end
			end

			if slot12 then
				slot0:_refreshEmptyMO(slot11)
			else
				slot0:_removeBlockMO(slot11)
				table.insert(slot4, slot11)
			end
		elseif slot11 and slot11.blockState == RoomBlockEnum.BlockState.Map then
			slot10 = true
		end

		if slot10 then
			slot0:_placeOneEmptyBlock(slot1)
		end
	end

	slot0:_refreshConvexHull()

	return slot4
end

function slot0.getFullMapSizeAndCenter(slot0)
	for slot8, slot9 in ipairs(slot0._mapBlockMOList) do
		slot11 = HexMath.hexToPosition(slot9.hexPoint, RoomBlockEnum.BlockSize)
		slot1 = math.max(0, slot11.x)
		slot2 = math.max(0, slot11.y)
		slot3 = math.min(0, slot11.x)
		slot4 = math.min(0, slot11.y)
	end

	slot7 = 0
	slot8 = 0

	return math.min(math.floor((slot1 - slot3) * RoomEnum.WorldPosToAStarMeshWidth), RoomEnum.AStarMeshMaxWidthOrDepth), math.min(math.floor((slot2 - slot4) * RoomEnum.WorldPosToAStarMeshDepth), RoomEnum.AStarMeshMaxWidthOrDepth), (slot1 + slot3) * 0.5, (slot2 + slot4) * 0.5
end

slot0.instance = slot0.New()

return slot0
