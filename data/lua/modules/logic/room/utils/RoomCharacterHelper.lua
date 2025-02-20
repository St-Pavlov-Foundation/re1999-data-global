module("modules.logic.room.utils.RoomCharacterHelper", package.seeall)

slot1 = {
	"x",
	"y",
	"z"
}

return {
	getCharacterPosition = function (slot0)
		return HexMath.resourcePointToPosition(slot0, RoomBlockEnum.BlockSize, 0.33)
	end,
	getCharacterPosition3D = function (slot0, slot1)
		slot2 = uv0.getCharacterPosition(slot0)

		return Vector3(slot2.x, slot1 and uv0.getLandHeightByRaycast(Vector3(slot2.x, 0, slot2.y)) or RoomCharacterEnum.CharacterHeightOffset, slot2.y)
	end,
	reCalculateHeight = function (slot0)
		return Vector3(slot0.x, uv0.getLandHeightByRaycast(Vector3(slot0.x, 0, slot0.z)), slot0.z)
	end,
	getLandHeightByAStarPath = function (slot0)
		return GameSceneMgr.instance:getCurScene().path:getNearestNodeHeight(slot0)
	end,
	getLandHeightByRaycast = function (slot0)
		slot1, slot2 = ZProj.RoomHelper.GetLandHeightByRaycast(slot0, SceneTag.RoomLand, 0)

		if slot1 then
			return slot2
		end

		return RoomCharacterEnum.CharacterHeightOffset
	end,
	pointListToPositionList3D = function (slot0, slot1)
		if not slot0 then
			return nil
		end

		slot2 = {}

		for slot6, slot7 in ipairs(slot0) do
			table.insert(slot2, uv0.getCharacterPosition3D(slot7, slot1))
		end

		return slot2
	end,
	positionRoundToPoint = function (slot0)
		slot0 = Vector2(slot0.x, slot0.z)
		slot1, slot2 = HexMath.positionToRoundHex(slot0, RoomBlockEnum.BlockSize)

		if Vector2.Distance(HexMath.hexToPosition(slot1, RoomBlockEnum.BlockSize), slot0) < RoomBlockEnum.BlockSize * math.sqrt(3) / 6 then
			return ResourcePoint(slot1, 0)
		else
			return ResourcePoint(slot1, slot2)
		end
	end,
	canTryPlace = function (slot0, slot1, slot2)
		slot3, slot4 = HexMath.positionToRoundHex(Vector2.New(slot1.x, slot1.z), RoomBlockEnum.BlockSize)

		if RoomBuildingHelper.getOccupyBuildingParam(slot3, true) and not slot5.isCanPlace then
			return false
		end

		for slot10, slot11 in ipairs(RoomCharacterModel.instance:getList()) do
			slot12 = slot11.currentPosition

			if slot11.characterState ~= RoomCharacterEnum.CharacterState.Temp then
				if slot11.characterState == RoomCharacterEnum.CharacterState.Revert then
					slot12 = RoomCharacterModel.instance:getRevertPosition()
				end

				if uv0.isTooNear(slot12, slot1) and slot0 ~= slot11.heroId then
					return false
				end
			end
		end

		if not RoomMapBlockModel.instance:getBlockMO(slot3.x, slot3.y) or slot7.blockState ~= RoomBlockEnum.BlockState.Map then
			return false
		end

		slot8 = uv0.reCalculateHeight(slot1)

		if not (SkinConfig.instance:getSkinCo(slot2) and slot9.canWade > 0) and slot7:getResourceId(slot4) == RoomResourceEnum.ResourceId.River then
			return false
		end

		if not ZProj.AStarPathBridge.IsWalkable(slot8.x, slot8.y, slot8.z, uv0.getTag(slot10)) then
			return false
		end

		return true
	end,
	isTooNear = function (slot0, slot1)
		return Vector2.Distance(Vector2.New(slot0.x, slot0.z), Vector2.New(slot1.x, slot1.z)) < RoomCharacterEnum.TooNearDistance
	end,
	canConfirmPlace = function (slot0, slot1, slot2)
		return uv0.canTryPlace(slot0, slot1, slot2)
	end,
	canMove = function (slot0)
		if RoomBuildingHelper.getOccupyBuildingParam(slot0.hexPoint, true) and not slot2.isCanPlace then
			return false
		end

		if not RoomMapBlockModel.instance:getBlockMO(slot1.x, slot1.y) or slot3.blockState ~= RoomBlockEnum.BlockState.Map then
			return false
		end

		return true
	end,
	checkMoveStraightRule = function (slot0, slot1, slot2, slot3, slot4)
		if not uv0.canMove(uv0.positionRoundToPoint(slot1), true) then
			return false
		end

		if uv0.isOtherCharacter(slot1, slot2) then
			return false
		end

		if not uv0.checkMoveDistance(slot1, slot0) then
			return false
		end

		if not uv0.isMoveCameraWalkable({
			slot0,
			slot1
		}, true, slot4) then
			return false
		end

		slot7 = slot0
		slot8 = slot1

		if not ZProj.AStarPathBridge.IsWalkable(slot8.x, slot8.y, slot8.z, slot3.charactermove:getSeeker():GetTag()) then
			return false
		end

		return true
	end,
	checkMoveDistance = function (slot0, slot1)
		slot2 = slot0.x - slot1.x
		slot3 = slot0.z - slot1.z

		if slot2 * slot2 + slot3 * slot3 > RoomBlockEnum.BlockSize * RoomBlockEnum.BlockSize * 8 then
			return false
		end

		if slot4 < RoomBlockEnum.BlockSize * RoomBlockEnum.BlockSize / 64 then
			return false
		end

		return true
	end,
	isOtherCharacter = function (slot0, slot1)
		for slot6, slot7 in ipairs(RoomCharacterModel.instance:getList()) do
			if slot7.heroId ~= slot1 then
				if uv0.isTooNear(slot7.currentPosition, slot0) then
					return true
				end

				if uv0.isTooNear(slot7:getMoveTargetPosition(), slot0) then
					return true
				end
			end
		end

		return false
	end,
	isMoveCameraWalkable = function (slot0, slot1, slot2)
		if not slot0 or #slot0 < 2 then
			return false
		end

		slot4 = GameSceneMgr.instance:getCurScene().camera.camera.transform
		slot10 = slot4.forward.z
		slot5 = Vector2.Normalize(Vector2(slot4.forward.x, slot10))
		slot6 = 0

		for slot10 = 1, #slot0 - 1 do
			slot11 = slot0[slot10]
			slot12 = slot0[slot10 + 1]
			slot13 = slot12.x - slot11.x
			slot14 = slot12.z - slot11.z

			if slot13 * slot13 + slot14 * slot14 > 0.0001 then
				slot16 = Vector2.Normalize(Vector2.New(slot13, slot14))
				slot17 = RoomCharacterEnum.MoveStraightAngleLimit

				if slot2 then
					slot17 = RoomCharacterEnum.MoveThroughBridge
				elseif slot1 then
					slot17 = RoomCharacterEnum.MoveStraightAngleLimitStrict
				end

				if math.cos(math.rad(90 - slot17)) < Vector2.Dot(slot16, slot5) then
					slot6 = slot6 + math.sqrt(slot15)
				elseif slot18 < Vector2.Dot(-slot16, slot5) then
					slot6 = slot6 + math.sqrt(slot15)
				end

				if slot6 > 0.01 then
					return false
				end
			end
		end

		return true
	end,
	getCanConfirmPlaceDict = function (slot0, slot1)
		slot2 = {}

		for slot7, slot8 in pairs(RoomMapBlockModel.instance:getBlockMODict()) do
			for slot12, slot13 in pairs(slot8) do
				if slot13.blockState == RoomBlockEnum.BlockState.Map then
					for slot17 = 0, 6 do
						if uv0.canConfirmPlace(slot0, uv0.getCharacterPosition3D(ResourcePoint(HexPoint(slot7, slot12), slot17)), slot1) then
							slot2[slot7] = slot2[slot7] or {}
							slot2[slot7][slot12] = slot2[slot7][slot12] or {}
							slot2[slot7][slot12][slot17] = true
						end
					end
				end
			end
		end

		return slot2
	end,
	getSelectPositionList = function ()
		slot0 = {}

		for slot5, slot6 in pairs(RoomMapBlockModel.instance:getBlockMODict()) do
			for slot10, slot11 in pairs(slot6) do
				if slot11.blockState == RoomBlockEnum.BlockState.Map then
					slot12 = nil

					for slot16 = 0, 6 do
						slot18 = uv0.getCharacterPosition3D(ResourcePoint(HexPoint(slot5, slot10), slot16))

						if slot16 == 0 then
							slot12 = slot18
						end

						table.insert(slot0, slot18)
					end

					slot13 = {}
					slot14 = 0.64 * RoomBlockEnum.BlockSize
					slot15 = 0.16 * RoomBlockEnum.BlockSize

					table.insert(slot13, Vector2(0, slot14))
					table.insert(slot13, Vector2(-slot15, slot14))

					slot22 = Vector2(slot15, slot14)

					table.insert(slot13, slot22)

					for slot22 = 0, 5 do
						slot23 = slot22 * math.pi / 3

						for slot27, slot28 in ipairs(slot13) do
							table.insert(slot0, Vector3(slot12.x + slot28.x * math.cos(slot23) - slot28.y * math.sin(slot23), 0, slot12.z + slot28.y * math.cos(slot23) + slot28.x * math.sin(slot23)))
						end
					end
				end
			end
		end

		return slot0
	end,
	getRecommendHexPoint = function (slot0, slot1, slot2)
		if not slot2 then
			slot4 = GameSceneMgr.instance:getCurScene().camera:getCameraParam()
			slot2 = Vector2(slot4.focusX, slot4.focusY)
		end

		if uv0.canConfirmPlace(slot0, uv0.reCalculateHeight(Vector3.New(slot2.x, 0, slot2.y)), slot1) then
			slot4, slot5 = HexMath.positionToRoundHex(slot2, RoomBlockEnum.BlockSize)

			return {
				distance = 0,
				hexPoint = slot4,
				direction = slot5,
				position = slot3
			}
		end

		slot7, slot8 = ZProj.AStarPathBridge.GetNearestNodePosition(slot3, uv0.getTag(SkinConfig.instance:getSkinCo(slot1) and slot4.canWade > 0), Vector3.zero)

		if slot7 and uv0.canConfirmPlace(slot0, slot8, slot1) then
			slot8 = uv0.reCalculateHeight(slot8)
			slot9, slot10 = HexMath.positionToRoundHex(Vector2(slot8.x, slot8.z), RoomBlockEnum.BlockSize)

			return {
				hexPoint = slot9,
				direction = slot10,
				distance = Vector2.Distance(slot8, slot2),
				position = slot8
			}
		end

		slot10 = {}

		for slot15, slot16 in ipairs(uv0.getSelectPositionList(slot0, slot1)) do
			table.insert(slot10, slot15)
			table.insert({}, RoomHelper.vector3Distance2(slot16, slot3))
		end

		function slot15(slot0, slot1)
			return uv0[slot0] < uv0[slot1]
		end

		table.sort(slot10, slot15)

		for slot15, slot16 in ipairs(slot10) do
			if uv0.canConfirmPlace(slot0, slot9[slot16], slot1) then
				slot18, slot19 = HexMath.positionToRoundHex(slot17, RoomBlockEnum.BlockSize)

				return {
					hexPoint = slot18,
					direction = slot19,
					distance = Vector2.Distance(slot17, slot2),
					position = slot17
				}
			end
		end

		slot13 = nil

		for slot17, slot18 in pairs(uv0.getCanConfirmPlaceDict(slot0, slot1)) do
			for slot22, slot23 in pairs(slot18) do
				for slot27, slot28 in pairs(slot23) do
					slot29 = {
						hexPoint = HexPoint(slot17, slot22),
						direction = slot27
					}
					slot29.position = uv0.getCharacterPosition3D(ResourcePoint(slot29.hexPoint, slot29.direction), true)
					slot29.distance = Vector2.Distance(Vector2(slot29.position.x, slot29.position.z), slot2)
					slot13 = not slot13 and slot29 or uv0._compareRecommendParams(slot29, slot29)
				end
			end
		end

		return slot13
	end,
	getGuideRecommendHexPoint = function (slot0, slot1, slot2)
		slot4 = HexMath.hexToPosition(slot2, RoomBlockEnum.BlockSize)
		slot5 = nil

		for slot9, slot10 in pairs(uv0.getCanConfirmPlaceDict(slot0, slot1)) do
			for slot14, slot15 in pairs(slot10) do
				for slot19, slot20 in pairs(slot15) do
					if slot9 ~= slot2.x or slot14 ~= slot2.y then
						slot21 = {
							hexPoint = HexPoint(slot9, slot14),
							direction = slot19
						}
						slot21.distance = Vector2.Distance(HexMath.hexToPosition(slot21.hexPoint, RoomBlockEnum.BlockSize), slot4)
						slot21.position = uv0.getCharacterPosition3D(ResourcePoint(slot21.hexPoint, slot21.direction), true)
						slot21.priority = 100

						if RoomMapBuildingModel.instance:isHasBuilding(slot9, slot14) then
							slot21.priority = 0
						elseif RoomBuildingHelper.isInInitBuildingOccupy(slot21.hexPoint) then
							slot21.priority = 0
						end

						slot5 = not slot5 and slot21 or uv0._compareGuideRecommendParams(slot21, slot21)
					end
				end
			end
		end

		return slot5
	end,
	_compareGuideRecommendParams = function (slot0, slot1)
		if slot0.priority ~= slot1.priority then
			return slot1.priority < slot0.priority and slot0 or slot1
		end

		return slot1.distance < slot0.distance and slot1 or slot0
	end,
	_compareRecommendParams = function (slot0, slot1)
		return slot1.distance < slot0.distance and slot1 or slot0
	end,
	getNeedRemoveCount = function ()
		if RoomCharacterModel.instance:getMaxCharacterCount() < RoomCharacterModel.instance:getConfirmCharacterCount() then
			return slot1 - slot0
		end

		return 0
	end,
	offsetForwardNearPosition = function (slot0, slot1)
		slot2 = GameSceneMgr.instance:getCurScene()
		slot5 = slot2.camera.camera.transform

		if slot2.charactermgr:getCharacterEntity(slot1.id, SceneTag.RoomCharacter).characterspine:getLookDir() == SpineLookDir.Left then
			slot6 = -Vector2.Normalize(Vector2(slot5.right.x, slot5.right.z))
		end

		return slot0 + slot6 * RoomBlockEnum.BlockSize * math.sqrt(3) / 2
	end,
	getTag = function (slot0)
		slot1 = RoomEnum.AStarLayerTag.Water

		if slot0 then
			return bit.bxor(bit.bnot(0), bit.lshift(1, RoomEnum.AStarLayerTag.NoWalkRoad))
		else
			return bit.bxor(slot2, bit.lshift(1, slot1))
		end
	end,
	getRandomPosition = function ()
		if RoomMapBlockModel.instance:getFullBlockMOList() and #slot0 > 0 then
			return uv0.getCharacterPosition3D(ResourcePoint(slot0[math.random(1, #slot0)].hexPoint, math.random(0, 6)), false)
		end
	end,
	checkCharacterAnimalInteraction = function (slot0)
		slot1 = nil

		for slot6, slot7 in ipairs(lua_room_character_interaction.configList) do
			if slot7.heroId == slot0 and slot7.behaviour == RoomCharacterEnum.InteractionType.Animal then
				slot1 = slot7

				break
			end
		end

		if not slot1 then
			return false
		end

		return uv0.checkInteractionValid(slot1)
	end,
	checkInteractionValid = function (slot0)
		if not slot0 then
			return false
		end

		if not RoomCharacterModel.instance:getCharacterMOById(slot0.heroId) or slot1.characterState ~= RoomCharacterEnum.CharacterState.Map and not slot1:getCurrentInteractionId() then
			return false
		end

		if slot0.relateHeroId ~= 0 and (not RoomCharacterModel.instance:getCharacterMOById(slot0.relateHeroId) or slot2.characterState ~= RoomCharacterEnum.CharacterState.Map and not slot2:getCurrentInteractionId()) then
			return false
		end

		if slot0.buildingId ~= 0 then
			slot2 = false

			for slot7, slot8 in ipairs(RoomMapBuildingModel.instance:getBuildingMOList()) do
				if slot8.buildingId == slot0.buildingId and slot8.buildingState == RoomBuildingEnum.BuildingState.Map and not slot8:getCurrentInteractionId() then
					slot2 = true

					break
				end
			end

			if not slot2 then
				return false
			end
		end

		if math.random() >= slot0.rate / 1000 then
			return false
		end

		if slot0.faithDialog and slot0.behaviour == RoomCharacterEnum.InteractionType.Dialog and slot0.faithDialog > 0 and HeroModel.instance:getByHeroId(slot0.heroId) and HeroConfig.instance:getFaithPercent(slot2.faith)[1] * 1000 < slot0.faithDialog then
			return false
		end

		return true
	end,
	isInDialogInteraction = function ()
		return RoomCharacterController.instance:getPlayingInteractionParam() and slot0.behaviour == RoomCharacterEnum.InteractionType.Dialog
	end,
	interactionIsDialogWithSelect = function (slot0)
		if RoomConfig.instance:getCharacterInteractionConfig(slot0).behaviour ~= RoomCharacterEnum.InteractionType.Dialog then
			return false
		end

		while true do
			if not RoomConfig.instance:getCharacterDialogConfig(slot1.dialogId, 0 + 1) then
				break
			end

			if not string.nilorempty(slot4.selectIds) then
				return true
			end
		end

		return false
	end,
	isCharacterBlock = function (slot0, slot1)
		if not slot1 then
			return false
		end

		for slot8, slot9 in ipairs(slot1) do
			if Vector3.Distance(slot0, CameraMgr.instance:getMainCameraGO().transform.position) < Vector3.Distance(slot9, slot3) then
				return true
			end
		end

		return false
	end,
	getAllBlockMeshRendererList = function ()
		slot0 = GameSceneMgr.instance:getCurScene()
		slot1 = {}

		LuaUtil.insertDict(slot1, slot0.mapmgr:getTagUnitDict(SceneTag.RoomMapBlock))
		LuaUtil.insertDict(slot1, slot0.mapmgr:getTagUnitDict(SceneTag.RoomEmptyBlock))
		LuaUtil.insertDict(slot1, slot0.buildingmgr:getTagUnitDict(SceneTag.RoomBuilding))
		LuaUtil.insertDict(slot1, slot0.buildingmgr:getTagUnitDict(SceneTag.RoomInitBuilding))

		slot5 = slot0.buildingmgr
		slot7 = slot5

		LuaUtil.insertDict(slot1, slot5.getTagUnitDict(slot7, SceneTag.RoomPartBuilding))

		slot2 = {}

		for slot6, slot7 in ipairs(slot1) do
			tabletool.addValues(slot2, slot7:getCharacterMeshRendererList())
		end

		return slot2
	end,
	getAllBlockCharacterGOList = function ()
		slot1 = {}

		for slot6, slot7 in pairs(GameSceneMgr.instance:getCurScene().charactermgr:getRoomCharacterEntityDict()) do
			if slot7.characterspine:getCharacterGO() then
				table.insert(slot1, slot8)
			end
		end

		return slot1
	end,
	isBlockCharacter = function (slot0, slot1, slot2)
		if slot0 and #slot0 > 0 then
			slot3 = slot2.bounds

			if slot3.center.y + slot3.extents.y < 0.2 then
				return false
			end

			slot10 = slot3:GetSize() + Vector3(0, 0.2, 0)

			for slot10 = 1, #slot0 do
				if uv0.testAABB(slot0[slot10], slot1[slot10], Bounds(RoomBendingHelper.worldToBendingSimple(slot5), slot10)) then
					return true
				end
			end
		end

		return false
	end,
	testAABB = function (slot0, slot1, slot2)
		slot3 = slot2:GetMin()
		slot4 = slot2:GetMax()
		slot5 = 0
		slot6 = slot1

		for slot11, slot12 in ipairs(uv0) do
			if math.abs(slot0.direction[slot12]) < 0.01 then
				if slot0.origin[slot12] < slot2.min[slot12] or slot2.max[slot12] < slot0.origin[slot12] then
					return false
				end
			else
				slot13 = 1 / slot0.direction[slot12]

				if (slot3[slot12] - slot0.origin[slot12]) * slot13 > (slot4[slot12] - slot0.origin[slot12]) * slot13 then
					slot15 = slot14
					slot14 = slot15
				end

				if slot5 < slot14 then
					slot5 = slot14
				end

				if slot15 < slot6 then
					slot6 = slot15
				end

				if slot6 < slot5 then
					return false
				end
			end
		end

		return true
	end,
	getBridgePositions = function (slot0)
		slot1 = {}
		slot3 = {}
		slot4 = {}
		slot8 = GameSceneMgr.instance:getCurScene().mapmgr
		slot8 = slot8.getTagUnitDict

		LuaUtil.insertDict(slot4, slot8(slot8, SceneTag.RoomMapBlock))

		for slot8, slot9 in ipairs(slot4) do
			tabletool.addValues(slot3, slot9:getGameObjectListByName("characterPathPoint"))
		end

		for slot8, slot9 in ipairs(slot3) do
			if uv0.checkMoveDistance(slot0, slot9.transform.position) then
				table.insert(slot1, slot10)
			end
		end

		return slot1
	end,
	getCharacterFaithFill = function (slot0)
		if slot0.currentFaith <= 0 then
			return 0
		end

		return slot0.currentMinute / CommonConfig.instance:getConstNum(ConstEnum.RoomCharacterFaithTotalMinute)
	end,
	getCharacterInteractionId = function (slot0)
		for slot4, slot5 in ipairs(lua_room_character_interaction.configList) do
			if slot5.heroId == slot0 and slot5.behaviour == RoomCharacterEnum.InteractionType.Dialog and slot5.relateHeroId == 0 then
				return slot5.id
			end
		end
	end,
	getIdleAnimStateName = function (slot0)
		return RoomCharacterEnum.CharacterIdleAnimReplaceName[slot0] or RoomCharacterEnum.CharacterAnimStateName.Idle
	end,
	getAnimStateName = function (slot0, slot1)
		if slot0 == RoomCharacterEnum.CharacterMoveState.Idle then
			return uv0.getIdleAnimStateName(slot1)
		end

		return RoomCharacterEnum.CharacterAnimState[slot0]
	end,
	getNextAnimStateName = function (slot0, slot1)
		slot2 = nil

		if RoomCharacterEnum.CharacterNextAnimNameDict[slot0] and not slot3[slot1] and RoomCharacterEnum.LoopAnimState[slot1] then
			slot2 = slot1
		end

		return slot2
	end,
	getSpinePointPath = function (slot0)
		if string.nilorempty(slot0) or slot0 == "mountroot" then
			return "mountroot"
		end

		return "mountroot/" .. slot0
	end,
	hasWaterNodeNear = function (slot0, slot1)
		for slot9, slot10 in ipairs(RoomCharacterModel.instance:getEmptyBlockPositions()) do
			if (slot1 + RoomBlockEnum.BlockSize)^2 >= (slot10.x - slot0.x)^2 + (slot10.y - slot0.z)^2 then
				return true
			end
		end

		for slot10, slot11 in ipairs(RoomCharacterModel.instance:getWaterNodePositions()) do
			if slot1^2 >= (slot11.x - slot2)^2 + (slot11.z - slot3)^2 then
				return true
			end
		end

		return false
	end
}
