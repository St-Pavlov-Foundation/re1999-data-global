module("modules.logic.room.utils.RoomBuildingHelper", package.seeall)

return {
	getOccupyDict = function (slot0, slot1, slot2, slot3)
		slot2 = slot2 or 0
		slot4 = {}
		slot6 = RoomMapModel.instance:getBuildingConfigParam(slot0)
		slot7 = slot6.centerPoint
		slot9 = slot6.replaceBlockDic
		slot10 = slot6.crossloadResPointDic
		slot11 = slot6.canPlaceBlockDic
		slot12 = RoomConfig.instance:getBuildingConfig(slot0).crossload ~= 0

		for slot16, slot17 in ipairs(slot6.pointList) do
			slot21 = uv0.getWorldHexPoint(slot17, slot7, slot1 or HexPoint(0, 0), slot2)
			slot4[slot21.x] = slot4[slot21.x] or {}
			slot4[slot21.x][slot21.y] = {
				buildingId = slot0,
				buildingUid = slot3,
				blockDefineId = slot9[slot17.x] and slot9[slot17.x][slot17.y],
				isCenter = slot17 == slot7,
				rotate = slot2,
				blockRotate = slot2,
				isCrossload = slot12,
				hexPoint = slot21,
				index = slot16,
				isCanPlace = slot11[slot17.x] and slot11[slot17.x][slot17.y] or false
			}

			if slot12 then
				slot23.replacResPoins = slot10[slot17.x] and slot10[slot17.x][slot17.y]
			end
		end

		return slot4
	end,
	getTopRightHexPoint = function (slot0, slot1, slot2)
		slot4 = {}

		for slot8, slot9 in pairs(uv0.getOccupyDict(slot0, slot1, slot2)) do
			for slot13, slot14 in pairs(slot9) do
				slot15 = HexPoint(slot8, slot13)
				slot16 = slot15:convertToOffsetCoordinates()

				table.insert(slot4, {
					col = slot16.x,
					row = slot16.y,
					hexPoint = slot15
				})
			end
		end

		table.sort(slot4, function (slot0, slot1)
			if slot0.row ~= slot1.row then
				return slot0.row < slot1.row
			end

			return slot1.col < slot0.col
		end)

		return slot4[1] and slot4[1].hexPoint
	end,
	getWorldHexPoint = function (slot0, slot1, slot2, slot3)
		return (slot0 - slot1):Rotate(HexPoint(0, 0), slot3, true) + slot2
	end,
	getWorldResourcePoint = function (slot0, slot1, slot2, slot3)
		return ResourcePoint(uv0.getWorldHexPoint(slot0.hexPoint, slot1, slot2, slot3), RoomRotateHelper.rotateDirection(slot0.direction, slot3))
	end,
	getAllOccupyDict = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(slot0 or RoomMapBuildingModel.instance:getBuildingMOList()) do
			if slot6.buildingState == RoomBuildingEnum.BuildingState.Map then
				slot11 = slot6.id

				for slot11, slot12 in pairs(uv0.getOccupyDict(slot6.config.id, slot6.hexPoint, slot6.rotate, slot11)) do
					for slot16, slot17 in pairs(slot12) do
						slot1[slot11] = slot1[slot11] or {}
						slot1[slot11][slot16] = slot17
					end
				end
			end
		end

		return slot1
	end,
	isAlreadyOccupy = function (slot0, slot1, slot2, slot3, slot4)
		slot3 = slot3 or RoomMapBuildingModel.instance:getAllOccupyDict()
		slot5 = {}

		if slot4 and RoomMapBuildingModel.instance:getTempBuildingMO() and slot6.buildingState == RoomBuildingEnum.BuildingState.Revert then
			slot5 = uv0.getOccupyDict(slot6.buildingId, RoomMapBuildingModel.instance:getRevertHexPoint(), RoomMapBuildingModel.instance:getRevertRotate(), slot6.id)
		end

		for slot10, slot11 in pairs(uv0.getOccupyDict(slot0, slot1, slot2)) do
			for slot15, slot16 in pairs(slot11) do
				if uv0.isInInitBlock(HexPoint(slot10, slot15)) then
					return true
				end

				if slot3[slot10] and slot3[slot10][slot15] then
					return true
				end

				if slot5[slot10] and slot5[slot10][slot15] then
					return true
				end
			end
		end

		return false
	end,
	hasNoFoundation = function (slot0, slot1, slot2, slot3, slot4)
		for slot9, slot10 in pairs(uv0.getOccupyDict(slot0, slot1, slot2)) do
			for slot14, slot15 in pairs(slot10) do
				if not slot3[slot9] or not slot3[slot9][slot14] or slot16.blockState ~= RoomBlockEnum.BlockState.Map and (not slot4 or slot16.blockState ~= RoomBlockEnum.BlockState.Water) then
					return true
				end
			end
		end

		return false
	end,
	checkResource = function (slot0, slot1, slot2)
		for slot7, slot8 in pairs(uv0.getOccupyDict(slot0, slot1, slot2)) do
			for slot12, slot13 in pairs(slot8) do
				if RoomMapBlockModel.instance:getBlockMO(slot7, slot12) and not uv0.checkBuildResId(slot0, slot14:getResourceList(true)) then
					return false
				end
			end
		end

		return true
	end,
	hasEnoughResource = function (slot0, slot1, slot2, slot3, slot4)
		if uv0.getConfirmPlaceBuildingErrorCode(slot0, slot1, slot2, slot3) then
			return nil, slot5
		end

		return {
			direction = 0
		}
	end,
	getConfirmPlaceBuildingErrorCode = function (slot0, slot1, slot2, slot3)
		slot5 = RoomMapBlockModel.instance:getBlockMODict()
		slot6 = nil

		for slot10, slot11 in pairs(uv0.getOccupyDict(slot0, slot1, slot2)) do
			for slot15, slot16 in pairs(slot11) do
				if not slot5[slot10] or not slot5[slot10][slot15] or not uv0.checkBuildResId(slot0, slot17:getResourceList(true)) then
					return RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.ResourceId
				end
			end
		end

		return nil
	end,
	getCostResourceId = function (slot0)
		if not RoomMapModel.instance:getBuildingConfigParam(slot0).costResource or #slot1.costResource < 1 then
			return RoomResourceEnum.ResourceId.None
		end

		return slot1.costResource[1]
	end,
	getCostResource = function (slot0)
		return RoomMapModel.instance:getBuildingConfigParam(slot0).costResource
	end,
	checkBuildResId = function (slot0, slot1)
		slot3 = RoomMapModel.instance:getBuildingConfigParam(slot0).costResource
		slot4 = RoomConfig.instance

		for slot8, slot9 in ipairs(slot1 or {}) do
			if slot4:getResourceConfig(slot9) and slot10.occupied == 1 and (not slot4:getResourceParam(slot9) or not slot11.placeBuilding or not tabletool.indexOf(slot11.placeBuilding, slot0)) then
				return false
			end
		end

		if slot3 and #slot3 > 0 then
			for slot8, slot9 in ipairs(slot1) do
				if tabletool.indexOf(slot3, slot9) then
					return true
				end
			end

			return false
		end

		return true
	end,
	checkCostResource = function (slot0, slot1)
		if slot0 and #slot0 > 0 and not tabletool.indexOf(slot0, slot1) then
			return false
		end

		return true
	end,
	getCanConfirmPlaceDict = function (slot0, slot1, slot2, slot3, slot4)
		slot2 = slot2 or RoomMapBuildingModel.instance:getAllOccupyDict()
		slot5 = {}

		for slot9, slot10 in pairs(slot1 or RoomMapBlockModel.instance:getBlockMODict()) do
			for slot14, slot15 in pairs(slot10) do
				if not uv0.isInInitBlock(slot15.hexPoint) then
					for slot19 = 1, 6 do
						if uv0.canConfirmPlace(slot0, slot15.hexPoint, slot19, slot1, slot2, slot3, slot4) then
							slot5[slot9] = slot5[slot9] or {}
							slot5[slot9][slot14] = slot5[slot9][slot14] or {}
							slot5[slot9][slot14][slot19] = slot20
						end
					end
				end
			end
		end

		return slot5
	end,
	canTryPlace = function (slot0, slot1, slot2, slot3, slot4, slot5)
		slot3 = slot3 or RoomMapBlockModel.instance:getBlockMODict()

		if uv0.isAlreadyOccupy(slot0, slot1, slot2, slot4 or RoomMapBuildingModel.instance:getAllOccupyDict(), slot5) then
			return false
		end

		if uv0.hasNoFoundation(slot0, slot1, slot2, slot3) then
			return false
		end

		return true
	end,
	canConfirmPlace = function (slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
		slot3 = slot3 or RoomMapBlockModel.instance:getBlockMODict()
		slot4 = slot4 or RoomMapBuildingModel.instance:getAllOccupyDict()
		slot8, slot9 = RoomBuildingAreaHelper.checkBuildingArea(slot0, slot1, slot2)

		if slot8 ~= true then
			return nil, slot9
		end

		if uv0.isAlreadyOccupy(slot0, slot1, slot2, slot4, slot5) then
			return nil
		end

		if uv0.hasNoFoundation(slot0, slot1, slot2, slot3) then
			return nil, RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.Foundation
		end

		if not uv0.checkResource(slot0, slot1, slot2, slot3) then
			return nil, RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.ResourceId
		end

		if RoomTransportHelper.checkBuildingInLoad(slot0, slot1, slot2) then
			return nil, RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.InTransportPath
		end

		return uv0.hasEnoughResource(slot0, slot1, slot2, slot6, slot7)
	end,
	getRecommendHexPoint = function (slot0, slot1, slot2, slot3, slot4)
		slot4 = slot4 or 0
		slot7 = GameSceneMgr.instance:getCurScene().camera:getCameraParam()
		slot8 = Vector2(slot7.focusX, slot7.focusY)
		slot9 = nil
		slot10 = 0

		for slot14, slot15 in pairs(uv0.getCanConfirmPlaceDict(slot0, slot1 or RoomMapBlockModel.instance:getBlockMODict(), slot2 or RoomMapBuildingModel.instance:getAllOccupyDict(), true, slot3)) do
			for slot19, slot20 in pairs(slot15) do
				slot10 = slot10 + 1

				for slot24, slot25 in pairs(slot20) do
					slot25.hexPoint = HexPoint(slot14, slot19)
					slot25.rotate = slot24
					slot25.rotateDistance = math.abs(RoomRotateHelper.getMod(slot24, 6) - RoomRotateHelper.getMod(slot4, 6))
					slot25.distance = Vector2.Distance(HexMath.hexToPosition(slot25.hexPoint, RoomBlockEnum.BlockSize), slot8)
					slot9 = not slot9 and slot25 or uv0._compareParams(slot25, slot25)
				end
			end
		end

		return slot9
	end,
	_compareParams = function (slot0, slot1)
		if slot0.rotateDistance < slot1.rotateDistance then
			return slot0
		elseif slot1.rotateDistance < slot0.rotateDistance then
			return slot1
		end

		if slot0.distance < slot1.distance then
			return slot0
		elseif slot1.distance < slot0.distance then
			return slot1
		end

		return slot0
	end,
	canLevelUp = function (slot0, slot1, slot2)
		slot3 = RoomMapBuildingModel.instance:getBuildingMOById(slot0)
		slot5 = RoomMapModel.instance:getBuildingConfigParam(slot3.buildingId).levelGroups
		slot6 = tabletool.copy(slot3.levels)
		slot8, slot9 = ItemModel.instance:hasEnoughItems(uv0.getLevelUpCostItems(slot0, slot1))

		if not slot9 then
			slot10 = {}

			for slot14, slot15 in ipairs(slot7) do
				if slot15.type == MaterialEnum.MaterialType.Item and slot15.id == RoomBuildingEnum.SpecialStrengthItemId then
					table.insert(slot10, tabletool.copy(slot15))
				end
			end

			slot11, slot12 = ItemModel.instance:hasEnoughItems(slot10)

			if not slot12 then
				return false, -3
			else
				return false, -1
			end
		end

		return true
	end,
	getLevelUpCostItems = function (slot0, slot1)
		slot2 = RoomMapBuildingModel.instance:getBuildingMOById(slot0)
		slot4 = RoomMapModel.instance:getBuildingConfigParam(slot2.buildingId).levelGroups
		slot6 = {}

		for slot10, slot11 in ipairs(slot1) do
			slot12 = tabletool.copy(slot2.levels)[slot10] or 0

			for slot19 = math.min(slot12, slot11) + 1, math.max(slot12, slot11) do
				slot20 = uv0.getLevelUpCost(slot4[slot10], slot19)
				slot20.quantity = (slot12 < slot11 and 1 or -1) * slot20.quantity

				table.insert(slot6, slot20)
			end
		end

		return slot6
	end,
	getLevelUpCost = function (slot0, slot1)
		slot4 = string.splitToNumber(RoomConfig.instance:getLevelGroupConfig(slot0, slot1).cost, "#")

		return {
			type = slot4[1],
			id = slot4[2],
			quantity = slot4[3]
		}
	end,
	getOccupyBuildingParam = function (slot0, slot1)
		slot2 = RoomMapBuildingModel.instance:getAllOccupyDict()
		slot4 = nil

		if RoomMapBuildingModel.instance:getTempBuildingMO() and slot1 then
			slot4 = uv0.getOccupyDict(slot3.buildingId, slot3.hexPoint, slot3.rotate, slot3.id)
		end

		if not (slot2[slot0.x] and slot2[slot0.x][slot0.y]) and slot4 then
			slot5 = slot4[slot0.x] and slot4[slot0.x][slot0.y]
		end

		return slot5
	end,
	isJudge = function (slot0, slot1)
		if not RoomMapBuildingModel.instance:getTempBuildingMO() then
			return false
		end

		slot3 = slot2.hexPoint

		if RoomBuildingController.instance:isPressBuilding() and slot4 == slot2.id then
			slot3 = RoomBuildingController.instance:getPressBuildingHexPoint()
		end

		if not slot3 then
			return false
		end

		if uv0.isInInitBlock(slot0) then
			return false
		end

		if RoomMapBuildingModel.instance:getBuildingParam(slot0.x, slot0.y) and slot5.buildingUid ~= slot2.id then
			return false
		end

		if not RoomMapBlockModel.instance:getFullBlockMOById(slot1) then
			return false
		end

		if not uv0.checkBuildResId(slot2.buildingId, slot6:getResourceList(true)) then
			return false
		end

		if RoomTransportHelper.checkInLoadHexXY(slot0.x, slot0.y) then
			return false
		end

		return true
	end,
	getNearCanPlaceHexPoint = function (slot0, slot1, slot2, slot3)
		slot2 = slot2 or RoomMapBlockModel.instance:getBlockMODict()
		slot3 = slot3 or RoomMapBuildingModel.instance:getAllOccupyDict()
		slot4 = RoomMapBuildingModel.instance:getBuildingMOById(slot0)

		for slot8 = 0, 3 do
			if slot8 == 0 then
				table.insert({}, slot1)
			else
				slot9 = slot1:getOnRanges(slot8)
			end

			for slot13 = 0, 5 do
				for slot17, slot18 in ipairs(slot9) do
					if uv0.canTryPlace(slot4.buildingId, slot18, RoomRotateHelper.rotateRotate(slot4.rotate, slot13)) then
						return slot18, slot19
					end
				end
			end
		end

		return nil
	end,
	isInInitBuildingOccupy = function (slot0)
		return RoomConfig.instance:getInitBuildingOccupyDict()[slot0.x] and slot1[slot0.x][slot0.y]
	end,
	isInInitBlock = function (slot0)
		return RoomConfig.instance:getInitBlockByXY(slot0.x, slot0.y) and true or false
	end,
	canContain = function (slot0, slot1)
		for slot5, slot6 in pairs(slot0) do
			for slot10, slot11 in pairs(slot6) do
				for slot15 = 1, 6 do
					slot16 = true
					slot21 = slot10

					for slot21, slot22 in pairs(uv0.getOccupyDict(slot1, HexPoint(slot5, slot21), slot15)) do
						for slot26, slot27 in pairs(slot22) do
							if not slot0[slot21] or not slot0[slot21][slot26] then
								slot16 = false

								break
							end
						end

						if not slot16 then
							break
						end
					end

					if slot16 then
						return true
					end
				end
			end
		end

		return false
	end,
	findNearBlockHexPoint = function (slot0, slot1)
		if RoomMapBlockModel.instance:getBlockMO(slot0.x, slot0.y) and slot3:isInMapBlock() and uv0._checkBlockByHexPoint(slot0, slot1) then
			return slot0
		end

		slot3 = uv0._findNearBlockMO(slot2:getFullBlockMOList(), slot0) or uv0._findNearBlockMO(slot2:getEmptyBlockMOList(), slot0)

		return slot3 and slot3.hexPoint or slot0
	end,
	_findNearBlockMO = function (slot0, slot1, slot2)
		for slot8 = 1, #slot0 do
			if slot0[slot8]:isInMap() and uv0._checkBlockByHexPoint(slot9.hexPoint, slot2) then
				slot10 = slot1:getDistance(slot9.hexPoint)

				if not nil or slot10 < 1000 then
					slot3 = slot9
					slot4 = slot10
				end
			end
		end

		return slot3
	end,
	_checkBlockByHexPoint = function (slot0, slot1)
		if RoomMapBuildingModel.instance:getBuildingParam(slot0.x, slot0.y) and slot2.buildingUid ~= slot1 or uv0.isInInitBlock(slot0) then
			return false
		end

		return true
	end,
	getCenterPosition = function (slot0)
		return gohelper.findChild(slot0, "container/buildingGO/center") and slot1.transform.position or slot0.transform.position
	end
}
