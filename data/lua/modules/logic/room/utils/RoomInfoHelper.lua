module("modules.logic.room.utils.RoomInfoHelper", package.seeall)

return {
	serverInfoToBlockInfo = function (slot0)
		slot1 = {}

		if not RoomConfig.instance:getBlock(slot0.blockId) and not RoomController.instance:isDebugMode() then
			logError(string.format("can not find blockCfg [blockId:%s]", slot0.blockId))
		end

		slot1.blockId = slot0.blockId
		slot1.defineId = slot0.defineId or slot2 and slot2.defineId or RoomBlockEnum.EmptyDefineId
		slot1.mainRes = slot0.mainRes or slot2 and slot2.mainRes or -1
		slot1.packageId = slot0.packageId or slot2 and slot2.packageId or 0
		slot1.packageOrder = slot0.packageOrder or slot2 and slot2.packageOrder or 0
		slot1.rotate = slot0.rotate or 0
		slot1.waterType = slot0.waterType

		if slot0.use ~= false then
			slot1.blockState = RoomBlockEnum.BlockState.Map
			slot1.x = slot0.x
			slot1.y = slot0.y
		else
			slot1.blockState = RoomBlockEnum.BlockState.Inventory
		end

		return slot1
	end,
	blockMOToBlockInfo = function (slot0)
		if slot0:isInMap() then
			-- Nothing
		end

		return {
			blockId = slot0.blockId,
			defineId = slot0.defineId,
			mainRes = slot0.mainRes,
			packageId = slot0.packageId,
			rotate = slot0.rotate,
			blockState = slot0.blockState,
			x = slot0.hexPoint.x,
			y = slot0.hexPoint.y
		}
	end,
	generateEmptyMapBlockInfo = function (slot0, slot1, slot2, slot3)
		return {
			blockId = slot0,
			defineId = RoomResourceEnum.EmptyDefineId,
			mainRes = RoomResourceEnum.ResourceId.Empty,
			rotate = 0,
			blockState = RoomBlockEnum.BlockState.Water,
			distanceStyle = slot3,
			x = slot1,
			y = slot2
		}
	end,
	generateFakeMapBlockInfo = function (slot0)
		return {
			blockId = slot0,
			defineId = RoomResourceEnum.EmptyDefineId,
			mainRes = RoomResourceEnum.ResourceId.Empty,
			rotate = 0,
			blockState = RoomBlockEnum.BlockState.Fake
		}
	end,
	serverInfoToBuildingInfo = function (slot0)
		if slot0.use then
			-- Nothing
		else
			slot1.buildingState = RoomBuildingEnum.BuildingState.Inventory
		end

		return {
			uid = slot0.uid,
			buildingId = slot0.defineId,
			rotate = slot0.rotate,
			buildingState = RoomBuildingEnum.BuildingState.Map,
			x = slot0.x,
			y = slot0.y,
			resAreaDirection = slot0.resAreaDirection,
			use = slot0.use,
			level = slot0.level
		}
	end,
	buildingMOToBuildingInfo = function (slot0)
		if slot0:isInMap() then
			-- Nothing
		end

		return {
			uid = slot0.uid,
			buildingId = slot0.buildingId,
			rotate = slot0.rotate,
			buildingState = slot0.buildingState,
			x = slot0.hexPoint.x,
			y = slot0.hexPoint.y,
			resAreaDirection = slot0.resAreaDirection,
			level = slot0.level
		}
	end,
	serverInfoToCharacterInfo = function (slot0)
		return {
			heroId = slot0.heroId,
			currentFaith = slot0.currentFaith,
			currentMinute = slot0.currentMinute,
			nextRefreshTime = slot0.nextRefreshTime,
			skinId = slot0.skin,
			currentPosition = Vector3.zero,
			characterState = RoomCharacterEnum.CharacterState.Map
		}
	end,
	generateTempCharacterInfo = function (slot0, slot1, slot2)
		return {
			heroId = slot0,
			currentFaith = 0,
			currentMinute = 0,
			nextRefreshTime = 0,
			skinId = slot2,
			currentPosition = slot1,
			characterState = RoomCharacterEnum.CharacterState.Temp
		}
	end,
	generateTrainCharacterInfo = function (slot0, slot1, slot2)
		slot3 = uv0.generateTempCharacterInfo(slot0, slot1, slot2)
		slot3.characterState = RoomCharacterEnum.CharacterState.Map
		slot3.sourceState = RoomCharacterEnum.SourceState.Train

		return slot3
	end
}
