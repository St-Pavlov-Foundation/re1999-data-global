module("modules.logic.room.model.map.RoomMapBlockModel", package.seeall)

local var_0_0 = class("RoomMapBlockModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:_clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_clearData()
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)
	arg_3_0:_clearData()
end

function var_0_0._clearData(arg_4_0)
	arg_4_0._mapBlockMOList = {}
	arg_4_0._mapBlockMODict = {}

	if arg_4_0._emptyBlockModel then
		arg_4_0._emptyBlockModel:clear()
	end

	arg_4_0._emptyBlockModel = BaseModel.New()

	if arg_4_0._fullBlockModel then
		arg_4_0._fullBlockModel:clear()
	end

	arg_4_0._fullBlockModel = BaseModel.New()
	arg_4_0._tempBlockMO = nil
	arg_4_0._emptyId = -1000
	arg_4_0._convexHull = nil
	arg_4_0._convexHexPointDict = nil
	arg_4_0._isBackMore = false

	if arg_4_0._backBlockModel then
		arg_4_0._backBlockModel:clear()
	end

	arg_4_0._backBlockModel = BaseModel.New()
end

function var_0_0.getBackBlockModel(arg_5_0)
	return arg_5_0._backBlockModel
end

function var_0_0.isCanBackBlock(arg_6_0)
	if arg_6_0._backBlockModel:getCount() < 1 then
		return false
	end

	if RoomEnum.IsBlockNeedConnInit then
		local var_6_0 = arg_6_0:getFullListNoTempBlockMO()
		local var_6_1 = arg_6_0._backBlockModel:getList()

		if RoomBackBlockHelper.isCanBack(var_6_0, var_6_1) then
			return true
		end

		return false
	end

	if RoomBackBlockHelper.isHasInitBlock(arg_6_0._backBlockModel:getList()) then
		return false
	end

	return true
end

function var_0_0.getFullListNoTempBlockMO(arg_7_0)
	if not arg_7_0:getTempBlockMO() then
		return arg_7_0._fullBlockModel:getList()
	end

	local var_7_0 = {}

	tabletool.addValues(var_7_0, arg_7_0._fullBlockModel:getList())
	tabletool.removeValue(var_7_0, arg_7_0:getTempBlockMO())

	return var_7_0
end

