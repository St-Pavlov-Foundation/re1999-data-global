module("modules.logic.room.model.map.RoomBlockMO", package.seeall)

slot0 = pureTable("RoomBlockMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.blockId
	slot0.blockId = slot1.blockId
	slot0.defineId = slot1.defineId
	slot0.packageId = slot1.packageId
	slot0.packageOrder = slot1.packageOrder
	slot0.mainRes = slot1.mainRes
	slot0.rotate = slot1.rotate or 0
	slot0.blockState = slot1.blockState or RoomBlockEnum.BlockState.Inventory
	slot0.ownType = slot1.ownType or RoomBlockEnum.OwnType.Package
	slot0.useState = slot1.useState or RoomBlockEnum.UseState.Normal
	slot0.blockCleanType = slot1.blockCleanType or 0

	if slot0:isInMap() then
		slot0.hexPoint = HexPoint(slot1.x or 0, slot1.y or 0)
	end

	if slot0.blockState == RoomBlockEnum.BlockState.Water then
		slot0.distanceStyle = slot1.distanceStyle
	end

	slot0._riverTypeDict = nil
	slot0.replaceDefineId = nil
	slot0.replaceRotate = nil

	slot0:setWaterType(slot1.waterType or -1)
	slot0:setTempWaterType()

	slot0._defineWaterType = slot1.defineWaterType
	slot0._resourceListDic = {}
	slot0._isHasLightDic = {}
end

function slot0.getMainRes(slot0)
	return slot0.mainRes
end

function slot0.getBlockDefineCfg(slot0, slot1)
	slot2 = slot0:getDefineId(slot1)

	if not slot0._blockDefineCfg or slot0._blockDefineCfg.defineId ~= slot2 then
		slot0._blockDefineCfg = RoomConfig.instance:getBlockDefineConfig(slot2)
	end

	return slot0._blockDefineCfg
end

function slot0.getDefineBlockType(slot0, slot1)
	return slot0:getBlockDefineCfg(slot1) and slot2.blockType or 0
end

function slot0.getDefineId(slot0, slot1)
	return slot1 and slot0.defineId or slot0.replaceDefineId or slot0.defineId
end

function slot0.getRotate(slot0, slot1)
	return slot1 and slot0.rotate or slot0.replaceDefineId and slot0.replaceRotate or slot0.rotate
end

function slot0.getDefineWaterType(slot0, slot1, slot2)
	if not slot1 and not slot2 and slot0:isInMapBlock() and slot0:getTempWaterType() and slot3 ~= -1 then
		return slot3
	end

	return slot0:getOriginalWaterType(slot2)
end

function slot0.getTempWaterType(slot0)
	return slot0.tempWaterType
end

function slot0.getWaterType(slot0)
	return slot0.waterType
end

function slot0.getOriginalWaterType(slot0, slot1)
	if not slot1 and slot0:isInMapBlock() and slot0:getWaterType() and slot2 ~= -1 then
		return slot2
	end

	return slot0._defineWaterType or slot0:getBlockDefineCfg(slot1) and slot3.waterType or 0
end

function slot0.getDefineWaterAreaType(slot0, slot1)
	return slot0:getBlockDefineCfg(slot1) and slot2.waterAreaType or 0
end

function slot0.isFullWater(slot0, slot1)
	if slot0:getRiverCount(slot1) < 1 and slot0:getResourceCenter(slot1) ~= RoomResourceEnum.ResourceId.River then
		return false
	end

	if slot2 >= 6 then
		return true
	end

	return slot0:isHalfLakeWater(slot1)
end

function slot0.isHalfLakeWater(slot0, slot1)
	return slot0:getDefineWaterAreaType(slot1) == 1
end

function slot0.getResourceList(slot0, slot1)
	if not slot0:getBlockDefineCfg(slot1) then
		slot0._isHasLightDic[-1000] = false

		return RoomResourceEnum.Block.NoneList
	end

	if not slot0._resourceListDic[slot0._blockDefineCfg.defineId] then
		slot3 = {}

		for slot8 = 1, 6 do
			table.insert(slot3, slot2.resourceIds[slot8 + 1])

			if not false and RoomConfig.instance:isLightByResourceId(slot9) then
				slot4 = true
			end
		end

		slot0._isHasLightDic[slot0._blockDefineCfg.defineId] = slot4
		slot0._resourceListDic[slot0._blockDefineCfg.defineId] = slot3
	end

	if slot0:getUseState() == RoomBlockEnum.UseState.TransportPath then
		if slot2.resIdCountDict[RoomResourceEnum.ResourceId.River] then
			return RoomResourceEnum.Block.RiverList
		end

		return RoomResourceEnum.Block.NoneList
	end

	return slot0._resourceListDic[slot0._blockDefineCfg.defineId]
end

function slot0.isHasLight(slot0, slot1)
	if slot0._isHasLightDic[slot0:getDefineId(slot1)] == nil then
		slot0:getResourceList(slot1)

		return slot0._isHasLightDic[slot0:getDefineId(slot1)]
	end

	return slot2
end

function slot0.getResourceCenter(slot0, slot1)
	if not slot0:getBlockDefineCfg(slot1) then
		return RoomResourceEnum.ResourceId.None
	end

	if slot0:getUseState() == RoomBlockEnum.UseState.TransportPath then
		if slot2.resIdCountDict[RoomResourceEnum.ResourceId.River] then
			return RoomResourceEnum.ResourceId.River
		end

		return RoomResourceEnum.ResourceId.None
	end

	return slot2.resourceIds[1]
end

function slot0.isInMap(slot0)
	return slot0.blockState == RoomBlockEnum.BlockState.Map or slot0.blockState == RoomBlockEnum.BlockState.Water or slot0.blockState == RoomBlockEnum.BlockState.Temp
end

function slot0.isInMapBlock(slot0)
	return slot0.blockState == RoomBlockEnum.BlockState.Map or slot0.blockState == RoomBlockEnum.BlockState.Temp
end

function slot0.canPlace(slot0)
	if slot0.blockState ~= RoomBlockEnum.BlockState.Water then
		return false
	end

	if not RoomEnum.IsBlockNeedConnInit then
		return true
	end

	for slot5, slot6 in ipairs(slot0.hexPoint:getNeighbors()) do
		if RoomMapBlockModel.instance:getBlockMO(slot6.x, slot6.y) and slot7.blockState == RoomBlockEnum.BlockState.Map then
			return true
		end
	end

	return false
end

function slot0.resetOpState(slot0)
	slot0._opState = RoomBlockEnum.OpState.Normal
end

function slot0.getOpState(slot0)
	return slot0._opState or RoomBlockEnum.OpState.Normal
end

function slot0.getOpStateParam(slot0)
	return slot0._opStateParamDic and slot0._opStateParamDic[slot0._opState]
end

function slot0.setOpState(slot0, slot1, slot2)
	slot0._opState = slot1
	slot0._opStateParamDic = slot0._opStateParamDic or {}
	slot0._opStateParamDic[slot1] = slot2
end

function slot0.setUseState(slot0, slot1)
	slot0.useState = slot1
end

function slot0.getUseState(slot0)
	return slot0.useState or RoomBlockEnum.UseState.Normal
end

function slot0.setCleanType(slot0, slot1)
	slot0.blockCleanType = slot1 or RoomBlockEnum.CleanType.Normal
end

function slot0.getCleanType(slot0)
	return slot0.blockCleanType or RoomBlockEnum.CleanType.Normal
end

function slot0.setWaterType(slot0, slot1)
	slot0.waterType = slot1
end

function slot0.setTempWaterType(slot0, slot1)
	slot0.tempWaterType = slot1
end

function slot0.isWaterGradient(slot0)
	slot1 = true
	slot3 = slot0:getTempWaterType()

	if slot0:getWaterType() and slot2 ~= -1 or slot3 and slot3 ~= -1 then
		slot1 = false
	end

	return slot1
end

function slot0.getResourceId(slot0, slot1, slot2, slot3)
	if slot0.blockState == RoomBlockEnum.BlockState.Water then
		return RoomResourceEnum.ResourceId.Empty
	end

	if slot0.blockState == RoomBlockEnum.BlockState.Fake then
		return RoomResourceEnum.ResourceId.None
	end

	slot4 = RoomResourceEnum.ResourceId.None

	return (slot1 ~= 0 or slot0:getResourceCenter()) and slot0:getResourceList()[slot2 and slot1 or RoomRotateHelper.rotateDirection(slot1, -slot0:getRotate())]
end

function slot0.getResourceTypeRiver(slot0, slot1, slot2)
	if slot0.blockState == RoomBlockEnum.BlockState.Water or slot0.blockState == RoomBlockEnum.BlockState.Fake then
		return nil
	end

	if slot1 == 0 then
		return nil
	end

	if not slot0._riverTypeDict then
		slot0:refreshRiver()
	end

	if slot2 then
		slot1 = RoomRotateHelper.rotateDirection(slot1, slot0:getRotate()) or slot1
	end

	return slot0._riverTypeDict[slot1], slot0._neighborBlockTypeDict and slot0._neighborBlockTypeDict[slot1], slot0._neighborBlockBTypeDict and slot0._neighborBlockBTypeDict[slot1]
end

function slot0.refreshRiver(slot0)
	if slot0:getRiverCount() < 1 then
		return
	end

	slot3 = slot0.replaceDefineId or slot0.defineId

	if not slot0:isFullWater() and slot0._lastRefreshRiverDefineId == slot3 then
		return
	end

	slot0._lastRefreshRiverDefineId = slot3
	slot0._riverTypeDict, slot0._neighborBlockTypeDict, slot0._neighborBlockBTypeDict = RoomRiverHelper.getRiverTypeDictByMO(slot0)
end

function slot0.hasRiver(slot0, slot1)
	return slot0:getResourceCenter(slot1) == RoomResourceEnum.ResourceId.River or slot0:getRiverCount(slot1) > 0
end

function slot0.getRiverCount(slot0, slot1)
	for slot7, slot8 in ipairs(slot0:getResourceList(slot1)) do
		if slot8 == RoomResourceEnum.ResourceId.River then
			slot3 = 0 + 1
		end
	end

	return slot3
end

function slot0.getNeighborBlockLinkResourceId(slot0, slot1, slot2)
	if not slot1 or slot1 == 0 or slot1 > 6 then
		return nil
	end

	if slot0:isInMap() then
		if slot2 then
			slot1 = RoomRotateHelper.rotateDirection(slot1, slot0:getRotate())
		end

		slot3 = slot0.hexPoint:getNeighbor(slot1)

		if RoomMapBlockModel.instance:getBlockMO(slot3.x, slot3.y) then
			return slot4:getResourceId(RoomRotateHelper.rotateDirection((slot1 - 1 + 3) % 6 + 1, slot4:getRotate()), true, true), slot4
		end
	end

	return nil
end

function slot0.hasNeighborSameBlockType(slot0)
	if slot0:isInMap() then
		for slot6 = 1, 6 do
			slot7 = HexPoint.directions[slot6]

			if RoomMapBlockModel.instance:getBlockMO(slot0.hexPoint.x + slot7.x, slot0.hexPoint.y + slot7.y) and slot0:getDefineBlockType() == slot8:getDefineBlockType() then
				return true
			end
		end
	end

	return false
end

return slot0
