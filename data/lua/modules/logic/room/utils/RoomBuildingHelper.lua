module("modules.logic.room.utils.RoomBuildingHelper", package.seeall)

local var_0_0 = {}

function var_0_0.getOccupyDict(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_1 = arg_1_1 or HexPoint(0, 0)
	arg_1_2 = arg_1_2 or 0

	local var_1_0 = {}
	local var_1_1 = RoomConfig.instance:getBuildingConfig(arg_1_0)
	local var_1_2 = RoomMapModel.instance:getBuildingConfigParam(arg_1_0)
	local var_1_3 = var_1_2.centerPoint
	local var_1_4 = var_1_2.pointList
	local var_1_5 = var_1_2.replaceBlockDic
	local var_1_6 = var_1_2.crossloadResPointDic
	local var_1_7 = var_1_2.canPlaceBlockDic
	local var_1_8 = var_1_1.crossload ~= 0

	for iter_1_0, iter_1_1 in ipairs(var_1_4) do
		local var_1_9 = iter_1_1 == var_1_3
		local var_1_10 = var_1_5[iter_1_1.x] and var_1_5[iter_1_1.x][iter_1_1.y]
		local var_1_11 = var_1_7[iter_1_1.x] and var_1_7[iter_1_1.x][iter_1_1.y] or false
		local var_1_12 = var_0_0.getWorldHexPoint(iter_1_1, var_1_3, arg_1_1, arg_1_2)

		var_1_0[var_1_12.x] = var_1_0[var_1_12.x] or {}

		local var_1_13 = arg_1_2
		local var_1_14 = {
			buildingId = arg_1_0,
			buildingUid = arg_1_3,
			blockDefineId = var_1_10,
			isCenter = var_1_9,
			rotate = arg_1_2,
			blockRotate = var_1_13,
			isCrossload = var_1_8,
			hexPoint = var_1_12,
			index = iter_1_0,
			isCanPlace = var_1_11
		}

		var_1_0[var_1_12.x][var_1_12.y] = var_1_14

		if var_1_8 then
			var_1_14.replacResPoins = var_1_6[iter_1_1.x] and var_1_6[iter_1_1.x][iter_1_1.y]
		end
	end

	return var_1_0
end

function var_0_0.getTopRightHexPoint(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0_0.getOccupyDict(arg_2_0, arg_2_1, arg_2_2)
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		for iter_2_2, iter_2_3 in pairs(iter_2_1) do
			local var_2_2 = HexPoint(iter_2_0, iter_2_2)
			local var_2_3 = var_2_2:convertToOffsetCoordinates()

			table.insert(var_2_1, {
				col = var_2_3.x,
				row = var_2_3.y,
				hexPoint = var_2_2
			})
		end
	end

	table.sort(var_2_1, function(arg_3_0, arg_3_1)
		if arg_3_0.row ~= arg_3_1.row then
			return arg_3_0.row < arg_3_1.row
		end

		return arg_3_0.col > arg_3_1.col
	end)

	return var_2_1[1] and var_2_1[1].hexPoint
end

function var_0_0.getWorldHexPoint(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	return (arg_4_0 - arg_4_1):Rotate(HexPoint(0, 0), arg_4_3, true) + arg_4_2
end

function var_0_0.getWorldResourcePoint(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0.hexPoint
	local var_5_1 = arg_5_0.direction
	local var_5_2 = var_0_0.getWorldHexPoint(var_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_3 = RoomRotateHelper.rotateDirection(var_5_1, arg_5_3)

	return ResourcePoint(var_5_2, var_5_3)
end

function var_0_0.getAllOccupyDict(arg_6_0)
	arg_6_0 = arg_6_0 or RoomMapBuildingModel.instance:getBuildingMOList()

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
		if iter_6_1.buildingState == RoomBuildingEnum.BuildingState.Map then
			local var_6_1 = var_0_0.getOccupyDict(iter_6_1.config.id, iter_6_1.hexPoint, iter_6_1.rotate, iter_6_1.id)

			for iter_6_2, iter_6_3 in pairs(var_6_1) do
				for iter_6_4, iter_6_5 in pairs(iter_6_3) do
					var_6_0[iter_6_2] = var_6_0[iter_6_2] or {}
					var_6_0[iter_6_2][iter_6_4] = iter_6_5
				end
			end
		end
	end

	return var_6_0
end

function var_0_0.isAlreadyOccupy(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_3 = arg_7_3 or RoomMapBuildingModel.instance:getAllOccupyDict()

	local var_7_0 = {}

	if arg_7_4 then
		local var_7_1 = RoomMapBuildingModel.instance:getTempBuildingMO()

		if var_7_1 and var_7_1.buildingState == RoomBuildingEnum.BuildingState.Revert then
			local var_7_2 = RoomMapBuildingModel.instance:getRevertHexPoint()
			local var_7_3 = RoomMapBuildingModel.instance:getRevertRotate()

			var_7_0 = var_0_0.getOccupyDict(var_7_1.buildingId, var_7_2, var_7_3, var_7_1.id)
		end
	end

	local var_7_4 = var_0_0.getOccupyDict(arg_7_0, arg_7_1, arg_7_2)

	for iter_7_0, iter_7_1 in pairs(var_7_4) do
		for iter_7_2, iter_7_3 in pairs(iter_7_1) do
			if var_0_0.isInInitBlock(HexPoint(iter_7_0, iter_7_2)) then
				return true
			end

			if arg_7_3[iter_7_0] and arg_7_3[iter_7_0][iter_7_2] then
				return true
			end

			if var_7_0[iter_7_0] and var_7_0[iter_7_0][iter_7_2] then
				return true
			end
		end
	end

	return false
end

function var_0_0.hasNoFoundation(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = var_0_0.getOccupyDict(arg_8_0, arg_8_1, arg_8_2)

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		for iter_8_2, iter_8_3 in pairs(iter_8_1) do
			local var_8_1 = arg_8_3[iter_8_0] and arg_8_3[iter_8_0][iter_8_2]

			if not var_8_1 or var_8_1.blockState ~= RoomBlockEnum.BlockState.Map and (not arg_8_4 or var_8_1.blockState ~= RoomBlockEnum.BlockState.Water) then
				return true
			end
		end
	end

	return false
end

function var_0_0.checkResource(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = var_0_0.getOccupyDict(arg_9_0, arg_9_1, arg_9_2)

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		for iter_9_2, iter_9_3 in pairs(iter_9_1) do
			local var_9_1 = RoomMapBlockModel.instance:getBlockMO(iter_9_0, iter_9_2)

			if var_9_1 and not var_0_0.checkBuildResId(arg_9_0, var_9_1:getResourceList(true)) then
				return false
			end
		end
	end

	return true
end

function var_0_0.hasEnoughResource(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = var_0_0.getConfirmPlaceBuildingErrorCode(arg_10_0, arg_10_1, arg_10_2, arg_10_3)

	if var_10_0 then
		return nil, var_10_0
	end

	return {
		direction = 0
	}
end

function var_0_0.getConfirmPlaceBuildingErrorCode(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = var_0_0.getOccupyDict(arg_11_0, arg_11_1, arg_11_2)
	local var_11_1 = RoomMapBlockModel.instance:getBlockMODict()
	local var_11_2

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		for iter_11_2, iter_11_3 in pairs(iter_11_1) do
			local var_11_3 = var_11_1[iter_11_0] and var_11_1[iter_11_0][iter_11_2]

			if not var_11_3 or not var_0_0.checkBuildResId(arg_11_0, var_11_3:getResourceList(true)) then
				return RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.ResourceId
			end
		end
	end

	return nil
end

function var_0_0.getCostResourceId(arg_12_0)
	local var_12_0 = RoomMapModel.instance:getBuildingConfigParam(arg_12_0)

	if not var_12_0.costResource or #var_12_0.costResource < 1 then
		return RoomResourceEnum.ResourceId.None
	end

	return var_12_0.costResource[1]
end

function var_0_0.getCostResource(arg_13_0)
	return RoomMapModel.instance:getBuildingConfigParam(arg_13_0).costResource
end

function var_0_0.checkBuildResId(arg_14_0, arg_14_1)
	local var_14_0 = RoomMapModel.instance:getBuildingConfigParam(arg_14_0).costResource

	arg_14_1 = arg_14_1 or {}

	local var_14_1 = RoomConfig.instance

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		local var_14_2 = var_14_1:getResourceConfig(iter_14_1)

		if var_14_2 and var_14_2.occupied == 1 then
			local var_14_3 = var_14_1:getResourceParam(iter_14_1)

			if not var_14_3 or not var_14_3.placeBuilding or not tabletool.indexOf(var_14_3.placeBuilding, arg_14_0) then
				return false
			end
		end
	end

	if var_14_0 and #var_14_0 > 0 then
		for iter_14_2, iter_14_3 in ipairs(arg_14_1) do
			if tabletool.indexOf(var_14_0, iter_14_3) then
				return true
			end
		end

		return false
	end

	return true
end

function var_0_0.checkCostResource(arg_15_0, arg_15_1)
	if arg_15_0 and #arg_15_0 > 0 and not tabletool.indexOf(arg_15_0, arg_15_1) then
		return false
	end

	return true
end

function var_0_0.getCanConfirmPlaceDict(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	arg_16_1 = arg_16_1 or RoomMapBlockModel.instance:getBlockMODict()
	arg_16_2 = arg_16_2 or RoomMapBuildingModel.instance:getAllOccupyDict()

	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_1) do
		for iter_16_2, iter_16_3 in pairs(iter_16_1) do
			if not var_0_0.isInInitBlock(iter_16_3.hexPoint) then
				for iter_16_4 = 1, 6 do
					local var_16_1 = var_0_0.canConfirmPlace(arg_16_0, iter_16_3.hexPoint, iter_16_4, arg_16_1, arg_16_2, arg_16_3, arg_16_4)

					if var_16_1 then
						var_16_0[iter_16_0] = var_16_0[iter_16_0] or {}
						var_16_0[iter_16_0][iter_16_2] = var_16_0[iter_16_0][iter_16_2] or {}
						var_16_0[iter_16_0][iter_16_2][iter_16_4] = var_16_1
					end
				end
			end
		end
	end

	return var_16_0
end

function var_0_0.canTryPlace(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	arg_17_3 = arg_17_3 or RoomMapBlockModel.instance:getBlockMODict()
	arg_17_4 = arg_17_4 or RoomMapBuildingModel.instance:getAllOccupyDict()

	if var_0_0.isAlreadyOccupy(arg_17_0, arg_17_1, arg_17_2, arg_17_4, arg_17_5) then
		return false
	end

	if var_0_0.hasNoFoundation(arg_17_0, arg_17_1, arg_17_2, arg_17_3) then
		return false
	end

	return true
end

function var_0_0.canConfirmPlace(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6, arg_18_7)
	arg_18_3 = arg_18_3 or RoomMapBlockModel.instance:getBlockMODict()
	arg_18_4 = arg_18_4 or RoomMapBuildingModel.instance:getAllOccupyDict()

	local var_18_0, var_18_1 = RoomBuildingAreaHelper.checkBuildingArea(arg_18_0, arg_18_1, arg_18_2)

	if var_18_0 ~= true then
		return nil, var_18_1
	end

	if var_0_0.isAlreadyOccupy(arg_18_0, arg_18_1, arg_18_2, arg_18_4, arg_18_5) then
		return nil
	end

	if var_0_0.hasNoFoundation(arg_18_0, arg_18_1, arg_18_2, arg_18_3) then
		return nil, RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.Foundation
	end

	if not var_0_0.checkResource(arg_18_0, arg_18_1, arg_18_2, arg_18_3) then
		return nil, RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.ResourceId
	end

	if RoomTransportHelper.checkBuildingInLoad(arg_18_0, arg_18_1, arg_18_2) then
		return nil, RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.InTransportPath
	end

	return var_0_0.hasEnoughResource(arg_18_0, arg_18_1, arg_18_2, arg_18_6, arg_18_7)
end

function var_0_0.getRecommendHexPoint(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	arg_19_4 = arg_19_4 or 0
	arg_19_1 = arg_19_1 or RoomMapBlockModel.instance:getBlockMODict()
	arg_19_2 = arg_19_2 or RoomMapBuildingModel.instance:getAllOccupyDict()

	local var_19_0 = var_0_0.getCanConfirmPlaceDict(arg_19_0, arg_19_1, arg_19_2, true, arg_19_3)
	local var_19_1 = GameSceneMgr.instance:getCurScene().camera:getCameraParam()
	local var_19_2 = Vector2(var_19_1.focusX, var_19_1.focusY)
	local var_19_3
	local var_19_4 = 0

	for iter_19_0, iter_19_1 in pairs(var_19_0) do
		for iter_19_2, iter_19_3 in pairs(iter_19_1) do
			var_19_4 = var_19_4 + 1

			for iter_19_4, iter_19_5 in pairs(iter_19_3) do
				iter_19_5.hexPoint = HexPoint(iter_19_0, iter_19_2)
				iter_19_5.rotate = iter_19_4
				iter_19_5.rotateDistance = math.abs(RoomRotateHelper.getMod(iter_19_4, 6) - RoomRotateHelper.getMod(arg_19_4, 6))
				iter_19_5.distance = Vector2.Distance(HexMath.hexToPosition(iter_19_5.hexPoint, RoomBlockEnum.BlockSize), var_19_2)

				if not var_19_3 then
					var_19_3 = iter_19_5
				else
					var_19_3 = var_0_0._compareParams(var_19_3, iter_19_5)
				end
			end
		end
	end

	return var_19_3
end

function var_0_0._compareParams(arg_20_0, arg_20_1)
	if arg_20_0.rotateDistance < arg_20_1.rotateDistance then
		return arg_20_0
	elseif arg_20_0.rotateDistance > arg_20_1.rotateDistance then
		return arg_20_1
	end

	if arg_20_0.distance < arg_20_1.distance then
		return arg_20_0
	elseif arg_20_0.distance > arg_20_1.distance then
		return arg_20_1
	end

	return arg_20_0
end

function var_0_0.canLevelUp(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_21_0)
	local var_21_1 = RoomMapModel.instance:getBuildingConfigParam(var_21_0.buildingId).levelGroups
	local var_21_2 = tabletool.copy(var_21_0.levels)
	local var_21_3 = var_0_0.getLevelUpCostItems(arg_21_0, arg_21_1)
	local var_21_4, var_21_5 = ItemModel.instance:hasEnoughItems(var_21_3)

	if not var_21_5 then
		local var_21_6 = {}

		for iter_21_0, iter_21_1 in ipairs(var_21_3) do
			if iter_21_1.type == MaterialEnum.MaterialType.Item and iter_21_1.id == RoomBuildingEnum.SpecialStrengthItemId then
				table.insert(var_21_6, tabletool.copy(iter_21_1))
			end
		end

		local var_21_7, var_21_8 = ItemModel.instance:hasEnoughItems(var_21_6)

		if not var_21_8 then
			return false, -3
		else
			return false, -1
		end
	end

	return true
end

function var_0_0.getLevelUpCostItems(arg_22_0, arg_22_1)
	local var_22_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_22_0)
	local var_22_1 = RoomMapModel.instance:getBuildingConfigParam(var_22_0.buildingId).levelGroups
	local var_22_2 = tabletool.copy(var_22_0.levels)
	local var_22_3 = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		local var_22_4 = var_22_2[iter_22_0] or 0
		local var_22_5 = math.min(var_22_4, iter_22_1)
		local var_22_6 = math.max(var_22_4, iter_22_1)
		local var_22_7 = var_22_4 < iter_22_1 and 1 or -1

		for iter_22_2 = var_22_5 + 1, var_22_6 do
			local var_22_8 = var_0_0.getLevelUpCost(var_22_1[iter_22_0], iter_22_2)

			var_22_8.quantity = var_22_7 * var_22_8.quantity

			table.insert(var_22_3, var_22_8)
		end
	end

	return var_22_3
end

function var_0_0.getLevelUpCost(arg_23_0, arg_23_1)
	local var_23_0 = RoomConfig.instance:getLevelGroupConfig(arg_23_0, arg_23_1).cost
	local var_23_1 = string.splitToNumber(var_23_0, "#")

	return {
		type = var_23_1[1],
		id = var_23_1[2],
		quantity = var_23_1[3]
	}
end

function var_0_0.getOccupyBuildingParam(arg_24_0, arg_24_1)
	local var_24_0 = RoomMapBuildingModel.instance:getAllOccupyDict()
	local var_24_1 = RoomMapBuildingModel.instance:getTempBuildingMO()
	local var_24_2

	if var_24_1 and arg_24_1 then
		var_24_2 = var_0_0.getOccupyDict(var_24_1.buildingId, var_24_1.hexPoint, var_24_1.rotate, var_24_1.id)
	end

	local var_24_3 = var_24_0[arg_24_0.x] and var_24_0[arg_24_0.x][arg_24_0.y]

	if not var_24_3 and var_24_2 then
		var_24_3 = var_24_2[arg_24_0.x] and var_24_2[arg_24_0.x][arg_24_0.y]
	end

	return var_24_3
end

function var_0_0.isJudge(arg_25_0, arg_25_1)
	local var_25_0 = RoomMapBuildingModel.instance:getTempBuildingMO()

	if not var_25_0 then
		return false
	end

	local var_25_1 = var_25_0.hexPoint
	local var_25_2 = RoomBuildingController.instance:isPressBuilding()

	if var_25_2 and var_25_2 == var_25_0.id then
		var_25_1 = RoomBuildingController.instance:getPressBuildingHexPoint()
	end

	if not var_25_1 then
		return false
	end

	if var_0_0.isInInitBlock(arg_25_0) then
		return false
	end

	local var_25_3 = RoomMapBuildingModel.instance:getBuildingParam(arg_25_0.x, arg_25_0.y)

	if var_25_3 and var_25_3.buildingUid ~= var_25_0.id then
		return false
	end

	local var_25_4 = RoomMapBlockModel.instance:getFullBlockMOById(arg_25_1)

	if not var_25_4 then
		return false
	end

	if not var_0_0.checkBuildResId(var_25_0.buildingId, var_25_4:getResourceList(true)) then
		return false
	end

	if RoomTransportHelper.checkInLoadHexXY(arg_25_0.x, arg_25_0.y) then
		return false
	end

	return true
end

function var_0_0.getNearCanPlaceHexPoint(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	arg_26_2 = arg_26_2 or RoomMapBlockModel.instance:getBlockMODict()
	arg_26_3 = arg_26_3 or RoomMapBuildingModel.instance:getAllOccupyDict()

	local var_26_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_26_0)

	for iter_26_0 = 0, 3 do
		local var_26_1 = {}

		if iter_26_0 == 0 then
			table.insert(var_26_1, arg_26_1)
		else
			var_26_1 = arg_26_1:getOnRanges(iter_26_0)
		end

		for iter_26_1 = 0, 5 do
			for iter_26_2, iter_26_3 in ipairs(var_26_1) do
				local var_26_2 = RoomRotateHelper.rotateRotate(var_26_0.rotate, iter_26_1)

				if var_0_0.canTryPlace(var_26_0.buildingId, iter_26_3, var_26_2) then
					return iter_26_3, var_26_2
				end
			end
		end
	end

	return nil
end

function var_0_0.isInInitBuildingOccupy(arg_27_0)
	local var_27_0 = RoomConfig.instance:getInitBuildingOccupyDict()

	return var_27_0[arg_27_0.x] and var_27_0[arg_27_0.x][arg_27_0.y]
end

function var_0_0.isInInitBlock(arg_28_0)
	return RoomConfig.instance:getInitBlockByXY(arg_28_0.x, arg_28_0.y) and true or false
end

function var_0_0.canContain(arg_29_0, arg_29_1)
	for iter_29_0, iter_29_1 in pairs(arg_29_0) do
		for iter_29_2, iter_29_3 in pairs(iter_29_1) do
			for iter_29_4 = 1, 6 do
				local var_29_0 = true
				local var_29_1 = var_0_0.getOccupyDict(arg_29_1, HexPoint(iter_29_0, iter_29_2), iter_29_4)

				for iter_29_5, iter_29_6 in pairs(var_29_1) do
					for iter_29_7, iter_29_8 in pairs(iter_29_6) do
						if not arg_29_0[iter_29_5] or not arg_29_0[iter_29_5][iter_29_7] then
							var_29_0 = false

							break
						end
					end

					if not var_29_0 then
						break
					end
				end

				if var_29_0 then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.findNearBlockHexPoint(arg_30_0, arg_30_1)
	local var_30_0 = RoomMapBlockModel.instance
	local var_30_1 = var_30_0:getBlockMO(arg_30_0.x, arg_30_0.y)

	if var_30_1 and var_30_1:isInMapBlock() and var_0_0._checkBlockByHexPoint(arg_30_0, arg_30_1) then
		return arg_30_0
	end

	local var_30_2 = var_0_0._findNearBlockMO(var_30_0:getFullBlockMOList(), arg_30_0) or var_0_0._findNearBlockMO(var_30_0:getEmptyBlockMOList(), arg_30_0)

	return var_30_2 and var_30_2.hexPoint or arg_30_0
end

function var_0_0._findNearBlockMO(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0
	local var_31_1 = 1000

	for iter_31_0 = 1, #arg_31_0 do
		local var_31_2 = arg_31_0[iter_31_0]

		if var_31_2:isInMap() and var_0_0._checkBlockByHexPoint(var_31_2.hexPoint, arg_31_2) then
			local var_31_3 = arg_31_1:getDistance(var_31_2.hexPoint)

			if not var_31_0 or var_31_3 < var_31_1 then
				var_31_0 = var_31_2
				var_31_1 = var_31_3
			end
		end
	end

	return var_31_0
end

function var_0_0._checkBlockByHexPoint(arg_32_0, arg_32_1)
	local var_32_0 = RoomMapBuildingModel.instance:getBuildingParam(arg_32_0.x, arg_32_0.y)

	if var_32_0 and var_32_0.buildingUid ~= arg_32_1 or var_0_0.isInInitBlock(arg_32_0) then
		return false
	end

	return true
end

function var_0_0.getCenterPosition(arg_33_0)
	local var_33_0 = gohelper.findChild(arg_33_0, "container/buildingGO/center")

	return var_33_0 and var_33_0.transform.position or arg_33_0.transform.position
end

return var_0_0
