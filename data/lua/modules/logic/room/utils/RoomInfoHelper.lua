module("modules.logic.room.utils.RoomInfoHelper", package.seeall)

local var_0_0 = {
	serverInfoToBlockInfo = function(arg_1_0)
		local var_1_0 = {}
		local var_1_1

		if arg_1_0.fishingBlockId then
			var_1_0.fishingBlockId = arg_1_0.fishingBlockId
		else
			var_1_1 = RoomConfig.instance:getBlock(arg_1_0.blockId)

			if not var_1_1 and not RoomController.instance:isDebugMode() then
				logError(string.format("can not find blockCfg [blockId:%s]", arg_1_0.blockId))
			end

			var_1_0.blockId = arg_1_0.blockId
		end

		var_1_0.defineId = arg_1_0.defineId or var_1_1 and var_1_1.defineId or RoomBlockEnum.EmptyDefineId
		var_1_0.mainRes = arg_1_0.mainRes or var_1_1 and var_1_1.mainRes or -1
		var_1_0.packageId = arg_1_0.packageId or var_1_1 and var_1_1.packageId or 0
		var_1_0.packageOrder = arg_1_0.packageOrder or var_1_1 and var_1_1.packageOrder or 0
		var_1_0.rotate = arg_1_0.rotate or 0
		var_1_0.waterType = arg_1_0.waterType
		var_1_0.blockColor = arg_1_0.blockColor

		if arg_1_0.use ~= false then
			var_1_0.blockState = RoomBlockEnum.BlockState.Map
			var_1_0.x = arg_1_0.x
			var_1_0.y = arg_1_0.y
		else
			var_1_0.blockState = RoomBlockEnum.BlockState.Inventory
		end

		return var_1_0
	end,
	blockMOToBlockInfo = function(arg_2_0)
		local var_2_0 = {
			blockId = arg_2_0.blockId,
			defineId = arg_2_0.defineId,
			mainRes = arg_2_0.mainRes,
			packageId = arg_2_0.packageId,
			rotate = arg_2_0.rotate,
			blockState = arg_2_0.blockState,
			blockColor = arg_2_0.blockColor
		}

		if arg_2_0:isInMap() then
			var_2_0.x = arg_2_0.hexPoint.x
			var_2_0.y = arg_2_0.hexPoint.y
		end

		return var_2_0
	end,
	generateEmptyMapBlockInfo = function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		local var_3_0 = {
			blockId = arg_3_0,
			defineId = RoomResourceEnum.EmptyDefineId,
			mainRes = RoomResourceEnum.ResourceId.Empty
		}

		var_3_0.rotate = 0
		var_3_0.blockState = RoomBlockEnum.BlockState.Water
		var_3_0.distanceStyle = arg_3_3
		var_3_0.x = arg_3_1
		var_3_0.y = arg_3_2

		return var_3_0
	end,
	generateFakeMapBlockInfo = function(arg_4_0)
		local var_4_0 = {
			blockId = arg_4_0,
			defineId = RoomResourceEnum.EmptyDefineId,
			mainRes = RoomResourceEnum.ResourceId.Empty
		}

		var_4_0.rotate = 0
		var_4_0.blockState = RoomBlockEnum.BlockState.Fake

		return var_4_0
	end,
	serverInfoToBuildingInfo = function(arg_5_0)
		local var_5_0 = {
			uid = arg_5_0.uid,
			buildingId = arg_5_0.defineId,
			rotate = arg_5_0.rotate
		}

		if arg_5_0.use then
			var_5_0.buildingState = RoomBuildingEnum.BuildingState.Map
			var_5_0.x = arg_5_0.x
			var_5_0.y = arg_5_0.y
		else
			var_5_0.buildingState = RoomBuildingEnum.BuildingState.Inventory
		end

		var_5_0.resAreaDirection = arg_5_0.resAreaDirection
		var_5_0.use = arg_5_0.use
		var_5_0.level = arg_5_0.level
		var_5_0.belongUserId = arg_5_0.belongUserId

		return var_5_0
	end,
	buildingMOToBuildingInfo = function(arg_6_0)
		local var_6_0 = {
			uid = arg_6_0.uid,
			buildingId = arg_6_0.buildingId,
			rotate = arg_6_0.rotate,
			buildingState = arg_6_0.buildingState
		}

		if arg_6_0:isInMap() then
			var_6_0.x = arg_6_0.hexPoint.x
			var_6_0.y = arg_6_0.hexPoint.y
		end

		var_6_0.resAreaDirection = arg_6_0.resAreaDirection
		var_6_0.level = arg_6_0.level

		return var_6_0
	end,
	serverInfoToCharacterInfo = function(arg_7_0)
		return {
			heroId = arg_7_0.heroId,
			currentFaith = arg_7_0.currentFaith,
			currentMinute = arg_7_0.currentMinute,
			nextRefreshTime = arg_7_0.nextRefreshTime,
			skinId = arg_7_0.skin,
			currentPosition = Vector3.zero,
			characterState = RoomCharacterEnum.CharacterState.Map
		}
	end,
	generateTempCharacterInfo = function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = {
			heroId = arg_8_0
		}

		var_8_0.currentFaith = 0
		var_8_0.currentMinute = 0
		var_8_0.nextRefreshTime = 0
		var_8_0.skinId = arg_8_2
		var_8_0.currentPosition = arg_8_1
		var_8_0.characterState = RoomCharacterEnum.CharacterState.Temp

		return var_8_0
	end
}

function var_0_0.generateTrainCharacterInfo(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = var_0_0.generateTempCharacterInfo(arg_9_0, arg_9_1, arg_9_2)

	var_9_0.characterState = RoomCharacterEnum.CharacterState.Map
	var_9_0.sourceState = RoomCharacterEnum.SourceState.Train

	return var_9_0
end

return var_0_0
