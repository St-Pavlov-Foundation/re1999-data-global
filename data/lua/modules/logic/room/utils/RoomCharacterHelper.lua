module("modules.logic.room.utils.RoomCharacterHelper", package.seeall)

local var_0_0 = {
	getCharacterPosition = function(arg_1_0)
		return HexMath.resourcePointToPosition(arg_1_0, RoomBlockEnum.BlockSize, 0.33)
	end
}

function var_0_0.getCharacterPosition3D(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.getCharacterPosition(arg_2_0)
	local var_2_1 = arg_2_1 and var_0_0.getLandHeightByRaycast(Vector3(var_2_0.x, 0, var_2_0.y)) or RoomCharacterEnum.CharacterHeightOffset

	return Vector3(var_2_0.x, var_2_1, var_2_0.y)
end

function var_0_0.reCalculateHeight(arg_3_0)
	local var_3_0 = var_0_0.getLandHeightByRaycast(Vector3(arg_3_0.x, 0, arg_3_0.z))

	return Vector3(arg_3_0.x, var_3_0, arg_3_0.z)
end

function var_0_0.getLandHeightByAStarPath(arg_4_0)
	return GameSceneMgr.instance:getCurScene().path:getNearestNodeHeight(arg_4_0)
end

function var_0_0.getLandHeightByRaycast(arg_5_0)
	local var_5_0, var_5_1 = ZProj.RoomHelper.GetLandHeightByRaycast(arg_5_0, SceneTag.RoomLand, 0)

	if var_5_0 then
		return var_5_1
	end

	return RoomCharacterEnum.CharacterHeightOffset
end

function var_0_0.pointListToPositionList3D(arg_6_0, arg_6_1)
	if not arg_6_0 then
		return nil
	end

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
		table.insert(var_6_0, var_0_0.getCharacterPosition3D(iter_6_1, arg_6_1))
	end

	return var_6_0
end

function var_0_0.positionRoundToPoint(arg_7_0)
	arg_7_0 = Vector2(arg_7_0.x, arg_7_0.z)

	local var_7_0, var_7_1 = HexMath.positionToRoundHex(arg_7_0, RoomBlockEnum.BlockSize)
	local var_7_2 = HexMath.hexToPosition(var_7_0, RoomBlockEnum.BlockSize)
	local var_7_3 = math.sqrt(3)

	if Vector2.Distance(var_7_2, arg_7_0) < RoomBlockEnum.BlockSize * var_7_3 / 6 then
		return ResourcePoint(var_7_0, 0)
	else
		return ResourcePoint(var_7_0, var_7_1)
	end
end

function var_0_0.canTryPlace(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0, var_8_1 = HexMath.positionToRoundHex(Vector2.New(arg_8_1.x, arg_8_1.z), RoomBlockEnum.BlockSize)
	local var_8_2 = RoomBuildingHelper.getOccupyBuildingParam(var_8_0, true)

	if var_8_2 and not var_8_2.isCanPlace then
		return false
	end

	local var_8_3 = RoomCharacterModel.instance:getList()

	for iter_8_0, iter_8_1 in ipairs(var_8_3) do
		local var_8_4 = iter_8_1.currentPosition

		if iter_8_1.characterState ~= RoomCharacterEnum.CharacterState.Temp then
			if iter_8_1.characterState == RoomCharacterEnum.CharacterState.Revert then
				var_8_4 = RoomCharacterModel.instance:getRevertPosition()
			end

			if var_0_0.isTooNear(var_8_4, arg_8_1) and arg_8_0 ~= iter_8_1.heroId then
				return false
			end
		end
	end

	local var_8_5 = RoomMapBlockModel.instance:getBlockMO(var_8_0.x, var_8_0.y)

	if not var_8_5 or var_8_5.blockState ~= RoomBlockEnum.BlockState.Map then
		return false
	end

	local var_8_6 = var_0_0.reCalculateHeight(arg_8_1)
	local var_8_7 = SkinConfig.instance:getSkinCo(arg_8_2)
	local var_8_8 = var_8_7 and var_8_7.canWade > 0

	if not var_8_8 and var_8_5:getResourceId(var_8_1) == RoomResourceEnum.ResourceId.River then
		return false
	end

	local var_8_9 = var_0_0.getTag(var_8_8)

	if not ZProj.AStarPathBridge.IsWalkable(var_8_6.x, var_8_6.y, var_8_6.z, var_8_9) then
		return false
	end

	return true
end

function var_0_0.isTooNear(arg_9_0, arg_9_1)
	return Vector2.Distance(Vector2.New(arg_9_0.x, arg_9_0.z), Vector2.New(arg_9_1.x, arg_9_1.z)) < RoomCharacterEnum.TooNearDistance
end

function var_0_0.canConfirmPlace(arg_10_0, arg_10_1, arg_10_2)
	return var_0_0.canTryPlace(arg_10_0, arg_10_1, arg_10_2)
end

function var_0_0.canMove(arg_11_0)
	local var_11_0 = arg_11_0.hexPoint
	local var_11_1 = RoomBuildingHelper.getOccupyBuildingParam(var_11_0, true)

	if var_11_1 and not var_11_1.isCanPlace then
		return false
	end

	local var_11_2 = RoomMapBlockModel.instance:getBlockMO(var_11_0.x, var_11_0.y)

	if not var_11_2 or var_11_2.blockState ~= RoomBlockEnum.BlockState.Map then
		return false
	end

	return true
end

function var_0_0.checkMoveStraightRule(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = var_0_0.positionRoundToPoint(arg_12_1)

	if not var_0_0.canMove(var_12_0, true) then
		return false
	end

	if var_0_0.isOtherCharacter(arg_12_1, arg_12_2) then
		return false
	end

	if not var_0_0.checkMoveDistance(arg_12_1, arg_12_0) then
		return false
	end

	if not var_0_0.isMoveCameraWalkable({
		arg_12_0,
		arg_12_1
	}, true, arg_12_4) then
		return false
	end

	local var_12_1 = arg_12_3.charactermove:getSeeker()
	local var_12_2 = arg_12_0
	local var_12_3 = arg_12_1

	if not ZProj.AStarPathBridge.IsWalkable(var_12_3.x, var_12_3.y, var_12_3.z, var_12_1:GetTag()) then
		return false
	end

	return true
end

function var_0_0.checkMoveDistance(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.x - arg_13_1.x
	local var_13_1 = arg_13_0.z - arg_13_1.z
	local var_13_2 = var_13_0 * var_13_0 + var_13_1 * var_13_1

	if var_13_2 > RoomBlockEnum.BlockSize * RoomBlockEnum.BlockSize * 8 then
		return false
	end

	if var_13_2 < RoomBlockEnum.BlockSize * RoomBlockEnum.BlockSize / 64 then
		return false
	end

	return true
end

function var_0_0.isOtherCharacter(arg_14_0, arg_14_1)
	local var_14_0 = RoomCharacterModel.instance:getList()

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if iter_14_1.heroId ~= arg_14_1 then
			if var_0_0.isTooNear(iter_14_1.currentPosition, arg_14_0) then
				return true
			end

			if var_0_0.isTooNear(iter_14_1:getMoveTargetPosition(), arg_14_0) then
				return true
			end
		end
	end

	return false
end

function var_0_0.isMoveCameraWalkable(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_0 or #arg_15_0 < 2 then
		return false
	end

	local var_15_0 = GameSceneMgr.instance:getCurScene().camera.camera.transform
	local var_15_1 = Vector2.Normalize(Vector2(var_15_0.forward.x, var_15_0.forward.z))
	local var_15_2 = 0

	for iter_15_0 = 1, #arg_15_0 - 1 do
		local var_15_3 = arg_15_0[iter_15_0]
		local var_15_4 = arg_15_0[iter_15_0 + 1]
		local var_15_5 = var_15_4.x - var_15_3.x
		local var_15_6 = var_15_4.z - var_15_3.z
		local var_15_7 = var_15_5 * var_15_5 + var_15_6 * var_15_6

		if var_15_7 > 0.0001 then
			local var_15_8 = Vector2.Normalize(Vector2.New(var_15_5, var_15_6))
			local var_15_9 = RoomCharacterEnum.MoveStraightAngleLimit

			if arg_15_2 then
				var_15_9 = RoomCharacterEnum.MoveThroughBridge
			elseif arg_15_1 then
				var_15_9 = RoomCharacterEnum.MoveStraightAngleLimitStrict
			end

			local var_15_10 = math.cos(math.rad(90 - var_15_9))

			if var_15_10 < Vector2.Dot(var_15_8, var_15_1) then
				var_15_2 = var_15_2 + math.sqrt(var_15_7)
			elseif var_15_10 < Vector2.Dot(-var_15_8, var_15_1) then
				var_15_2 = var_15_2 + math.sqrt(var_15_7)
			end

			if var_15_2 > 0.01 then
				return false
			end
		end
	end

	return true
end

function var_0_0.getCanConfirmPlaceDict(arg_16_0, arg_16_1)
	local var_16_0 = {}
	local var_16_1 = RoomMapBlockModel.instance:getBlockMODict()

	for iter_16_0, iter_16_1 in pairs(var_16_1) do
		for iter_16_2, iter_16_3 in pairs(iter_16_1) do
			if iter_16_3.blockState == RoomBlockEnum.BlockState.Map then
				for iter_16_4 = 0, 6 do
					local var_16_2 = ResourcePoint(HexPoint(iter_16_0, iter_16_2), iter_16_4)
					local var_16_3 = var_0_0.getCharacterPosition3D(var_16_2)

					if var_0_0.canConfirmPlace(arg_16_0, var_16_3, arg_16_1) then
						var_16_0[iter_16_0] = var_16_0[iter_16_0] or {}
						var_16_0[iter_16_0][iter_16_2] = var_16_0[iter_16_0][iter_16_2] or {}
						var_16_0[iter_16_0][iter_16_2][iter_16_4] = true
					end
				end
			end
		end
	end

	return var_16_0
end

function var_0_0.getSelectPositionList()
	local var_17_0 = {}
	local var_17_1 = RoomMapBlockModel.instance:getBlockMODict()

	for iter_17_0, iter_17_1 in pairs(var_17_1) do
		for iter_17_2, iter_17_3 in pairs(iter_17_1) do
			if iter_17_3.blockState == RoomBlockEnum.BlockState.Map then
				local var_17_2

				for iter_17_4 = 0, 6 do
					local var_17_3 = ResourcePoint(HexPoint(iter_17_0, iter_17_2), iter_17_4)
					local var_17_4 = var_0_0.getCharacterPosition3D(var_17_3)

					if iter_17_4 == 0 then
						var_17_2 = var_17_4
					end

					table.insert(var_17_0, var_17_4)
				end

				local var_17_5 = {}
				local var_17_6 = 0.64 * RoomBlockEnum.BlockSize
				local var_17_7 = 0.16 * RoomBlockEnum.BlockSize
				local var_17_8 = Vector2(0, var_17_6)
				local var_17_9 = Vector2(-var_17_7, var_17_6)
				local var_17_10 = Vector2(var_17_7, var_17_6)

				table.insert(var_17_5, var_17_8)
				table.insert(var_17_5, var_17_9)
				table.insert(var_17_5, var_17_10)

				for iter_17_5 = 0, 5 do
					local var_17_11 = iter_17_5 * math.pi / 3

					for iter_17_6, iter_17_7 in ipairs(var_17_5) do
						local var_17_12 = Vector3(var_17_2.x + iter_17_7.x * math.cos(var_17_11) - iter_17_7.y * math.sin(var_17_11), 0, var_17_2.z + iter_17_7.y * math.cos(var_17_11) + iter_17_7.x * math.sin(var_17_11))

						table.insert(var_17_0, var_17_12)
					end
				end
			end
		end
	end

	return var_17_0
end

function var_0_0.getRecommendHexPoint(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_2 then
		local var_18_0 = GameSceneMgr.instance:getCurScene().camera:getCameraParam()

		arg_18_2 = Vector2(var_18_0.focusX, var_18_0.focusY)
	end

	local var_18_1 = var_0_0.reCalculateHeight(Vector3.New(arg_18_2.x, 0, arg_18_2.y))

	if var_0_0.canConfirmPlace(arg_18_0, var_18_1, arg_18_1) then
		local var_18_2, var_18_3 = HexMath.positionToRoundHex(arg_18_2, RoomBlockEnum.BlockSize)

		return {
			distance = 0,
			hexPoint = var_18_2,
			direction = var_18_3,
			position = var_18_1
		}
	end

	local var_18_4 = SkinConfig.instance:getSkinCo(arg_18_1)
	local var_18_5 = var_18_4 and var_18_4.canWade > 0
	local var_18_6 = var_0_0.getTag(var_18_5)
	local var_18_7, var_18_8 = ZProj.AStarPathBridge.GetNearestNodePosition(var_18_1, var_18_6, Vector3.zero)

	if var_18_7 and var_0_0.canConfirmPlace(arg_18_0, var_18_8, arg_18_1) then
		local var_18_9 = var_0_0.reCalculateHeight(var_18_8)
		local var_18_10, var_18_11 = HexMath.positionToRoundHex(Vector2(var_18_9.x, var_18_9.z), RoomBlockEnum.BlockSize)

		return {
			hexPoint = var_18_10,
			direction = var_18_11,
			distance = Vector2.Distance(var_18_9, arg_18_2),
			position = var_18_9
		}
	end

	local var_18_12 = var_0_0.getSelectPositionList(arg_18_0, arg_18_1)
	local var_18_13 = {}
	local var_18_14 = {}

	for iter_18_0, iter_18_1 in ipairs(var_18_12) do
		table.insert(var_18_13, iter_18_0)
		table.insert(var_18_14, RoomHelper.vector3Distance2(iter_18_1, var_18_1))
	end

	table.sort(var_18_13, function(arg_19_0, arg_19_1)
		return var_18_14[arg_19_0] < var_18_14[arg_19_1]
	end)

	for iter_18_2, iter_18_3 in ipairs(var_18_13) do
		local var_18_15 = var_18_12[iter_18_3]

		if var_0_0.canConfirmPlace(arg_18_0, var_18_15, arg_18_1) then
			local var_18_16, var_18_17 = HexMath.positionToRoundHex(var_18_15, RoomBlockEnum.BlockSize)

			return {
				hexPoint = var_18_16,
				direction = var_18_17,
				distance = Vector2.Distance(var_18_15, arg_18_2),
				position = var_18_15
			}
		end
	end

	local var_18_18 = var_0_0.getCanConfirmPlaceDict(arg_18_0, arg_18_1)
	local var_18_19

	for iter_18_4, iter_18_5 in pairs(var_18_18) do
		for iter_18_6, iter_18_7 in pairs(iter_18_5) do
			for iter_18_8, iter_18_9 in pairs(iter_18_7) do
				local var_18_20 = {
					hexPoint = HexPoint(iter_18_4, iter_18_6),
					direction = iter_18_8
				}
				local var_18_21 = ResourcePoint(var_18_20.hexPoint, var_18_20.direction)

				var_18_20.position = var_0_0.getCharacterPosition3D(var_18_21, true)
				var_18_20.distance = Vector2.Distance(Vector2(var_18_20.position.x, var_18_20.position.z), arg_18_2)

				if not var_18_19 then
					var_18_19 = var_18_20
				else
					var_18_19 = var_0_0._compareRecommendParams(var_18_19, var_18_20)
				end
			end
		end
	end

	return var_18_19
end

function var_0_0.getGuideRecommendHexPoint(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = var_0_0.getCanConfirmPlaceDict(arg_20_0, arg_20_1)
	local var_20_1 = HexMath.hexToPosition(arg_20_2, RoomBlockEnum.BlockSize)
	local var_20_2

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		for iter_20_2, iter_20_3 in pairs(iter_20_1) do
			for iter_20_4, iter_20_5 in pairs(iter_20_3) do
				if iter_20_0 ~= arg_20_2.x or iter_20_2 ~= arg_20_2.y then
					local var_20_3 = {
						hexPoint = HexPoint(iter_20_0, iter_20_2),
						direction = iter_20_4
					}

					var_20_3.distance = Vector2.Distance(HexMath.hexToPosition(var_20_3.hexPoint, RoomBlockEnum.BlockSize), var_20_1)
					var_20_3.position = var_0_0.getCharacterPosition3D(ResourcePoint(var_20_3.hexPoint, var_20_3.direction), true)
					var_20_3.priority = 100

					if RoomMapBuildingModel.instance:isHasBuilding(iter_20_0, iter_20_2) then
						var_20_3.priority = 0
					elseif RoomBuildingHelper.isInInitBuildingOccupy(var_20_3.hexPoint) then
						var_20_3.priority = 0
					end

					if not var_20_2 then
						var_20_2 = var_20_3
					else
						var_20_2 = var_0_0._compareGuideRecommendParams(var_20_2, var_20_3)
					end
				end
			end
		end
	end

	return var_20_2
end

function var_0_0._compareGuideRecommendParams(arg_21_0, arg_21_1)
	if arg_21_0.priority ~= arg_21_1.priority then
		return arg_21_0.priority > arg_21_1.priority and arg_21_0 or arg_21_1
	end

	return arg_21_0.distance > arg_21_1.distance and arg_21_1 or arg_21_0
end

function var_0_0._compareRecommendParams(arg_22_0, arg_22_1)
	return arg_22_0.distance > arg_22_1.distance and arg_22_1 or arg_22_0
end

function var_0_0.getNeedRemoveCount()
	local var_23_0 = RoomCharacterModel.instance:getMaxCharacterCount()
	local var_23_1 = RoomCharacterModel.instance:getConfirmCharacterCount()

	if var_23_0 < var_23_1 then
		return var_23_1 - var_23_0
	end

	return 0
end

function var_0_0.offsetForwardNearPosition(arg_24_0, arg_24_1)
	local var_24_0 = GameSceneMgr.instance:getCurScene()
	local var_24_1 = var_24_0.charactermgr:getCharacterEntity(arg_24_1.id, SceneTag.RoomCharacter).characterspine:getLookDir()
	local var_24_2 = var_24_0.camera.camera.transform
	local var_24_3 = Vector2.Normalize(Vector2(var_24_2.right.x, var_24_2.right.z))

	if var_24_1 == SpineLookDir.Left then
		var_24_3 = -var_24_3
	end

	arg_24_0 = arg_24_0 + var_24_3 * RoomBlockEnum.BlockSize * math.sqrt(3) / 2

	return arg_24_0
end

function var_0_0.getTag(arg_25_0)
	local var_25_0 = RoomEnum.AStarLayerTag.Water
	local var_25_1 = bit.bxor(bit.bnot(0), bit.lshift(1, RoomEnum.AStarLayerTag.NoWalkRoad))

	if arg_25_0 then
		return var_25_1
	else
		return bit.bxor(var_25_1, bit.lshift(1, var_25_0))
	end
end

function var_0_0.getRandomPosition()
	local var_26_0 = RoomMapBlockModel.instance:getFullBlockMOList()

	if var_26_0 and #var_26_0 > 0 then
		local var_26_1 = var_26_0[math.random(1, #var_26_0)]
		local var_26_2 = ResourcePoint(var_26_1.hexPoint, math.random(0, 6))

		return var_0_0.getCharacterPosition3D(var_26_2, false)
	end
end

function var_0_0.checkCharacterAnimalInteraction(arg_27_0)
	local var_27_0
	local var_27_1 = lua_room_character_interaction.configList

	for iter_27_0, iter_27_1 in ipairs(var_27_1) do
		if iter_27_1.heroId == arg_27_0 and iter_27_1.behaviour == RoomCharacterEnum.InteractionType.Animal then
			var_27_0 = iter_27_1

			break
		end
	end

	if not var_27_0 then
		return false
	end

	return var_0_0.checkInteractionValid(var_27_0)
end

function var_0_0.checkInteractionValid(arg_28_0)
	if not arg_28_0 then
		return false
	end

	local var_28_0 = RoomCharacterModel.instance:getCharacterMOById(arg_28_0.heroId)

	if not var_28_0 or var_28_0.characterState ~= RoomCharacterEnum.CharacterState.Map and not var_28_0:getCurrentInteractionId() then
		return false
	end

	if arg_28_0.relateHeroId ~= 0 then
		local var_28_1 = RoomCharacterModel.instance:getCharacterMOById(arg_28_0.relateHeroId)

		if not var_28_1 or var_28_1.characterState ~= RoomCharacterEnum.CharacterState.Map and not var_28_1:getCurrentInteractionId() then
			return false
		end
	end

	if arg_28_0.buildingId ~= 0 then
		local var_28_2 = false
		local var_28_3 = RoomMapBuildingModel.instance:getBuildingMOList()

		for iter_28_0, iter_28_1 in ipairs(var_28_3) do
			if iter_28_1.buildingId == arg_28_0.buildingId and iter_28_1.buildingState == RoomBuildingEnum.BuildingState.Map and not iter_28_1:getCurrentInteractionId() then
				var_28_2 = true

				break
			end
		end

		if not var_28_2 then
			return false
		end
	end

	if math.random() >= arg_28_0.rate / 1000 then
		return false
	end

	if arg_28_0.faithDialog and arg_28_0.behaviour == RoomCharacterEnum.InteractionType.Dialog and arg_28_0.faithDialog > 0 then
		local var_28_4 = HeroModel.instance:getByHeroId(arg_28_0.heroId)

		if var_28_4 and HeroConfig.instance:getFaithPercent(var_28_4.faith)[1] * 1000 < arg_28_0.faithDialog then
			return false
		end
	end

	return true
end

function var_0_0.isInDialogInteraction()
	local var_29_0 = RoomCharacterController.instance:getPlayingInteractionParam()

	return var_29_0 and var_29_0.behaviour == RoomCharacterEnum.InteractionType.Dialog
end

function var_0_0.interactionIsDialogWithSelect(arg_30_0)
	local var_30_0 = RoomConfig.instance:getCharacterInteractionConfig(arg_30_0)

	if var_30_0.behaviour ~= RoomCharacterEnum.InteractionType.Dialog then
		return false
	end

	local var_30_1 = var_30_0.dialogId
	local var_30_2 = 0

	while true do
		var_30_2 = var_30_2 + 1

		local var_30_3 = RoomConfig.instance:getCharacterDialogConfig(var_30_1, var_30_2)

		if not var_30_3 then
			break
		end

		if not string.nilorempty(var_30_3.selectIds) then
			return true
		end
	end

	return false
end

function var_0_0.isCharacterBlock(arg_31_0, arg_31_1)
	if not arg_31_1 then
		return false
	end

	local var_31_0 = CameraMgr.instance:getMainCameraGO().transform.position
	local var_31_1 = Vector3.Distance(arg_31_0, var_31_0)

	for iter_31_0, iter_31_1 in ipairs(arg_31_1) do
		if var_31_1 < Vector3.Distance(iter_31_1, var_31_0) then
			return true
		end
	end

	return false
end

function var_0_0.getAllBlockMeshRendererList()
	local var_32_0 = GameSceneMgr.instance:getCurScene()
	local var_32_1 = {}

	LuaUtil.insertDict(var_32_1, var_32_0.mapmgr:getTagUnitDict(SceneTag.RoomMapBlock))
	LuaUtil.insertDict(var_32_1, var_32_0.mapmgr:getTagUnitDict(SceneTag.RoomEmptyBlock))
	LuaUtil.insertDict(var_32_1, var_32_0.buildingmgr:getTagUnitDict(SceneTag.RoomBuilding))
	LuaUtil.insertDict(var_32_1, var_32_0.buildingmgr:getTagUnitDict(SceneTag.RoomInitBuilding))
	LuaUtil.insertDict(var_32_1, var_32_0.buildingmgr:getTagUnitDict(SceneTag.RoomPartBuilding))

	local var_32_2 = {}

	for iter_32_0, iter_32_1 in ipairs(var_32_1) do
		tabletool.addValues(var_32_2, iter_32_1:getCharacterMeshRendererList())
	end

	return var_32_2
end

function var_0_0.getAllBlockCharacterGOList()
	local var_33_0 = GameSceneMgr.instance:getCurScene()
	local var_33_1 = {}
	local var_33_2 = var_33_0.charactermgr:getRoomCharacterEntityDict()

	for iter_33_0, iter_33_1 in pairs(var_33_2) do
		local var_33_3 = iter_33_1.characterspine:getCharacterGO()

		if var_33_3 then
			table.insert(var_33_1, var_33_3)
		end
	end

	return var_33_1
end

local var_0_1 = {
	z = 0,
	x = 0,
	y = 0
}
local var_0_2 = {
	z = 0,
	x = 0,
	y = 0
}

function var_0_0.isBlockCharacter(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_0 and #arg_34_0 > 0 then
		local var_34_0 = arg_34_2.bounds
		local var_34_1 = arg_34_2.extents
		local var_34_2 = arg_34_2.center

		if var_34_2.y + var_34_1.y < 0.2 then
			return false
		end

		local var_34_3 = var_0_1
		local var_34_4 = var_0_2
		local var_34_5, var_34_6, var_34_7 = RoomBendingHelper.worldToBendingXYZ(var_34_2, true)

		var_34_3.x = var_34_5 - var_34_1.x
		var_34_3.y = var_34_6 - var_34_1.y - 0.2
		var_34_3.z = var_34_7 - var_34_1.z
		var_34_4.x = var_34_5 + var_34_1.x
		var_34_4.y = var_34_6 + var_34_1.y + 0.2
		var_34_4.z = var_34_7 + var_34_1.z

		for iter_34_0 = 1, #arg_34_0 do
			if var_0_0.testAABB(arg_34_0[iter_34_0], arg_34_1[iter_34_0], var_34_3, var_34_4) then
				return true
			end
		end
	end

	return false
end

local var_0_3 = {
	"x",
	"y",
	"z"
}

function var_0_0.testAABB(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = 0
	local var_35_1 = arg_35_1
	local var_35_2 = var_0_3
	local var_35_3 = arg_35_0.direction
	local var_35_4 = arg_35_0.origin

	for iter_35_0, iter_35_1 in ipairs(var_35_2) do
		if math.abs(var_35_3[iter_35_1]) < 0.01 then
			if var_35_4[iter_35_1] < arg_35_2[iter_35_1] or var_35_4[iter_35_1] > arg_35_3[iter_35_1] then
				return false
			end
		else
			local var_35_5 = 1 / var_35_3[iter_35_1]
			local var_35_6 = (arg_35_2[iter_35_1] - var_35_4[iter_35_1]) * var_35_5
			local var_35_7 = (arg_35_3[iter_35_1] - var_35_4[iter_35_1]) * var_35_5

			if var_35_7 < var_35_6 then
				var_35_6, var_35_7 = var_35_7, var_35_6
			end

			if var_35_0 < var_35_6 then
				var_35_0 = var_35_6
			end

			if var_35_7 < var_35_1 then
				var_35_1 = var_35_7
			end

			if var_35_1 < var_35_0 then
				return false
			end
		end
	end

	return true
end

function var_0_0.getBridgePositions(arg_36_0)
	local var_36_0 = {}
	local var_36_1 = GameSceneMgr.instance:getCurScene()
	local var_36_2 = {}
	local var_36_3 = {}

	LuaUtil.insertDict(var_36_3, var_36_1.mapmgr:getTagUnitDict(SceneTag.RoomMapBlock))

	for iter_36_0, iter_36_1 in ipairs(var_36_3) do
		tabletool.addValues(var_36_2, iter_36_1:getGameObjectListByName("characterPathPoint"))
	end

	for iter_36_2, iter_36_3 in ipairs(var_36_2) do
		local var_36_4 = iter_36_3.transform.position

		if var_0_0.checkMoveDistance(arg_36_0, var_36_4) then
			table.insert(var_36_0, var_36_4)
		end
	end

	return var_36_0
end

function var_0_0.getCharacterFaithFill(arg_37_0)
	if arg_37_0.currentFaith <= 0 then
		return 0
	end

	local var_37_0 = CommonConfig.instance:getConstNum(ConstEnum.RoomCharacterFaithTotalMinute)

	return arg_37_0.currentMinute / var_37_0
end

function var_0_0.getCharacterInteractionId(arg_38_0)
	for iter_38_0, iter_38_1 in ipairs(lua_room_character_interaction.configList) do
		if iter_38_1.heroId == arg_38_0 and iter_38_1.behaviour == RoomCharacterEnum.InteractionType.Dialog and iter_38_1.relateHeroId == 0 then
			return iter_38_1.id
		end
	end
end

function var_0_0.getIdleAnimStateName(arg_39_0)
	return RoomCharacterEnum.CharacterIdleAnimReplaceName[arg_39_0] or RoomCharacterEnum.CharacterAnimStateName.Idle
end

function var_0_0.getAnimStateName(arg_40_0, arg_40_1)
	if arg_40_0 == RoomCharacterEnum.CharacterMoveState.Idle then
		return var_0_0.getIdleAnimStateName(arg_40_1)
	end

	return RoomCharacterEnum.CharacterAnimState[arg_40_0]
end

function var_0_0.getNextAnimStateName(arg_41_0, arg_41_1)
	local var_41_0
	local var_41_1 = RoomCharacterEnum.CharacterNextAnimNameDict[arg_41_0]

	if var_41_1 then
		var_41_0 = var_41_1[arg_41_1]

		if not var_41_0 and RoomCharacterEnum.LoopAnimState[arg_41_1] then
			var_41_0 = arg_41_1
		end
	end

	return var_41_0
end

function var_0_0.getSpinePointPath(arg_42_0)
	if string.nilorempty(arg_42_0) or arg_42_0 == "mountroot" then
		return "mountroot"
	end

	return "mountroot/" .. arg_42_0
end

function var_0_0.hasWaterNodeNear(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0.x
	local var_43_1 = arg_43_0.z
	local var_43_2 = (arg_43_1 + RoomBlockEnum.BlockSize)^2
	local var_43_3 = RoomCharacterModel.instance:getEmptyBlockPositions()

	for iter_43_0, iter_43_1 in ipairs(var_43_3) do
		if var_43_2 >= (iter_43_1.x - var_43_0)^2 + (iter_43_1.y - var_43_1)^2 then
			return true
		end
	end

	local var_43_4 = arg_43_1^2
	local var_43_5 = RoomCharacterModel.instance:getWaterNodePositions()

	for iter_43_2, iter_43_3 in ipairs(var_43_5) do
		if var_43_4 >= (iter_43_3.x - var_43_0)^2 + (iter_43_3.z - var_43_1)^2 then
			return true
		end
	end

	return false
end

return var_0_0