function var_0_0.backBlockById(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getFullBlockMOById(arg_8_1)

	if var_8_0 then
		var_8_0:setOpState(RoomBlockEnum.OpState.Normal)
		arg_8_0:_removeBlockMO(var_8_0)
		arg_8_0._backBlockModel:remove(var_8_0)
		arg_8_0:_placeOneEmptyBlock(var_8_0.hexPoint)

		return var_8_0
	end
end

function var_0_0.isBackMore(arg_9_0)
	return arg_9_0._isBackMore
end

function var_0_0.setBackMore(arg_10_0, arg_10_1)
	arg_10_0._isBackMore = arg_10_1 == true
end

function var_0_0.initMap(arg_11_0, arg_11_1)
	arg_11_0:clear()

	if not arg_11_1 or #arg_11_1 <= 0 then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		if iter_11_1.use ~= false then
			local var_11_0 = RoomInfoHelper.serverInfoToBlockInfo(iter_11_1)
			local var_11_1 = RoomBlockMO.New()

			var_11_1:init(var_11_0)
			arg_11_0:_addBlockMO(var_11_1)
		end
	end

	arg_11_0:_refreshEmpty()
	arg_11_0:_refreshConvexHull()
end

function var_0_0._refreshEmpty(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = arg_12_0._fullBlockModel:getList()

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		local var_12_2 = iter_12_1.hexPoint

		for iter_12_2 = 1, RoomBlockEnum.EmptyBlockDistanceStyleCount do
			local var_12_3 = var_12_2:getOnRanges(iter_12_2)
			local var_12_4 = iter_12_2

			for iter_12_3, iter_12_4 in ipairs(var_12_3) do
				var_12_0[iter_12_4.x] = var_12_0[iter_12_4.x] or {}
				var_12_0[iter_12_4.x][iter_12_4.y] = math.min(var_12_0[iter_12_4.x][iter_12_4.y] or RoomBlockEnum.EmptyBlockDistanceStyleCount, var_12_4)
			end
		end
	end

	local var_12_5 = 0

	for iter_12_5, iter_12_6 in pairs(var_12_0) do
		for iter_12_7, iter_12_8 in pairs(iter_12_6) do
			local var_12_6 = arg_12_0:getBlockMO(iter_12_5, iter_12_7)

			var_12_5 = var_12_5 + 1

			if var_12_6 then
				arg_12_0:_refreshEmptyMO(var_12_6, iter_12_8)
			else
				arg_12_0:_placeOneEmptyBlock(HexPoint(iter_12_5, iter_12_7), iter_12_8)
			end
		end
	end
end

function var_0_0._placeEmptyBlock(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.hexPoint:getInRanges(RoomBlockEnum.EmptyBlockDistanceStyleCount, true)

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_1 = arg_13_0:getBlockMO(iter_13_1.x, iter_13_1.y)

		if var_13_1 then
			arg_13_0:_refreshEmptyMO(var_13_1)
		else
			arg_13_0:_placeOneEmptyBlock(iter_13_1)
		end
	end
end

function var_0_0._placeOneEmptyBlock(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0:_getEmptyGUID(arg_14_1.x, arg_14_1.y)
	local var_14_1 = arg_14_0._emptyBlockModel:getById(var_14_0)

	if var_14_1 then
		var_14_1.distanceStyle = arg_14_2

		arg_14_0:_addBlockMOToMapDict(var_14_1)
	else
		var_14_1 = RoomBlockMO.New()

		local var_14_2 = RoomInfoHelper.generateEmptyMapBlockInfo(var_14_0, arg_14_1.x, arg_14_1.y, arg_14_2)

		var_14_1:init(var_14_2)
		arg_14_0:_addBlockMO(var_14_1)
	end

	arg_14_0:_refreshEmptyMO(var_14_1, arg_14_2)
end

function var_0_0._addBlockMOToMapDict(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.hexPoint

	arg_15_0._mapBlockMODict[var_15_0.x] = arg_15_0._mapBlockMODict[var_15_0.x] or {}
	arg_15_0._mapBlockMODict[var_15_0.x][var_15_0.y] = arg_15_1

	table.insert(arg_15_0._mapBlockMOList, arg_15_1)
end

function var_0_0._addBlockMO(arg_16_0, arg_16_1)
	arg_16_0:_addBlockMOToMapDict(arg_16_1)

	if arg_16_1.blockState == RoomBlockEnum.BlockState.Water then
		arg_16_0._emptyBlockModel:addAtLast(arg_16_1)
	else
		arg_16_0._fullBlockModel:addAtLast(arg_16_1)
	end
end

function var_0_0._removeBlockMO(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.hexPoint

	if arg_17_0._mapBlockMODict[var_17_0.x] then
		arg_17_0._mapBlockMODict[var_17_0.x][var_17_0.y] = nil
	end

	local var_17_1 = tabletool.indexOf(arg_17_0._mapBlockMOList, arg_17_1)

	if var_17_1 then
		table.remove(arg_17_0._mapBlockMOList, var_17_1)
	end

	if arg_17_1.blockState == RoomBlockEnum.BlockState.Water then
		arg_17_0._emptyBlockModel:remove(arg_17_1)
	else
		arg_17_0._fullBlockModel:remove(arg_17_1)
	end
end

function var_0_0.addTempBlockMO(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0._tempBlockMO then
		logError("暂不支持两个临时地块")

		return
	end

	local var_18_0 = arg_18_0:getBlockMO(arg_18_2.x, arg_18_2.y)

	if var_18_0 then
		arg_18_0:_removeBlockMO(var_18_0)
	end

	local var_18_1 = RoomInfoHelper.blockMOToBlockInfo(arg_18_1)

	arg_18_0._tempBlockMO = RoomBlockMO.New()
	var_18_1.blockState = RoomBlockEnum.BlockState.Temp
	var_18_1.x = arg_18_2.x
	var_18_1.y = arg_18_2.y

	arg_18_0._tempBlockMO:init(var_18_1)
	arg_18_0:_addBlockMO(arg_18_0._tempBlockMO)

	return arg_18_0._tempBlockMO
end

function var_0_0.getTempBlockMO(arg_19_0)
	return arg_19_0._tempBlockMO
end

function var_0_0.changeTempBlockMO(arg_20_0, arg_20_1, arg_20_2)
	if not arg_20_0._tempBlockMO then
		return
	end

	arg_20_0._tempBlockMO.rotate = arg_20_2

	if arg_20_0._tempBlockMO.hexPoint ~= arg_20_1 then
		local var_20_0 = HexPoint(arg_20_0._tempBlockMO.hexPoint.x, arg_20_0._tempBlockMO.hexPoint.y)
		local var_20_1 = arg_20_0:getBlockMO(arg_20_1.x, arg_20_1.y)

		if var_20_1 then
			arg_20_0:_removeBlockMO(var_20_1)
		end

		arg_20_0:_removeBlockMO(arg_20_0._tempBlockMO)

		arg_20_0._tempBlockMO.hexPoint = arg_20_1

		arg_20_0:_addBlockMO(arg_20_0._tempBlockMO)
		arg_20_0:_placeOneEmptyBlock(var_20_0)
	end
end

function var_0_0.removeTempBlockMO(arg_21_0)
	if not arg_21_0._tempBlockMO then
		return
	end

	local var_21_0 = arg_21_0._tempBlockMO.hexPoint

	arg_21_0:_removeBlockMO(arg_21_0._tempBlockMO)
	arg_21_0:_placeOneEmptyBlock(var_21_0)

	arg_21_0._tempBlockMO = nil
end

function var_0_0.placeTempBlockMO(arg_22_0, arg_22_1)
	if not arg_22_0._tempBlockMO then
		return
	end

	local var_22_0 = RoomBlockMO.New()
	local var_22_1 = RoomInfoHelper.serverInfoToBlockInfo(arg_22_1)

	var_22_0:init(var_22_1)

	arg_22_0._tempBlockMO.rotate = var_22_0.rotate
	arg_22_0._tempBlockMO.blockState = RoomBlockEnum.BlockState.Map

	arg_22_0:_placeEmptyBlock(arg_22_0._tempBlockMO)

	arg_22_0._tempBlockMO = nil

	arg_22_0:_refreshConvexHull()
end

function var_0_0.getBlockMO(arg_23_0, arg_23_1, arg_23_2)
	return arg_23_0._mapBlockMODict[arg_23_1] and arg_23_0._mapBlockMODict[arg_23_1][arg_23_2]
end

function var_0_0.getBlockMOList(arg_24_0)
	return arg_24_0._mapBlockMOList
end

function var_0_0.getBlockMODict(arg_25_0)
	return arg_25_0._mapBlockMODict
end

function var_0_0.getEmptyBlockMOList(arg_26_0)
	return arg_26_0._emptyBlockModel:getList()
end

function var_0_0.getFullBlockMOList(arg_27_0)
	return arg_27_0._fullBlockModel:getList()
end

function var_0_0.getEmptyBlockMOById(arg_28_0, arg_28_1)
	return arg_28_0._emptyBlockModel:getById(arg_28_1)
end

function var_0_0.getFullBlockMOById(arg_29_0, arg_29_1)
	return arg_29_0._fullBlockModel:getById(arg_29_1)
end

function var_0_0.getFullBlockCount(arg_30_0)
	local var_30_0 = arg_30_0._fullBlockModel:getCount()

	if arg_30_0._tempBlockMO then
		var_30_0 = var_30_0 - 1
	end

	return var_30_0
end

function var_0_0.getConfirmBlockCount(arg_31_0)
	local var_31_0 = 0
	local var_31_1 = arg_31_0._fullBlockModel:getList()

	for iter_31_0, iter_31_1 in ipairs(var_31_1) do
		if iter_31_1.blockState == RoomBlockEnum.BlockState.Map and iter_31_1.blockId > 0 then
			var_31_0 = var_31_0 + 1
		end
	end

	return var_31_0
end

function var_0_0.getMaxBlockCount(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_1 or RoomMapModel.instance:getRoomLevel()
	local var_32_1 = RoomConfig.instance:getRoomLevelConfig(var_32_0) or RoomConfig.instance:getRoomLevelConfig(RoomConfig.instance:getMaxRoomLevel())

	return (var_32_1 and var_32_1.maxBlockCount or 0) + arg_32_0:getTradeBlockCount()
end

function var_0_0.getTradeBlockCount(arg_33_0)
	local var_33_0 = ManufactureModel.instance:getTradeLevel()
	local var_33_1 = ManufactureConfig.instance:getTradeLevelCfg(var_33_0, false)

	return var_33_1 and var_33_1.addBlockMax or 0
end

function var_0_0._refreshConvexHull(arg_34_0)
	arg_34_0._convexHull = {}

	local var_34_0 = arg_34_0._fullBlockModel:getList()
	local var_34_1 = {}

	for iter_34_0, iter_34_1 in ipairs(var_34_0) do
		if iter_34_1.blockState == RoomBlockEnum.BlockState.Map then
			local var_34_2 = iter_34_1.hexPoint
			local var_34_3 = HexMath.hexToPosition(var_34_2, RoomBlockEnum.BlockSize)
			local var_34_4 = RoomBlockEnum.BlockSize * 3

			table.insert(var_34_1, var_34_3 + Vector2(1.1546 * var_34_4, 0))
			table.insert(var_34_1, var_34_3 + Vector2(0.5773 * var_34_4, -var_34_4))
			table.insert(var_34_1, var_34_3 + Vector2(-0.5773 * var_34_4, -var_34_4))
			table.insert(var_34_1, var_34_3 + Vector2(-1.1546 * var_34_4, 0))
			table.insert(var_34_1, var_34_3 + Vector2(-0.5773 * var_34_4, var_34_4))
			table.insert(var_34_1, var_34_3 + Vector2(0.5773 * var_34_4, var_34_4))
		end
	end

	arg_34_0._convexHull = RoomCameraHelper.getConvexHull(var_34_1)

	local var_34_5 = RoomCameraHelper.expandConvexHull(arg_34_0._convexHull, RoomBlockEnum.BlockSize * 10)

	arg_34_0._convexHexPointDict = RoomCameraHelper.getConvexHexPointDict(var_34_5)
end

function var_0_0.getConvexHull(arg_35_0)
	if not arg_35_0._convexHull then
		arg_35_0:_refreshConvexHull()
	end

	return arg_35_0._convexHull
end

function var_0_0.getConvexHexPointDict(arg_36_0)
	if not arg_36_0._convexHexPointDict then
		arg_36_0:_refreshConvexHull()
	end

	return arg_36_0._convexHexPointDict
end

function var_0_0._getEmptyGUID(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = CommonConfig.instance:getConstNum(ConstEnum.RoomMapMaxRadius) + 1
	local var_37_1 = (arg_37_1 + var_37_0) * 2 * var_37_0 + arg_37_2 + var_37_0

	return arg_37_0._emptyId - var_37_1
end

function var_0_0.refreshNearRiver(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_1:getInRanges(arg_38_2)

	for iter_38_0, iter_38_1 in ipairs(var_38_0) do
		local var_38_1 = arg_38_0:getBlockMO(iter_38_1.x, iter_38_1.y)

		if var_38_1 and var_38_1.blockState ~= RoomBlockEnum.BlockState.Water then
			var_38_1:refreshRiver()
		end
	end
end

function var_0_0._refreshEmptyMO(arg_39_0, arg_39_1, arg_39_2)
	return
end

function var_0_0.debugConfirmPlaceBlock(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = RoomBlockMO.New()

	var_40_0:init(arg_40_2)

	local var_40_1 = arg_40_0:getBlockMO(arg_40_1.x, arg_40_1.y)

	if var_40_1 then
		arg_40_0:_removeBlockMO(var_40_1)
	end

	arg_40_0:_addBlockMO(var_40_0)
	arg_40_0:_placeEmptyBlock(var_40_0)
	arg_40_0:_refreshConvexHull()

	return var_40_0, var_40_1
end

function var_0_0.debugRootOutBlock(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0:getBlockMO(arg_41_1.x, arg_41_1.y)

	if var_41_0 then
		arg_41_0:_removeBlockMO(var_41_0)
	end

	local var_41_1 = arg_41_1:getInRanges(RoomBlockEnum.EmptyBlockDistanceStyleCount, true)
	local var_41_2 = {}

	for iter_41_0, iter_41_1 in ipairs(var_41_1) do
		local var_41_3 = false
		local var_41_4 = arg_41_0:getBlockMO(iter_41_1.x, iter_41_1.y)

		if var_41_4 and var_41_4.blockState == RoomBlockEnum.BlockState.Water then
			local var_41_5 = false
			local var_41_6 = iter_41_1:getInRanges(RoomBlockEnum.EmptyBlockDistanceStyleCount, true)

			for iter_41_2, iter_41_3 in ipairs(var_41_6) do
				local var_41_7 = arg_41_0:getBlockMO(iter_41_3.x, iter_41_3.y)

				if var_41_7 and var_41_7.blockState == RoomBlockEnum.BlockState.Map then
					var_41_5 = true

					break
				end
			end

			if var_41_5 then
				arg_41_0:_refreshEmptyMO(var_41_4)
			else
				arg_41_0:_removeBlockMO(var_41_4)
				table.insert(var_41_2, var_41_4)
			end
		elseif var_41_4 and var_41_4.blockState == RoomBlockEnum.BlockState.Map then
			var_41_3 = true
		end

		if var_41_3 then
			arg_41_0:_placeOneEmptyBlock(arg_41_1)
		end
	end

	arg_41_0:_refreshConvexHull()

	return var_41_2
end

function var_0_0.getFullMapSizeAndCenter(arg_42_0)
	local var_42_0 = 0
	local var_42_1 = 0
	local var_42_2 = 0
	local var_42_3 = 0

	for iter_42_0, iter_42_1 in ipairs(arg_42_0._mapBlockMOList) do
		local var_42_4 = iter_42_1.hexPoint
		local var_42_5 = HexMath.hexToPosition(var_42_4, RoomBlockEnum.BlockSize)

		var_42_0 = math.max(var_42_0, var_42_5.x)
		var_42_1 = math.max(var_42_1, var_42_5.y)
		var_42_2 = math.min(var_42_2, var_42_5.x)
		var_42_3 = math.min(var_42_3, var_42_5.y)
	end

	local var_42_6 = math.floor((var_42_0 - var_42_2) * RoomEnum.WorldPosToAStarMeshWidth)
	local var_42_7 = math.floor((var_42_1 - var_42_3) * RoomEnum.WorldPosToAStarMeshDepth)
	local var_42_8 = 0
	local var_42_9 = 0
	local var_42_10 = math.min(var_42_6, RoomEnum.AStarMeshMaxWidthOrDepth)
	local var_42_11 = math.min(var_42_7, RoomEnum.AStarMeshMaxWidthOrDepth)
	local var_42_12 = (var_42_0 + var_42_2) * 0.5
	local var_42_13 = (var_42_1 + var_42_3) * 0.5

	return var_42_10, var_42_11, var_42_12, var_42_13
end

var_0_0.instance = var_0_0.New()

return var_0_0
